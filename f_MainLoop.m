function [] = f_MainLoop( st_hControl )

global s_Points

%% [ initialisation ]
[str_Server st_param st_output] = f_SetParam(st_hControl);
iBin = 1;
iBlockBin = 1;
trigNum = 1;
iBaseline = 1;
s_NlxConnPersistent = 0;
s_TimerMainLoop = 0.01; % CH
s_TimerDataProcessing = 0.38;
% s_TimerDataProcessing = 0.508;
str_NlxNetComMFilesPath = 'C:\codes\Neurofeedback_codes\Matlab_M-files';
addpath(str_NlxNetComMFilesPath);
v_MUA = [];
s_IsAcqActive = 1;
countdata = 0;
tmpTS = [];
s_DataCurrInd = 1;
s_FirstGlbInd = 1;
s_BuffSizeSec = 5;
s_BuffSizeSam = s_BuffSizeSec * st_param.srate; % CH
m_DataBuffer = zeros(1, s_BuffSizeSam); % CH


%% [ connecting to Neuralynx ]

if ~exist('st_CheetahObjects', 'var')
    st_CheetahObjects = [];
end
if ~s_NlxConnPersistent || ~NlxAreWeConnected()
    [s_IsNlxSrvConnected, st_CheetahObjects, ...
        st_CheetahChannObjects, st_CheetahSpikesObjects] = ...
        f_NlxInitConnection( st_CheetahObjects, str_Server, ...
        st_param.chan, st_param.spks );
end

if ~NlxAreWeConnected()
    display('[p_Online_Neurofeedback] - The connection with the Neuralynx machine is not established.')
    display('Please check the connection parameters and try again.');
    return;
end

if isempty(st_CheetahObjects)
    display('[p_Online_Neurofeedback] - No objects were initialized for real-time streaming!');
    return;
end


%% [ creating figures ]

if NlxAreWeConnected
    [st_param] = f_CreateFigure(st_param, []);
    f_Instructions(st_param);
end



%% [ main data loop ]

