

dirName ='C:\Users\Julius Gruber\Documents\MATLAB\Master\Datenbank\myDBshortSounds';

stWin = 0.04;
stStep = 0.04;

mtWin = 1;
mtStep = 0.25;

% featureStatistics = {'mean', 'median', 'std', 'stdbymean' 'max', 'min'}; 

featureStatistics = {'mean'}; 

[FeaturesDir, FileNames] =  featureExtractionDirMyVersion(dirName, stWin, stStep, mtWin, mtStep, featureStatistics);


    X = [];
    for i=1:length(FeaturesDir)
        X = [X mean(FeaturesDir{i},2)];
    end
    
    % normalization is needed:
    MEAN = mean(X'); STD = std(X');
    
    for i=1:size(X,2)
        X(:,i) = (X(:,i)  - MEAN') ./ STD';
    end
    


% SOMLib Template Vector File: XXX.tv

numberOfColumnsInLayout = 2;
numberOfFeatureVectors= size(X,2);
numberOfFeatures = size(X,1);

fid = fopen('MFCCsMeanOnly.tv','w');
formatSpec = '%s\n%s %ld\n%s %ld\n%s %ld\n';
lineOne= '$TYPE template';
lineTwo = '$XDIM';
lineThree= '$YDIM';
lineFour= '$VEC_DIM';
fprintf(fid,formatSpec,lineOne, lineTwo, numberOfColumnsInLayout, lineThree, numberOfFeatureVectors, lineFour, numberOfFeatures );

formatSpec = '%d %s\n';
for i = 0 : numberOfFeatures-1
    featureNameString = strcat('feature', num2str(i));
    fprintf(fid,formatSpec, i, featureNameString);

end
fid = fclose(fid);








% SOMLib Input Vector File: XXX.vec

numberOfInputVectors = size(X,2);
yDim= 1;
dimensionalityOfVectors = size(X,1);


fid = fopen('MFCCsMeanOnly.vec','w');
formatSpec = '%s\n%s %ld\n%s %ld\n%s %ld\n';
lineOne= '$TYPE vec';
lineTwo = '$XDIM';
lineThree= '$YDIM';
lineFour = '$VEC_DIM';
fprintf(fid,formatSpec,lineOne, lineTwo, numberOfInputVectors, lineThree, yDim, lineFour, dimensionalityOfVectors );



formatSpecFileName = '%s\n';
formatSpecSingleFeature = '%.15f ';
for i = 1 : numberOfInputVectors
   
    for l = 1: dimensionalityOfVectors
        fprintf(fid,formatSpecSingleFeature,X(l, i));
    end
    
    modifiedStr = strrep(FileNames{1,i},'\', '/');
    fprintf(fid,formatSpecFileName,modifiedStr);
  
end
fid = fclose(fid);


% Class Information File 

classNames = {};

for k =1: length(FileNames)
   currentFileName = FileNames{1,k};
   
   indexOfSlashes = strfind(currentFileName, '\');
   indexOfLastSlash = indexOfSlashes(end);
   indexOfFolderSlash = indexOfSlashes(end -1);
   
   currentClassName = currentFileName(indexOfFolderSlash+1 : indexOfLastSlash-1)
   if strcmp(currentClassName,'Baby') == 1 
       classNames{k,1} = 0;
   end
   if strcmp(currentClassName,'Donner') == 1 
       classNames{k,1} = 1;
   end
    if strcmp(currentClassName,'Metal') == 1 
       classNames{k,1} = 2;
   end
    if strcmp(currentClassName,'Motoren') == 1 
       classNames{k,1} = 3;
    end
    if strcmp(currentClassName,'Singvögel') == 1 
       classNames{k,1} = 4;
    end
     if strcmp(currentClassName,'Sirene') == 1 
       classNames{k,1} = 5;
     end
    if strcmp(currentClassName,'Türklopfen') == 1 
       classNames{k,1} = 6;
   end
   if strcmp(currentClassName,'Wind') == 1 
       classNames{k,1} = 7;
   end
   if strcmp(currentClassName,'bellendeHunde') == 1 
       classNames{k,1} = 8;
   end
     if strcmp(currentClassName,'miauendeKatzen') == 1 
       classNames{k,1} = 9;
   end
   
   
   
   
   classNames{k,2} = currentClassName;
end


% numberOfClasses = 10;
% classNamesAsOneString = 'Baby Donner Metall Motoren Singvögel Sirene Türklopfen Wind bellendeHunde miauendeKatzen';
% numberOfEntitiesPerLine = 2;
% numberOfInputVectors = size(X,2);


fid = fopen('MFCCsMeanOnly.cls','w');
% formatSpec = '%s %ld\n%s %s\n%s %ld\n%s %ld\n';
% lineOne = '$NUM_CLASSES';
% lineTwo = '$CLASS_NAMES';
% lineThree = '$XDIM';
% lineFour = '$YDIM';
% 
% fprintf(fid,formatSpec,lineOne, numberOfClasses, lineTwo, classNamesAsOneString, lineThree, numberOfEntitiesPerLine, lineFour, numberOfInputVectors );




formatSpec = '%s\t%s\n';
for i = 1 : length(classNames)
    modifiedStr = strrep(FileNames{1,i},'\', '/');
    classNameString = modifiedStr;
%     classNameString = classNames{i,2};
%     classNumber =  uint8(classNames{i,1});
    currentClassName = classNames{i,2};
    fprintf(fid,formatSpec,  classNameString, currentClassName);

end


fid = fclose(fid);