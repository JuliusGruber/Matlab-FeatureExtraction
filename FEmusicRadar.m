dirName ='C:\Users\Julius Gruber\Dropbox\Master\matlab\Datenbank\musicradar\musicradar-songwriter-samples';

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
   
   
   
%    if strcmp(currentClassName,'125BPM') == 1 
%        fileInformationArray{k,4} = 0;
%    end
%    if strcmp(currentClassName,'130BPM') == 1 
%       fileInformationArray{k,4} = 1;
%    end
    
    
  
   
   
 
end


% for k= 1: length(fileInformationArray)
%     
%     l= 1;
%     currentFilePath = fileInformationArray{k,1};
% 
% %     rms ENERGY
%     b= mirrms(currentFilePath);
%     nxd(k,l)= mirgetdata(b);
%     l= l+1;
%     
%     b= mirrms(currentFilePath, 'Median');
%     nxd(k,l) = mirgetdata(b);
%     l=l+1;
%     
% %     low energy rate
%     b= mirlowenergy(currentFilePath);
%     nxd(k,l) = mirgetdata(b);
%     l=l+1;
%     
%     b = mirlowenergy(currentFilePath,  'ASR');
%     nxd(k,l) = mirgetdata(b);
%     l=l+1;
% %   event density   
%     b= mireventdensity(currentFilePath);
%     nxd(k,l) = mirgetdata(b);
%     l=l+1;
%     
% %     zero crossing rate
%     b= mirzerocross(currentFilePath);
%     nxd(k,l) = mirgetdata(b);
%     l=l+1;
%     
% %    high frequency energy
%     b= mirrolloff(currentFilePath);
%     nxd(k,l) = mirgetdata(b);
%     l=l+1;
%     
%     b= mirbrightness(currentFilePath);
%     nxd(k,l) = mirgetdata(b);
%     l=l+1;
%     
% %     spectral statistics
%       b= mircentroid(currentFilePath);
%       nxd(k,l) = mirgetdata(b);
%       l=l+1;
%       b= mirspread(currentFilePath);
%        nxd(k,l) = mirgetdata(b);
%       l=l+1;
%       b= mirskewness(currentFilePath);
%        nxd(k,l) = mirgetdata(b);
%       l=l+1;
%       b=mirkurtosis(currentFilePath);
%        nxd(k,l) = mirgetdata(b);
%       l=l+1;
%       b= mirflatness(currentFilePath);
%        nxd(k,l) = mirgetdata(b);
%       l=l+1;
%       b=mirentropy(currentFilePath);
%        nxd(k,l) = mirgetdata(b);
%       l=l+1;
%       
% %       MFCCs
% 
%     b= mirmfcc(currentFilePath);
%     mfccData = mirgetdata(b);
%     for c = 1 : length(mfccData)
%         nxd(k,l) = mfccData(c,1);
%         l= l+1;
%         
%     end
%     
%     
% %   spectral regularity
%     b= mirregularity(currentFilePath);
%     nxd(k,l) = mirgetdata(b);
% 
%      
%     
% 
% end




%  nxd = calculateMirFeatures2(fileInformationArray);

nxdStruct = load('musicRadarFeatures.mat');
nxd = nxdStruct.nxd;

names = char(fileInformationArray{:,3});
myColorMap = [1 0 0
        0 1 0
        0 0 1];


% set Paramters
no_dims = 2;
initial_dims = 40;
perplexity = 20;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults
figure();
gscatter(mappedX(:,1), mappedX(:,2), names, myColorMap);
figure();
gscatter(mappedX(:,1), mappedX(:,2));



viewPortTransformAndCreateTXTfile(mappedX, fileInformationArray);