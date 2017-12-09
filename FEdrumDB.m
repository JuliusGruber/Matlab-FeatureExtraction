dirName ='C:\Users\Julius Gruber\Dropbox\Master\matlab\Datenbank\DrumDB';
fileInformationArray = getAllFileNames(dirName);
nxd = [];



for k =1: length(fileInformationArray)
   currentFilePath = fileInformationArray{k,1};
   
   indexOfSlashes = strfind(currentFilePath, '\');
   indexOfLastSlash = indexOfSlashes(end);
   indexOfFolderSlash = indexOfSlashes(end -1);
   
   
   
   currentFileName = currentFilePath(indexOfLastSlash+1 : end);
   fileInformationArray{k,2} = currentFileName;
      
    currentClassName = currentFilePath(indexOfFolderSlash+1 : indexOfLastSlash-1);  
    fileInformationArray{k,3} = currentClassName;
   
   
   
   if strcmp(currentClassName,'BassDrum') == 1 
       fileInformationArray{k,4} = 0;
   end
   if strcmp(currentClassName,'HighHat') == 1 
      fileInformationArray{k,4} = 1;
   end
    if strcmp(currentClassName,'SnareDrum') == 1 
      fileInformationArray{k,4} = 2;
    end
    
  
   
   
 
end

% nxd = calculateMirFeatures2(fileInformationArray);





nxdStruct = load('drumDBFeatures.mat');
nxd = nxdStruct.nxd;

names = char(fileInformationArray{:,3});
myColorMap = [1 0 0
        0 1 0
        0 0 1];


% set Paramters
no_dims = 2;
initial_dims = 60;
perplexity = 60;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults
figure();
gscatter(mappedX(:,1), mappedX(:,2), names, myColorMap);
figure();
gscatter(mappedX(:,1), mappedX(:,2));

viewPortTransformAndCreateTXTfile(mappedX, fileInformationArray);