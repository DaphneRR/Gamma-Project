% p_SortEvents_from_NLX
%% Importing data from Neuralynx .nev
function [Expe_Date, EventOther] = p_SortEvents_Excel(str_PatPath, str_DataFile, Pat_ID)


Expe_Date = str_DataFile(9:16);
Pat_ID_xls = [Pat_ID '.xlsx'];

% Retrieving data from Nlx Events.nev file.
[TimeStamps, EventIDs, EventStrings] = Nlx2MatEV...
    ([str_PatPath str_DataFile 'Events.nev'], [1,1,0,0,1], 0,1,1);


count = 1;

% Removing TTL Events.
for istring = 1:length(EventStrings)
    if isempty(strfind(EventStrings{istring}, 'TTL')) == 1
        EventStrings_Expe(count) = EventStrings(istring) ;
        TimeStamps_Expe(count) = TimeStamps(istring) ;
        EventIDs_Expe(count) = EventIDs(istring) ;
        count = count + 1;
    end
end

% Reshaping to fit desired excel format.
EventStrings_Expe = reshape(EventStrings_Expe,length(EventStrings_Expe),1);
TimeStamps_Expe = reshape(TimeStamps_Expe,length(TimeStamps_Expe),1);
TimeStamps_Expe = num2cell(TimeStamps_Expe);
EventIDs_Expe = reshape(EventIDs_Expe,length(EventIDs_Expe),1);
EventIDs_Expe = num2cell(EventIDs_Expe);

% Simple check
if length(EventIDs_Expe) == length(TimeStamps_Expe)...
        && length(TimeStamps_Expe) == length(EventStrings_Expe)
    
    disp 'Data imported, Relevant information extracted,'
    disp 'matching dimensions after reshape. Success.'
end


%% Sorting events

EventSuccess = cell(length(EventStrings_Expe),2);
EventOther = cell(length(EventStrings_Expe),2);

nsuccess = 1;
nOther = 1;

disp '***********************************************************'
disp '***********************************************************'
disp(['Processing data from ' Expe_Date '.'])
for icell = 1:length(EventStrings_Expe)

    if isempty(strfind(EventStrings_Expe{icell},'success')) == 0
        EventSuccess(nsuccess,1) = EventStrings_Expe(icell);
        EventSuccess(nsuccess,2) = TimeStamps_Expe(icell);
        nsuccess = nsuccess + 1;
        
    elseif isempty(strfind(EventStrings_Expe{icell},'success')) == 1
        if isempty(strfind(EventStrings_Expe{icell},'Event')) == 0
            nsuccess = nOther;
            EventSuccess(nsuccess,1) = EventStrings_Expe(icell);
            EventSuccess(nsuccess,2) = TimeStamps_Expe(icell);
            nsuccess = nsuccess + 1;
            EventOther(nOther,1) = EventStrings_Expe(icell);
            EventOther(nOther,2) = TimeStamps_Expe(icell);
            nOther = nOther + 1;
        else
            EventOther(nOther,1) = EventStrings_Expe(icell);
            EventOther(nOther,2) = TimeStamps_Expe(icell);
            nOther = nOther + 1;
        end
    end
end

% Creating empty column for excel readability
Empty_Column = cell(length(EventOther),1);
% Creating variable to be exported.
Sheet_Data = [EventStrings_Expe EventIDs_Expe TimeStamps_Expe...
    Empty_Column EventOther...
    Empty_Column EventSuccess];

%% Exporting sorted events to excel file
[status,message] = xlswrite([str_PatPath Pat_ID_xls], Sheet_Data, Expe_Date);
if status ~=1
    disp(status)
    disp(message)
    error('Could not export data to Excel File.')
end

