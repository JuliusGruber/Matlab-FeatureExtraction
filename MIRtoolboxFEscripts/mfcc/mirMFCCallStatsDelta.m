
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\bassDrumGroups\'; % 56
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\cinematicSFX\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\Orchester3instruments\'; % 150
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\Orchester10Instruments\'; % 80
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\OrchesterBassSnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\OrchesterPercussion\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\RolandJX3P\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\snareGroups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\synth-groups\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\synth-groups2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs\TSD - Reggae Snares - 100\';



computeFeatures = 1;


%%%%%%%  T - SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% set Paramters this feature set has 117 features
no_dims = 2;
initial_dims = 117;
perplexity = 50;

viewName = 'mirMFCCallStatsDelta';


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

mfccDeltaStruct = mirstat(mirmfcc(frameDecomposedMFCC, 'Delta', 1));
valuesMeanDelta = mfccDeltaStruct.Mean;
valuesStdDelta = mfccDeltaStruct.Std;
valuesSlopeDelta = mfccDeltaStruct.Slope;
valuesPeriodEntropyDelta = mfccDeltaStruct.PeriodEntropy;


mfccDeltaDeltaStruct = mirstat(mirmfcc(frameDecomposedMFCC, 'Delta', 2));
valuesMeanDeltaDelta = mfccDeltaDeltaStruct.Mean;
% valuesStdDeltaDelta = mfccDeltaDeltaStruct.Std;
% valuesSlopeDeltaDelta = mfccDeltaDeltaStruct.Slope;
% valuesPeriodEntropyDeltaDelta = mfccDeltaDeltaStruct.PeriodEntropy;


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
 
 
%  %%%%%%% Delta MFCCs are added here %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for l=1:length(valuesMeanDelta)
             featureVector(1,end+1)=valuesMeanDelta(l,1);
   end
  
   for l=1:length(valuesStdDelta)
             featureVector(1,end+1)=valuesStdDelta(l,1);
   end
    
   for l=1:length(valuesSlopeDelta)
             featureVector(1,end+1)=valuesSlopeDelta(l,1);
   end
   
   for l=1:length(valuesPeriodEntropyDelta)
             featureVector(1,end+1)=valuesPeriodEntropyDelta(l,1);
   end
  

%  %%%%%%% Delta Delta  MFCCs are added here %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     for l=1:length(valuesMeanDeltaDelta)
             featureVector(1,end+1)=valuesMeanDeltaDelta(l,1);
   end
  
%    for l=1:length(valuesStdDeltaDelta)
%              featureVector(1,end+1)=valuesStdDeltaDelta(l,1);
%    end
%     
%    for l=1:length(valuesSlopeDeltaDelta)
%              featureVector(1,end+1)=valuesSlopeDeltaDelta(l,1);
%    end
%    
%    for l=1:length(valuesPeriodEntropyDeltaDelta)
%              featureVector(1,end+1)=valuesPeriodEntropyDeltaDelta(l,1);
%    end




 
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


