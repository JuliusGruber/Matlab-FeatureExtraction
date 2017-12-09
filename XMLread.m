fileInformationArray = {};
nxd = [];

xmlfile = fullfile('C:\Users\Julius Gruber\Desktop\jAudioHighHatsSpectral.xml' );
 
% read DOM-tree 
dom = xmlread(xmlfile);
 
% get all data_set nodes : each sample has all its features stored in a
% dat-set node
elems = dom.getElementsByTagName('data_set');
for i = 0:elems.getLength-1
 
     fileInformationArray{i+1,1}  = char(elems.item(i).getElementsByTagName('data_set_id').item(0).getTextContent());
  
     
    valueList = elems.item(i).getElementsByTagName('v');
   
 
    
    featureVector = [];
    for  k = 0 : valueList.getLength-1
        featureVector (1, k+1) = str2double(valueList.item(k).getTextContent());
    end
 
  nxd = [nxd; featureVector];
end


for k =1: length(fileInformationArray)
   currentFilePath = fileInformationArray{k,1};
   
   indexOfSlashes = strfind(currentFilePath, '\');
   indexOfLastSlash = indexOfSlashes(end);
   indexOfFolderSlash = indexOfSlashes(end -1);
   
   
   
   currentFileName = currentFilePath(indexOfLastSlash+1 : end);
   fileInformationArray{k,2} = currentFileName;
      
    currentClassName = currentFilePath(indexOfFolderSlash+1 : indexOfLastSlash-1);  
    fileInformationArray{k,3} = currentClassName;
   
   fileInformationArray{k,4} = 0;%fake class number, there are no classes for this folder
   
 
    
  
   
   
 
end

names = char(fileInformationArray{:,3});
myColorMap = [1 0 0
        0 1 0
        0 0 1];


% set Paramters
no_dims = 2;
initial_dims = 26;
perplexity = 20;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults
figure();
gscatter(mappedX(:,1), mappedX(:,2), names, myColorMap);
figure();
gscatter(mappedX(:,1), mappedX(:,2));

viewPortTransformAndCreateTXTfile(mappedX, fileInformationArray);

