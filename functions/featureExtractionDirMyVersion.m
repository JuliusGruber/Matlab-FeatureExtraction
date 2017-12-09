function [FeaturesDir, FileNames] =  featureExtractionDirMyVersion(dirName, stWin, stStep, mtWin, mtStep, featureStatistics)% #codegen 

%
% function [FeaturesDir, FileNames] =  featureExtractionDir(dirName, stWin, stStep, mtWin, mtStep, featureStatistics)
%
% Extracts mid term features for a list of WAV files stored in a given path
% 
% ARGUMENTS:
%  - dirName:           path of the folder that contains the WAV files
%  - stWin, stStep:     short-term window size and step (seconds)
%  - mtWin, mtStep:     mid-term window size and step (seconds)
%  - featureStatistics: list (cell array) of mid term statistics
%
% RETURNS:
%  - FeaturesDir:       cell array whose elements are feature matrices 
%                       e.g., FeaturesDir{10} contains the mid-term 
%                       feature matrix of the 10th file in the given
%                       directory +++
%  - FileNames:         cell array that contains the full paths of the 
%                       WAV files in the provided folder
% 
% (c) 2014 T. Giannakopoulos, A. Pikrakis, modified by Julius Gruber

% D = dir([dirName filesep '*.wav']);

% D = dir(dirName);

D = getAllFileNames(dirName);


for i=1:length(D)       % for each  file
    fprintf('Feature extraction for file %50s\n', D{i})
%     curName = [dirName filesep D(i).name];
    curName = D{i}; 
    FileNames{i} = curName;  % get current filename
    % extract mid-term features:
    [midFeatures, Centers, stFeaturesPerSegment] = ...
        featureExtractionFileMyVersion(curName, stWin, stStep, mtWin, mtStep, featureStatistics);
    FeaturesDir{i} = midFeatures;
    
end
