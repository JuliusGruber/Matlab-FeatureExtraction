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
% dirName ='C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Rim Shot 250\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Snaps - 300\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Techno Snares 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Trance Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Urban Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Vintage Snares 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSDAcidizedWavFilesFD\TSD - Wet Snares - 500\';

computeFeatures = 1;

% set Paramters, this feature set has 27 features
no_dims = 2;
initial_dims = 27;
perplexity = 20;

viewName = 'MIR_attRel_mw';

if computeFeatures
filePathWAVs = readAllWAVfilePaths(dirName);
nxd = [];
fileInformationArray = {};
% featureData = cell(size( filePathWAVs,1), 54);  
featureData = cell(10, 10);   
    
for i = 1:size( filePathWAVs,1)
mirAudio = miraudio(filePathWAVs(i).fullFilePath);
samplingRate = cell2mat(get(mirAudio ,'Sampling'));
numSamplesCell = get(mirAudio ,'Length');
numSamples = cell2mat(numSamplesCell{1,1});
durationInSec = numSamples/samplingRate;

  fileInformationArray{i,1} = filePathWAVs(i).fullFilePath;
  fileInformationArray{i,2} =   filePathWAVs(i).name;
  
  
   featureData{i,1} = filePathWAVs(i).fullFilePath;

o = mironsets(filePathWAVs(i).fullFilePath,'Attack','Single', 'Filter' );
[px,py] = mirgetdata(o);
attackTime = mirgetdata(mirattacktime(o, 'Log'));




if ~isempty(attackTime)

% f = mirsegment(filePathWAVs(i).fullFilePath, px);

% k = k+1;
% filesWithAttacks{k, 1} = filePathWAVs(i).fullFilePath;



attackPhase = miraudio(filePathWAVs(i).fullFilePath, 'Extract',0, px, 's');
releasePhase = miraudio(filePathWAVs(i).fullFilePath, 'Extract', px,durationInSec , 's');

% mirspectrum(attackPhase, 'Frame')
% mirspectrum(releasePhase, 'Frame')
% mirplay(attackPhase);
% mirplay(releasePhase)



mfccStructAttack= mirstat(mirmfcc(attackPhase, 'Frame', 0.02, 's', 0.01, 's'));
valuesAttack = mfccStructAttack.Mean;
mfccStructRelease = mirstat(mirmfcc(releasePhase, 'Frame', 0.02, 's', 0.01, 's'));
valuesRelease = mfccStructRelease.Mean;

%plot a bar graph of the mfcc values
% figure();
% bar(valuesAttack)
% figure();
% bar(valuesRelease)



featureVector = [];

% add Attack Time 
 featureVector(1,end+1) = attackTime(1,1);
 


 for l=1:length(valuesAttack)
             featureVector(1,end+1)=valuesAttack(l,1);
            
 end


 for l=1:length(valuesRelease)
             featureVector(1,end+1)=valuesRelease(l,1);
            
 end
 
% use featureVectors with no  NaN Values only
    featureVectorHasNaN = ismember(1,isnan(featureVector));
    
    if featureVectorHasNaN
       warn = strcat('WARNING NaN for:', filePathWAVs(i).fullFilePath)
     
    end

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


% essentiaViewPortTransformAndCreateTXTfile(mappedX, fileInformationArray, 'Drums 1', dirName);

viewPortTransformAndCreateViewMatFile(mappedX, fileInformationArray, viewName, dirName);


%%%%%  STORE feature data %%%%%%

save([dirName viewName ], 'featureData');


