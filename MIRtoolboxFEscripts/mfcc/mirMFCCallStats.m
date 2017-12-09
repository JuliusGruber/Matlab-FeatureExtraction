dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Claps - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Club Snares - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Crunk Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Dance Snares - 250\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Distorted Snare - 250\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Drum Machine Snare 250\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Dub Snares - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Electro Snares - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Garage Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Hiphop Snares -500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - House Snares - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Long Snares 100\'; 
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Minimal House Snares\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares A - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares B - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares C - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares D - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares E - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares F - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares G - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Mixed Snares H - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Phone Filtered Snares\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Real Snares - 500\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Reggae Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Reggaeton Snares - 60\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Reggaeton Snares - 60\';
% dirName ='C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Rim Shot 250\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Snaps - 300\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Techno Snares 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Trance Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Urban Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Vintage Snares 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Wet Snares - 500\';



computeFeatures = 1;


%%%%%%%  T - SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% set Paramters this feature set has 52 features
no_dims = 2;
initial_dims = 52;
perplexity = 20;

viewName = 'MIR_mfcc_allStats';


if computeFeatures
filePathWAVs = readAllWAVfilePaths(dirName);
nxd = [];
fileInformationArray = {};

featureData = cell(size(10, 10));
    
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


