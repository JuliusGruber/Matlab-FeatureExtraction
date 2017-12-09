% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\BD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\BD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\SD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\SD_2\';
dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\HH_1\';




computeFeatures =1;

%%%%%%%  T - SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% set Paramters, this feature set has 26 features
no_dims = 2;
initial_dims = 26;
perplexity = 5;

viewName = 'MIR_mfcc_mw_std';

if computeFeatures
filePathWAVs = readAllWAVfilePaths(dirName);
nxd = [];
fileInformationArray = {};
featureData = cell(size( 10, 10));   
    
for i = 1:size( filePathWAVs,1)
  mirAudio = miraudio(filePathWAVs(i).fullFilePath);


  fileInformationArray{i,1} = filePathWAVs(i).fullFilePath;
  fileInformationArray{i,2} =   filePathWAVs(i).name;

    featureData{i,1} = filePathWAVs(i).fullFilePath;


mfccStruct= mirstat(mirmfcc(mirAudio, 'Frame', 0.02, 's', 0.01, 's'));
valuesMean = mfccStruct.Mean;
valuesStd = mfccStruct.Std;

featureVector = [];

 
%  add MFCC 

 for l=1:length(valuesMean)
             featureVector(1,end+1)=valuesMean(l,1);
            
 end


 for l=1:length(valuesStd)
             featureVector(1,end+1)=valuesStd(l,1);
 end
 
 
     featureVectorHasNaN = ismember(1,isnan(featureVector));
     if featureVectorHasNaN
        strcat('NAN Warn for: ', filePathWAVs(i).fullFilePath)
     
     end
 
 
 
 nxd = [nxd; featureVector];
 
 %  add feature data for mat file
for k = 1: length(featureVector)
    featureData{i,k+1}=featureVector(1,k);
end


end
   
    
end




% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults

figure();
gscatter(mappedX(:,1), mappedX(:,2));


% essentiaViewPortTransformAndCreateTXTfile(mappedX, fileInformationArray, 'essentiaShortSound', dirName);
viewPortTransformAndCreateViewMatFile(mappedX, fileInformationArray, viewName, dirName);


%%%%%  STORE feature data %%%%%%

save([dirName viewName ], 'featureData');


