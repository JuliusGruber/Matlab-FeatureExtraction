addpath(genpath('C:\Users\Julius Gruber\Dropbox\Master\matlab\yamlmatlab-master'));

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName ='C:\Users\Julius Gruber\Desktop\HighHats\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds1\';
% dirName ='C:\Users\Julius Gruber\Desktop\rastafarianWAV\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\SnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\NintyNineDrumSamples\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\SFXsamples\';
dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\BassDrum\';

% pointDataFileName = 'ZeroCrossingRate';
% pointDataFileName = 'ALIGNZeroCrossingRate';
% pointDataFileName = 'Noise_Tone';
% pointDataFileName = 'spectral_flux';
% pointDataFileName = 'dissonance';
% pointDataFileName = 'spectral_rolloff';
% pointDataFileName = 'ALIGNspectral_rolloff';

pointDataFileName = 'spectral_centroidESS';
% pointDataFileName = 'ALIGNspectral_centroidESS';



filePathWAVs = readAllWAVfilePaths(dirName);

fileInformationArray = {};

% get the YAML files

dirNameYAML = strcat(dirName,'YAMLessentiaExtractorMusic');
YAMLfileInformationArray = getAllFileNames(dirNameYAML);

for k =1: length(YAMLfileInformationArray)
     featureVector = [];
   YAMLcurrentFilePath = YAMLfileInformationArray{k,1};
   
   YAMLindexOfSlashes = strfind(YAMLcurrentFilePath, '\');
   YAMLindexOfLastSlash = YAMLindexOfSlashes(end);
%    indexOfFolderSlash = YAMLindexOfSlashes(end -1);
   
   YAMLcurrentFileName = YAMLcurrentFilePath(YAMLindexOfLastSlash+1 : end);
   
   
   fileNameFromYAML = strrep(YAMLcurrentFileName, '.yaml', '');
   
   
%    splittArray = strsplit(YAMLcurrentFileName,'.');
%    YAMLfileNameWithExt = strcat(splittArray(1,1),'.', splittArray(1,end))% e.g. "come-selectah.wav"
%    YAMLfileNameWithExtString = YAMLfileNameWithExt{:}
   
   
%    get the fullFilePath from the filePathWAVs struct
    for i =1: length(filePathWAVs)
      if(strcmp(filePathWAVs(i).name, fileNameFromYAML ))      
        currentFilePath = filePathWAVs(i).fullFilePath
        break;
      end
    end

  YAMLStruct = yaml.ReadYaml(YAMLcurrentFilePath);
   
  fileInformationArray{k,1} = currentFilePath;
  fileInformationArray{k,2} =    fileNameFromYAML;
  fileInformationArray{k,4} = 0;%y - Coordinate
   
 %    x- Coordinate = spectral_centroid  
 if strcmp(pointDataFileName,'spectral_centroidESS' )||strcmp(pointDataFileName,'ALIGNspectral_centroidESS');
    fileInformationArray{k,3}=YAMLStruct.lowlevel.spectral_centroid.mean %brigthness of a sound
end
%    x- Coordinate = Feature Value
if strcmp(pointDataFileName,'ZeroCrossingRateESS' )||strcmp(pointDataFileName,'ALIGNZeroCrossingRateESS');
  fileInformationArray{k,3}=YAMLStruct.lowlevel.zerocrossingrate.mean; %Noisy signals tend to have higher zero-crossing rate
end
%   fileInformationArray{k,3}=YAMLStruct.lowlevel.dissonance.mean;%measures perceptual roughness of the sound
%       
%     fileInformationArray{k,3}=YAMLStruct.lowlevel.melbands_flatness_db.mean; % measure of how noise-like a sound is, as opposed to being tone-like. 
%    
%       fileInformationArray{k,3}= YAMLStruct.lowlevel.pitch_salience.mean; %Unpitched sounds (non-musical sound effects) and pure tones have an average pitch salience value close to 0 whereas sounds containing several harmonics in the spectrum tend to have a higher value.

%    % % % %         mfcc
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,1};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,2};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,3};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,4};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,5};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,6};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,7};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,8};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,9};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,10};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,11};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,12};
%      featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,13};
%      
% % % %   spectral features
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.mean;%brightness of a sound
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_entropy.mean;
%      fileInformationArray{k,3}=YAMLStruct.lowlevel.spectral_flux.mean; %can be used to determine the timbre of an audio signal
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.mean;

if strcmp(pointDataFileName,'spectral_rolloff' )||strcmp(pointDataFileName,'ALIGNspectral_rolloff');
    fileInformationArray{k,3}=YAMLStruct.lowlevel.spectral_rolloff.mean; %can be used to distinguish between harmonic (below roll-off) and noisy sounds (above roll-off).
end


%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.mean;
%     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.mean;
      
   
   
end





% Plot results
figure();
scatter(cell2mat(fileInformationArray(:,3)), cell2mat(fileInformationArray(:,4)));


% if ALIGN, check if pointDataFileName  starts with "ALIGN"
alignEqual = strncmpi(pointDataFileName, 'ALIGN',5) ;
if alignEqual
     aspect = 800/600;
     pointDistance = 2*aspect/size(fileInformationArray,1);
    %     sort fileInformationArray
    [trash, idx] = sort([fileInformationArray{:,3}], 'ascend');

    fileInformationArray = fileInformationArray(idx, :);

    for i = 1 : size(fileInformationArray,1)
        fileInformationArray{i,3} = -aspect+i*pointDistance;
    end

else
    % y Werte auf MaxMSP Koordinaten umrechnen
    fileInformationArray = viewPortTransformSingleFeature(fileInformationArray);
end

% Plot results again after viewport transform
figure();
scatter(cell2mat(fileInformationArray(:,3)), cell2mat(fileInformationArray(:,4)));

% fileID = fopen('pointData.txt','w');
fopenString = strcat(dirName,pointDataFileName,'.txt');
%delete the old txt file
delete(fopenString);
% fileIDDesktop = fopen('C:\Users\Julius Gruber\Desktop\pointData.txt','w');
fileIDDesktop = fopen(fopenString,'w');
dollarChar = '$';

formatSpec = '%f%s%f%s%s%s%s\n';


for i = 1 : size(fileInformationArray,1)
   xFile= fileInformationArray{i,3};
   yFile= fileInformationArray{i,4};
   pathOfFile = fileInformationArray{i,1};
   nameOfFile = fileInformationArray{i,2};
%    fprintf(fileID,formatSpec,xFile, yFile, pathOfFile, nameOfFile);
   fprintf(fileIDDesktop,formatSpec,xFile,dollarChar, yFile,dollarChar, pathOfFile,dollarChar, nameOfFile);
end
%  fclose(fileID);
 fclose(fileIDDesktop);