s_ElapsedTime = tic;
binSz = [];
while s_IsAcqActive
    for chan = 1: numel(st_CheetahChannObjects)
        [s_Ret, v_DataArrayChann, v_TimeStampArray, v_ChannelNumberArray, ...
            v_SamplingFreqArray, v_NumValidSamplesArray, s_NumRecordsReturned, ...
            s_NumRecordsDropped] = NlxGetNewCSCData(st_CheetahChannObjects{chan});
    end
    
    if s_NumRecordsReturned > 0 && ~isempty(v_DataArrayChann)
        s_DataSize = numel(v_DataArrayChann);
        s_FirstInd = s_DataCurrInd + 1;
        if s_FirstInd > s_BuffSizeSam
            s_FirstInd = 1;
        end
        s_LastInd = s_FirstInd + s_DataSize - 1;
        if s_LastInd > s_BuffSizeSam
            s_LastInd = s_DataSize - (s_BuffSizeSam - s_FirstInd + 1);
            v_Ind = [s_FirstInd:s_BuffSizeSam 1:s_LastInd];
        else
            v_Ind = s_FirstInd:s_LastInd;
        end
        m_DataBuffer(v_Ind) = v_DataArrayChann;
        s_DataCurrInd = s_LastInd;
        
        tmpTS = [tmpTS; v_TimeStampArray(1) v_TimeStampArray(end)];
        binSz = [binSz s_DataSize];
        countdata = countdata +1;
    else
        continue;
    end
    
    if toc(s_ElapsedTime) < s_TimerDataProcessing
        continue;
    end
    
    % update timer
    st_output.timer(iBin) = toc(s_ElapsedTime);
    s_ElapsedTime = tic;
    pause(s_TimerMainLoop);
    
    
    % update data index
    s_LastGlbInd = s_DataCurrInd;
    if s_FirstGlbInd >= s_LastGlbInd
        v_Ind = [s_FirstGlbInd:s_BuffSizeSam 1:s_LastGlbInd];
    else
        v_Ind = s_FirstGlbInd:s_LastGlbInd;
    end
    
    
    % update data & reset values
    st_output.nFill(iBin) = countdata;
    st_output.iterSz{iBin} = binSz;
    st_output.timestamps(iBin,:) = [tmpTS(1) tmpTS(end)];
    binSz = [];
    tmpTS = [];
    countdata = 0;
    v_Sig = m_DataBuffer(v_Ind);
    st_output.dataSz(iBin) = numel(v_Sig);
    s_FirstGlbInd = s_LastGlbInd + 1;
    
    
    %% [ pass data ]
    
    if isempty(iBaseline) && iBlockBin == 1
        f_SendTrigger('block start', 1, trigNum );
    end
    %     plot(v_Sig);
    
    %% [ analysis ]
    
    % signal subsampling
    v_SigSS = v_Sig(1,1:st_param.s_SubSamplFactor:end);
    clear v_Sig;
    
    % filtering & envelop calculation
    for iFreq = 1:st_param.nband
        [ v_Env ] = f_Envelop( v_SigSS, st_param.sssrate, ...
            st_param.fa1(iFreq), st_param.fa2(iFreq), 'bp' );
        s_AvgData = mean(v_Env);
        clear v_Env;
        if iBaseline <= st_param.nbinBL*2
            st_output.baseline(iBin, iFreq) = s_AvgData;
        end
        st_output.ballposition(iBin, iFreq) = s_AvgData;
        clear s_AvgData;
    end
    
    
    
    
    %% [ plot feedback ]
    
    if isempty(iBaseline)
        TmpPrev = mean(st_output.ballposition(iBin-st_param.smoothingbins:iBin-1,:));
        TmpNow = mean(st_output.ballposition(iBin-(st_param.smoothingbins-1):iBin,:));

        st_output.smoothed(iBin-st_param.nbinBL,:) = TmpNow;
%         disp(TmpNow);
        if TmpNow <= 500
        f_RewardSuccess(st_param, TmpNow, trigNum);
        st_output.info.points = s_Points;
        
        
        % cut epi-artefacts
        
        
        % avoid disappearing of the ball beyond threshold
        if TmpNow > st_param.s_ThreshPos
            [m_Balls2Plot] = f_InterpolationStatic(st_param);
        else % static interpolation
            [m_Balls2Plot] = f_Interpolation(st_param, TmpPrev, TmpNow);
%             [m_Balls2Plot] = f_Interpolation(st_param);
        end
        
        for iObject = 1:size(m_Balls2Plot,1)
            v_Tmp2Plot = m_Balls2Plot(iObject,:);
            f_DisplayBalls(st_param, v_Tmp2Plot);
            pause(0.001);
        end
        
        f_PlotHistory(st_output, st_param, iBin);
        else
            f_GrayBall;
        end
        
    end
    
    
    %% [ baseline ] - reset bin count after baseline
    
    if iBaseline < st_param.nbinBL
        iBaseline = iBaseline + 1;
    elseif iBaseline == st_param.nbinBL
        % update thresholds from baseline
        dataBL = st_output.baseline(1:st_param.nbinBL, 1)';
        [st_param] = f_CreateFigure(st_param, dataBL);
        iBaseline = [];
        %         iBin = 0;
        iBlockBin = 0;
    end
    
    
    if iBin == st_param.s_SessLen + st_param.nbinBL
        f_EndSession( st_param, trigNum, st_CheetahObjects );
        f_SaveOutput(st_param, st_output);
        break;
    end
    if iBlockBin == st_param.s_BlockLen,
        f_BlockEnd( st_param, trigNum);
        f_Reminder(st_param);
        trigNum = trigNum + 1;
        iBlockBin = 0;
    end
    
    % updating count within block and within session
    iBin = iBin + 1;
    iBlockBin = iBlockBin + 1;
    
end
end

