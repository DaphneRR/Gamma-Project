% p_OneSessionEvo


clc; close all; clear all; close all;

str_PatPath = 'G:\Pat_01-2015\';
str_AllFolders = {'02222_2015-01-30_11-17',
    '02222_2015-01-30_11-17'
    '02222_2015-01-31_11-17'
    '02222_2015-01-31_11-17'
    '02222_2015-02-01_11-17' 
    '02222_2015-02-01_11-17'
    '02222_2015-02-06_09-47'};
s_SSBy = 8; 

str_TestChan = 'AmT2_1.ncs';


% fmin = 30;
% fmax = 80;

fmin = 60;
fmax = 80;
% fmin = 80;
% fmax = 140;

nsess = 6;
method = 'envelop';  % envelop, power
relOrabs = 'abs'; % 'rel', 'abs'
alg = 'abs';
v_AllTrials = zeros(1,nsess);
m_TrialsAllSess = [];
m_AbsGammaAllSess = [];
for iSess = 1:nsess
    s_SessNum = iSess;
    str_Folder = str_AllFolders{iSess} ;
    str_Dir = fullfile(str_PatPath,str_Folder);
    cd(fullfile(str_PatPath, str_Folder));

    
    % baseline
    load([str_PatPath  'baseline_' num2str(s_SessNum)]);
%     load([str_PatPath  'BL_pre_' num2str(s_SessNum)]);
    trigBL = triggers(1,:); clear triggers;
    ExtractMode = 4;
    tmp_File = fullfile(str_Dir, [str_Folder '_' str_TestChan]);
    [ m_DataVolt, srate, Timestamps, nsamp ] = f_NcsPreProcess( tmp_File, ...
        ExtractMode, trigBL );
    srate = srate/s_SSBy;
    v_BL = m_DataVolt(1:s_SSBy:end);
    switch method
        case 'power'
            [ m_TF, time, freq, ~ ] = f_TF_new( ...
                v_BL, fmin, fmax, 2,  srate, alg, []); % 'abs', 'zs', 'zsn', '01'
            v_MeanBL = mean(m_TF,2);
            
        case 'envelop'
            v_Bands = fmin:10:fmax;
            m_EnvBL = zeros(numel(v_Bands)-1, 1);
            for iEnv = 1:numel(v_Bands)-1
                [ v_Env ] = f_Envelop( v_BL, srate, v_Bands(iEnv), v_Bands(iEnv+1), 'mv' ); %alg: 'bp', 'butt'
                m_EnvBL(iEnv,1) = mean(v_Env);
            end
    end
    
    % traning
    
    load([str_PatPath  'session_' num2str(s_SessNum) 'artfree']);
    ntrial = size(triggers,1);
    v_AllTrials(iSess) = ntrial;
    % fig_AllinOne = figure('units', 'normalized', 'position', [0 0 1 1]);
    v_TrialAve = zeros(1,ntrial);
    v_TrialAbs = zeros(1,ntrial);
    hSub = zeros(1,ntrial);
    for iTrial = 1:ntrial
        ExtractVec = triggers(iTrial,:);
        ExtractMode = 4;
        tmp_File = fullfile(str_Dir, [str_Folder '_' str_TestChan]);
        [ m_DataVolt, srate, Timestamps, nsamp ] = f_NcsPreProcess( tmp_File, ...
            ExtractMode, ExtractVec );
        srate = srate/s_SSBy;
        v_Sig = m_DataVolt(1:s_SSBy:end);
        v_SigPadded =  f_PaddingCAR(v_Sig,srate,'symm',2);
        
        
        switch method
            case 'power'
                [ m_TF, time, freq, ~ ] = f_TF_new( ...
                    v_SigPadded, fmin, fmax, 2,  srate, alg, []); % 'abs', 'zs', 'zsn', '01'
                m_Abs = m_TF(:,srate+1:end-srate);
                if strcmp(relOrabs, 'rel')
                    s_MeanTrial = mean(m_Abs./repmat(v_MeanBL,1,size(m_Abs,2)))*100;
                    s_MeanTrial = mean(s_MeanTrial);
                    
                elseif strcmp(relOrabs, 'abs')
                    s_MeanTrial = mean(m_Abs(:));
                end
                
%                 s_MeanTrial = mean(eval(['m_' alg](:));
            case 'envelop'
                m_Abs = zeros(numel(v_Bands)-1, 1);
                for iEnv = 1:numel(v_Bands)-1
                    [ v_Env ] = f_Envelop( v_SigPadded, srate, v_Bands(iEnv), v_Bands(iEnv+1), 'mv' ); %alg: 'bp', 'butt'
                    v_Env = v_Env(:,srate+1:end-srate);
                    m_Abs(iEnv,1) = mean(v_Env);
                end                
                
                if strcmp(relOrabs, 'rel')
                    s_MeanTrial = mean(m_Abs./m_EnvBL*100);
                elseif strcmp(relOrabs, 'abs')
                    s_MeanTrial = mean(m_Abs(:));
                end

  
        end
        
        v_TrialAve(iTrial) = s_MeanTrial;
        
        %     hSub(iTrial) = subplot(3,15,iTrial);
        %     imagesc(time, freq, m_TF);
        clear m_TF time freq
    end
    m_TrialsAllSess = [m_TrialsAllSess v_TrialAve];
    m_AbsGammaAllSess = [m_AbsGammaAllSess v_TrialAbs];
end

totaltrials = sum(v_AllTrials);
time = 1:totaltrials;
figure, 
plot(time, m_TrialsAllSess(1:end), '.k');
% plot(1:totaltrials, m_AbsGammaAllSess(1:end), '.k');
[r Pcorr] = corrcoef(time,m_TrialsAllSess);
Pcorr(1,2);

title(sprintf('%d - %d Hz, %d sess, %d trials, r = %1.2f, p = %1.3f', fmin, fmax, nsess, totaltrials, r(1,2), Pcorr(1,2)), 'fontsize', 16);
lsline
xlabel('trials');
ylabel([method ' ' relOrabs ' ' alg]);

