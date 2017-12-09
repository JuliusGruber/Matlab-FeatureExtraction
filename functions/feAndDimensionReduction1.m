function fileInformationArray = feAndDimensionReduction1(dirName )
%FEANDDIMENSIONREDUCTION Summary of this function goes here
%   Detailed explanation goes here
fileInformationArray = getAllFileNames(dirName);

for k =1: length(fileInformationArray)
   currentFilePath = fileInformationArray{k,1};
   
   indexOfSlashes = strfind(currentFilePath, '\');
   indexOfLastSlash = indexOfSlashes(end);
%    indexOfFolderSlash = indexOfSlashes(end -1);
   
   
   
   currentFileName = currentFilePath(indexOfLastSlash+1 : end);
   fileInformationArray{k,2} = currentFileName;
      
 
 
end


% Feature Extraction

nxd = calculateMirFeatures2(fileInformationArray);


% set Paramters for t-SNE
no_dims = 2;
initial_dims = 30;
perplexity = 30;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% viewportTransform
mappedXTransformed = viewportTransformTSNEcordiantes(mappedX);


for k =1: length(fileInformationArray)
     fileInformationArray{k,3} = mappedXTransformed(k,1);%x coordinate
     fileInformationArray{k,4} = mappedXTransformed(k,2);%y coordinate
     
end


end

