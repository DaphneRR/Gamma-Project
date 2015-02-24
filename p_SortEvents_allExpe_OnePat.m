clear all
clc
%% input patient ID and existing session numbers
Pat_ID = 'Pat_01-2015';
 global s_SessNum_All s_SessNumCount
 s_SessNum_All = 1:8;
 s_SessNumCount = 1;
%% Looking for relevant directories
str_PatPath = ['F:\' Pat_ID '\'];
cd(str_PatPath);

files = dir;
directoryNames = {files([files.isdir]).name};
directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}));
s_SessNum = s_SessNum_All(s_SessNumCount);

disp(['found ' num2str(length(directoryNames)) ' directories in given path.'])
disp(['for patient ' Pat_ID '.'])
disp(['directory names are ' directoryNames{:}])

for dirloop = 1:length(directoryNames)
    str_DataFile = [directoryNames{dirloop} '\'];
    % sorting events and saving sorted data to excel file
    [Expe_Date, EventOther] = p_SortEvents_Excel...
        (str_PatPath, str_DataFile, Pat_ID);
    disp '************************************************'
    disp '************************************************'
    disp ' '
    disp(['Exported ' Expe_Date ' to Excel as new sheet.'])
    disp ' '
    disp '               Creating Variables               '
    disp ' '
    %creating and saving .mat variables
    [s_SessNum] = p_Create_MatVar(Expe_Date, EventOther, s_SessNum, str_PatPath);
    disp(['Processing for ' str_DataFile ' complete.'])
    disp '************************************************'
end
disp(['Processing for ' Pat_ID ' complete'])
    disp '************************************************'
    disp '************************************************'
