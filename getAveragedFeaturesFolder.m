%get all fileNames
dirName = 'C:\Users\Julius Gruber\Documents\MATLAB\Master\Datenbank\pacdv.com';
fileList = getAllFileNames(dirName);
%set the shortTermWindow Parameters
win = 0.04;
step = 0.04;




stFeatureDataMatrix = zeros(length(fileList),35);


% for i = 1: 5

for i = 1 : length(fileList)
    currentFileName = fileList(i);
    currentFileNameString = currentFileName{1}
    

    
    [currentAudioData, fs] = audioread(currentFileNameString);
    
    shortTermFeatures = stFeatureExtraction(currentAudioData, fs, win, step);
    meanStFeatures = mean(shortTermFeatures,2);
    meanStFeatures = transpose(meanStFeatures);
    
    stFeatureDataMatrix(i, :) = meanStFeatures;
    

end

filePathTable = table(fileList);
stFeatureTable = filePathTable;

numberOfFeatures = size(stFeatureDataMatrix,2);

for k = 1 : numberOfFeatures

tableVariableK = table(stFeatureDataMatrix(:, k));

variableNumberString = num2str(k);
featureName=strcat('Feature',variableNumberString);

tableVariableK.Properties.VariableNames{'Var1'} = featureName;

stFeatureTable = [stFeatureTable tableVariableK];

end

stFeatureTable.Properties.VariableNames{'fileList'} = 'filePath';
stFeatureTable.Properties.VariableNames{'Feature1'} = 'zcr';
stFeatureTable.Properties.VariableNames{'Feature2'} =  'energy';
stFeatureTable.Properties.VariableNames{'Feature3'} =   'energyEntropy';
stFeatureTable.Properties.VariableNames{'Feature4'} =    'spectral_centroid1';
stFeatureTable.Properties.VariableNames{'Feature5'} =     'spectral_centroid2';
stFeatureTable.Properties.VariableNames{'Feature6'} =     'spectral_entropy';
stFeatureTable.Properties.VariableNames{'Feature7'} =     'spectral_flux';
stFeatureTable.Properties.VariableNames{'Feature8'} =     'spectral_rolloff';
stFeatureTable.Properties.VariableNames{'Feature9'} =     'MFCC1';
stFeatureTable.Properties.VariableNames{'Feature10'} =     'MFCC2';
stFeatureTable.Properties.VariableNames{'Feature11'} =     'MFCC3';
stFeatureTable.Properties.VariableNames{'Feature12'} =     'MFCC4';
stFeatureTable.Properties.VariableNames{'Feature13'} =     'MFCC5';
stFeatureTable.Properties.VariableNames{'Feature14'} =     'MFCC6';
stFeatureTable.Properties.VariableNames{'Feature15'} =     'MFCC7';
stFeatureTable.Properties.VariableNames{'Feature16'} =     'MFCC8';
stFeatureTable.Properties.VariableNames{'Feature17'} =     'MFCC9';
stFeatureTable.Properties.VariableNames{'Feature18'} =     'MFCC10';
stFeatureTable.Properties.VariableNames{'Feature19'} =     'MFCC11';
stFeatureTable.Properties.VariableNames{'Feature20'} =     'MFCC12';
stFeatureTable.Properties.VariableNames{'Feature21'} =     'MFCC13';
stFeatureTable.Properties.VariableNames{'Feature22'} =     'harmonicHR';
stFeatureTable.Properties.VariableNames{'Feature23'} =     'harmonicF0';
stFeatureTable.Properties.VariableNames{'Feature24'} =     'chroma_vector';
stFeatureTable.Properties.VariableNames{'Feature25'} =     'chroma_vector2';
stFeatureTable.Properties.VariableNames{'Feature26'} =     'chroma_vector4';
stFeatureTable.Properties.VariableNames{'Feature27'} =     'chroma_vector5';
stFeatureTable.Properties.VariableNames{'Feature28'} =     'chroma_vector6';
stFeatureTable.Properties.VariableNames{'Feature29'} =     'chroma_vector7';
stFeatureTable.Properties.VariableNames{'Feature30'} =     'chroma_vector8';
stFeatureTable.Properties.VariableNames{'Feature31'} =     'chroma_vector9';
stFeatureTable.Properties.VariableNames{'Feature32'} =     'chroma_vector10';
stFeatureTable.Properties.VariableNames{'Feature33'} =     'chroma_vector11';
stFeatureTable.Properties.VariableNames{'Feature34'} =     'chroma_vector12';
stFeatureTable.Properties.VariableNames{'Feature35'} =     'chroma_vector13';



