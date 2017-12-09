% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\BD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\BD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\SD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\SD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\HH_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\P_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\M_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\M_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\FSD_1\';
dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_deltaMFCC_vs_mfcc\GSD_1\';


computeFeatures = 1;


%%%%%%%  T - SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% set Paramters this feature set has 78 features
no_dims = 2;
initial_dims = 78;
perplexity = 5;

viewName = 'mirMFCCmeanStdDelta';


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

frameDecomposedMFCC = mirmfcc(mirAudio, 'Frame', 0.02, 's', 0.01, 's');

mfccStruct= mirstat(mirmfcc(frameDecomposedMFCC));
valuesMean = mfccStruct.Mean;
valuesStd = mfccStruct.Std;


mfccDeltaStruct = mirstat(mirmfcc(frameDecomposedMFCC, 'Delta', 1));
valuesMeanDelta = mfccDeltaStruct.Mean;
valuesStdDelta = mfccDeltaStruct.Std;



mfccDeltaDeltaStruct = mirstat(mirmfcc(frameDecomposedMFCC, 'Delta', 2));
valuesMeanDeltaDelta = mfccDeltaDeltaStruct.Mean;
valuesStdDeltaDelta = mfccDeltaDeltaStruct.Std;



featureVector = [];

 
%  add MFCC mean 

 for l=1:length(valuesMean)
             featureVector(1,end+1)=valuesMean(l,1);
 end
 
% add MFCC standart deviation 
 for l=1:length(valuesStd)
             featureVector(1,end+1)=valuesStd(l,1);
 end
 

 
%  %%%%%%% Delta MFCCs are added here %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for l=1:length(valuesMeanDelta)
             featureVector(1,end+1)=valuesMeanDelta(l,1);
   end
  
   for l=1:length(valuesStdDelta)
             featureVector(1,end+1)=valuesStdDelta(l,1);
   end
    
 
  

%  %%%%%%% Delta Delta  MFCCs are added here %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     for l=1:length(valuesMeanDeltaDelta)
             featureVector(1,end+1)=valuesMeanDeltaDelta(l,1);
   end
  
   for l=1:length(valuesStdDeltaDelta)
             featureVector(1,end+1)=valuesStdDeltaDelta(l,1);
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

% Plot results

figure();
gscatter(mappedX(:,1), mappedX(:,2));


% essentiaViewPortTransformAndCreateTXTfile(mappedX, fileInformationArray, 'Spectral Envelope 3', dirName);
viewPortTransformAndCreateViewMatFile(mappedX, fileInformationArray, viewName, dirName);

%%%%%  STORE feature data %%%%%%

save([dirName viewName ], 'featureData');


