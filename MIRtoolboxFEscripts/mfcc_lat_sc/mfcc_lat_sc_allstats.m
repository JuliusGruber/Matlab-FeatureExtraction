
%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\BD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\BD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\SD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\SD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\HH_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\P_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\M_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\M_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\FSD_1\';
dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_mfcc_sc_lat_allstats\GSD_1\';


computeFeatures = 0;


%%%%%%%  T - SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% set Paramters this feature set has 57 features
no_dims = 2;
initial_dims = 57;
perplexity = 5;

viewName = 'mir_MFCC_lat_sc_allStats';


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
valuesSlope = mfccStruct.Slope;
valuesPeriodEntropy = mfccStruct.PeriodEntropy;


% %%%%%%%%%%%% lat %%%%%%%%%%%%%%%%%%%%%%%%
o = mironsets(filePathWAVs(i).fullFilePath,'Attack','Single', 'Filter' );
attackTime = mirgetdata(mirattacktime(o, 'Log'));


% %%%%%%%%% spectral centroid %%%%%%%%%%%%%%%%%


scStruct = mirstat(mircentroid(mirAudio, 'Frame', 0.02, 's', 0.01, 's'));

 
featureVector = [];

 
%  add MFCC mean 

 for l=1:length(valuesMean)
             featureVector(1,end+1)=valuesMean(l,1);
 end
 
% add MFCC standart deviation 
 for l=1:length(valuesStd)
             featureVector(1,end+1)=valuesStd(l,1);
 end
 
%  add MFCC Slope
 for l=1:length(valuesSlope)
             featureVector(1,end+1)=valuesSlope(l,1);
 end
 
 
% add MFCC PeriodEntropy
  for l=1:length(valuesPeriodEntropy)
             featureVector(1,end+1)=valuesPeriodEntropy(l,1);
  end
 
 

%  add lat
featureVector(1,end+1)= attackTime(1,1);


% add spectral centroid mean
 featureVector(1,end+1)= scStruct.Mean;

 % add SC standart deviation 
featureVector(1,end+1)= scStruct.Std;

%  add SC Slope
featureVector(1,end+1)= scStruct.Slope;
  
% add SC PeriodEntropy
featureVector(1,end+1)= scStruct.PeriodEntropy;
  




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


