dirName ='C:\Users\Julius Gruber\Dropbox\Master\matlab\Datenbank\TenInstruments\Oboe';
listFileNames = getAllFileNames(dirName);
fileInformationArray = [];
nxd = [];


d = 1;
for k =1: length(listFileNames)
    currentFilePath = listFileNames{k,1};
   
   a = strfind(currentFilePath, '_1_') ;
   b = strfind(currentFilePath, 'piano');
   c = strfind(currentFilePath, 'pianissimo');
   e= strfind(currentFilePath, 'fortissimo');
   
%    Copy to fileInformationArray only if the sounds are 1 second long,
%    no piano, no pianissimo, no fortissimo sounds
   if(~isempty(a) && isempty(b)&& isempty(c)&&isempty(e))
       
   
   
   indexOfSlashes = strfind(currentFilePath, '\');
   indexOfLastSlash = indexOfSlashes(end);
   indexOfFolderSlash = indexOfSlashes(end -1);
   
   fileInformationArray{d,1} = currentFilePath;
   
   currentFileName = currentFilePath(indexOfLastSlash+1 : end);
   fileInformationArray{d,2} = currentFileName;
      
    currentClassName = currentFilePath(indexOfFolderSlash+1 : indexOfLastSlash-1);  
    fileInformationArray{d,3} = currentClassName;
   
   fileInformationArray{d,4} = 0;%fake class number, there are no classes for this folder
   d = d+1;
    end
    
  
   
   
 
end

% nxd = calculateMirFeatures2(fileInformationArray);





nxdStruct = load('oboeFeatures.mat');
nxd = nxdStruct.nxd;

names = char(fileInformationArray{:,3});
myColorMap = [1 0 0
        0 1 0
        0 0 1];


% set Paramters
no_dims = 2;
initial_dims = 50;
perplexity = 30;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults
figure();
gscatter(mappedX(:,1), mappedX(:,2), names, myColorMap);
figure();
gscatter(mappedX(:,1), mappedX(:,2));

viewPortTransformAndCreateTXTfile(mappedX, fileInformationArray);