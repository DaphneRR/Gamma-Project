%% p_Create_Mat
function [s_SessNum] = p_Create_MatVar(Expe_Date, EventOther, s_SessNum,str_PatPath)

global s_SessNum_All s_SessNumCount


disp(['current experiment is: ' Expe_Date])
ncellstart = 1;
ncellend = 1;
nScreenStart = 1;
nScreenEnd = 1;
BL = 0;
a = 1;
%% CHECK that everything is as expected. If not, try and DEBUG.
while a == 1 %possibility to loop and debug several times.
    
    npoints = 1;
    %Test Event events occur at the beginning of each session. Counting
    %them and comparing to the expected number (3 if screening + 2
    %sessions, 2 if only 2 sessions)
    for check_cells = 1:length(EventOther(:,1))
        if strcmp(EventOther{check_cells,1},'Test Event') == 1
            Starting_Points(npoints, 1) = check_cells;
            npoints = npoints + 1;
        end
    end
    disp ' '
    if (s_SessNum ~= 1 && length(Starting_Points) == 2) ||...
            (s_SessNum == 1 && length(Starting_Points) == 3)
        disp 'Detected no abnormalities. Proceeding...'
        a = 0;
        break
    end
    %% ABNORMALITY DETECTED.
    disp '/!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ '
    disp(['There are ' num2str(length(Starting_Points)) ' ''Test Event'''])
    if s_SessNum == 1
        disp 'when there should be 3.'
    else
        disp 'when there should be 2.'
    end
    disp 'Check excel file before continuing. Determine which '
    disp '''Test Event'' are relevant.'
    disp(Starting_Points)
    
    % The excel file is already written. You can check what
    % happened there, and choose Test Events to keep.
    % Keeping a Test event equals saving the following session,
    % until a 'session end' is reached. Baseline timestamps are
    % saved as well as Start/Stop Recording. Everything else is discarded.
    %
    % Should fix most abnormalities deriving from connexion problems etc.
    
    Session_correct = input('which ''Test Event'' should be kept?');
    % should be a vector [a,b] or [a,b,c]
    disp '****************************************************'
    nloop = 2;
    Good_Events(1,:) = EventOther(1,:);
    for ikeep = 1:length(Session_correct)
        for iloop = Session_correct(ikeep):length(EventOther)
            if strcmp(EventOther{iloop,1},'Test Event') == 1 && iloop ~= Session_correct(ikeep)
                break
            else
                
                Good_Events(nloop,:) = EventOther(iloop,:);
                nloop = nloop + 1;
                if strcmp(EventOther{iloop-1,1},'Eyes Closed - End')==1 && BL==0
                    
                    Good_Events(nloop,:) = EventOther(iloop-1,:);
                    Good_Events(nloop+1,:) = EventOther(iloop-2,:);
                    Good_Events(nloop+2,:) = EventOther(iloop-3,:);
                    Good_Events(nloop+3,:) = EventOther(iloop-4,:);
                    BL = 1;
                    nloop = nloop + 4;
                elseif strcmp(EventOther{iloop+1,1},'Eyes Open ')==1 && BL==0
                    Good_Events(nloop,:) = EventOther(iloop+1,:);
                    Good_Events(nloop+1,:) = EventOther(iloop+2,:);
                    Good_Events(nloop+2,:) = EventOther(iloop+3,:);
                    Good_Events(nloop+3,:) = EventOther(iloop+4,:);
                    BL = 1;
                    nloop = nloop + 4;
                end
                
                if isempty(strfind(EventOther{iloop,1},'session end')) == 0
                    if strcmp(EventOther{iloop+1,1},'Stopping Recording') == 1
                        Good_Events(nloop,:) = EventOther(iloop+1,:);
                    end
                    break
                end
            end
            if strcmp(EventOther{iloop,1},'Test Event') == 1 && iloop ~= Session_correct(ikeep)
                break
            end
        end
    end
    EventOther = Good_Events;
    disp '****************************************************'
    length(EventOther)
    disp_events = input('display event data for this experiment 0/1?');
    if disp_events == 1
        disp(EventOther)
    end
    disp '****************************************************'
    save('F:\EventOther.mat', 'EventOther')
    % Clean variables should be 227 lines long if screening, or 210. Here
    % time is given to verify that everything went well.
    a = input('Continue debugging 0/1?');
    % Press 1 if further debugging is needed/possible. Anything else to
    % keep going.
    disp '/!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\ '
end

%% Creating variables to save

% Looping through the clean variable EventOther and retrieving timestamps
% to create the desired .mat variables.

for icell = 1:length(EventOther(:,1))
    if strcmp(EventOther{icell,1},'UP') == 1
    disp(['Processing session ' num2str(s_SessNum) '.'])
        BL_pre(1,:) = [EventOther(icell,2) EventOther(icell+1,2)];
        
    elseif strcmp(EventOther{icell,1},'Eyes Open ') == 1
        baseline(1,1) = EventOther(icell,2);
    elseif strcmp(EventOther{icell,1},'Eyes Open - End') == 1
        baseline(1,2) = EventOther(icell,2);
        
    elseif strcmp(EventOther{icell,1},'Eyes Closed ') == 1
        baseline(2,1) = EventOther(icell,2);
    elseif strcmp(EventOther{icell,1},'Eyes Closed - End') == 1
        baseline(2,2) = EventOther(icell,2);
        
    elseif isempty(strfind(EventOther{icell,1},'block start')) == 0
        screening(nScreenStart,1) = EventOther(icell,2);
        nScreenStart = nScreenStart + 1;
    elseif isempty(strfind(EventOther{icell,1},'block end')) == 0 ||...
            (isempty(strfind(EventOther{icell,1},'session end')) == 0 && isempty(strfind(EventOther{icell - 1,1},'block')) == 0)
        screening(nScreenEnd,2) = EventOther(icell,2);
        nScreenEnd = nScreenEnd + 1;
        
    elseif isempty(strfind(EventOther{icell,1},'Trial start')) == 0
        session(ncellstart,1) = EventOther(icell,2);
        ncellstart = ncellstart + 1;
    elseif isempty(strfind(EventOther{icell,1},'trial end')) == 0 ||...
            (isempty(strfind(EventOther{icell,1},'session end')) == 0 && isempty(strfind(EventOther{icell - 1,1},'block')) == 1)
        session(ncellend,2) = EventOther(icell,2);
        ncellend = ncellend + 1;
    end
    % increment session number when needed.
    if isempty(strfind(EventOther{icell,1},'session end')) == 0 &&...
            isempty(strfind(EventOther{icell - 1,1},'block')) == 0
        continue
    elseif isempty(strfind(EventOther{icell,1},'session end')) == 0 &&...
            isempty(strfind(EventOther{icell - 1,1},'block')) == 1
        
        % save .mat variables if conditions are met.
        if s_SessNum == 1
            save([str_PatPath 'screening_' num2str(s_SessNum)],'screening');
        end
        if mod(s_SessNum, 2) == 1
            save([str_PatPath 'baseline_' num2str(s_SessNum)],'baseline');
        end
        
        save([str_PatPath 'BL_pre_' num2str(s_SessNum)],'BL_pre');
        save([str_PatPath 'session_' num2str(s_SessNum)],'session');
        
        if s_SessNumCount < length(s_SessNum_All)
            s_SessNumCount = s_SessNumCount + 1;
            s_SessNum = s_SessNum_All(s_SessNumCount);
        end
        ncellstart = 1;
        ncellend = 1;
        BL_pre = cell(1,2);
    end
    if strcmp(EventOther{icell,1},'Stopping Recording') == 1
        break
    end
end
disp(['all .mat files sucessfully exported to ' str_PatPath '.'])

