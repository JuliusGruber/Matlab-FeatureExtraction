% Load the kNN speech-music model
% (only the features will be used here for training / evaluating the SVM):
load modelSM;

% Get the features to matrix (rows correspond to samples):
F       = [Features{1}, Features{2}]';

% Define the class labels (speech - music):
Labels  = cell(size(Features{1}, 2) + size(Features{2}, 2), 1);
Labels(1:size(Features{1}, 2))      = {'Speech'};
Labels(size(Features{1}, 2)+1:end)  = {'Music'};
numOfSamples = length(Labels);              % total number of samples
randPerm     = randperm(numOfSamples);      % rand indices

% training samples and labels (half of the data):
Ftrain       = F(randPerm(1:numOfSamples/2), :);   
LabelsTrain  = Labels(randPerm(1:numOfSamples/2));

% testing samples and labels (remaining half):
Ftest        = F(randPerm(numOfSamples/2+1:end), :);
LabelsTest   = Labels(randPerm(numOfSamples/2+1:end));

% train the SVM classifier (default values used):
svmStruct = svmtrain(Ftrain, LabelsTrain);

% test the SVM classifier:
LabelsFound = svmclassify(svmStruct, Ftest);    

% compute accuracy 
% (number of correctly classified samples / total number of testing samples):
Accuracy    = length(find(strcmp(LabelsFound, LabelsTest))==1) ...
    / length(LabelsFound) 