%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\bassDrumGroups\';% 56
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\cinematicSFX\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\Orchester3instruments\'; %150
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\Orchester10Instruments\'; % 80
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\OrchesterBassSnareDrum\'; % 30
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\OrchesterPercussion\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\RolandJX3P\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\snareGroups\'; % 50
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\synth-groups\'; % 44
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\synth-groups2\'; % 127
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_lat_sc\TSD - Reggae Snares - 100\';


computeFeatures = 1;


%%%%%%%  T - SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% set Paramters this feature set has 29 features
no_dims = 2;
initial_dims = 29;
perplexity = 8;

viewName = 'mir_MFCC_lat_sc_meanStd';


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
 

 
 

%  add lat
featureVector(1,end+1)= attackTime(1,1);


% add spectral centroid mean
 featureVector(1,end+1)= scStruct.Mean;

 % add SC standart deviation 
featureVector(1,end+1)= scStruct.Std;


  

  
  
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


