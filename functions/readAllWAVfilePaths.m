function files = readAllWAVfilePaths( dirName )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

files = dir( fullfile(dirName,'*.wav') );   %# list all *.xyz files

%files = setfield(files,'fullFilePath',strcat(dirName, files.name))


for k =1: length(files)
 [files(k).fullFilePath] =  strcat(dirName, files(k).name);

% files.(fullFilePath) = strcat(dirName, files.name)

                   


end

