addpath(genpath('C:\Users\Julius Gruber\Dropbox\Master\matlab\yamlmatlab-master'));

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName ='C:\Users\Julius Gruber\Desktop\HighHats\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds1\';
% dirName ='C:\Users\Julius Gruber\Desktop\rastafarianWAV\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\SnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\NintyNineDrumSamples\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\pacdv.com\people\';
dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\SFXsamples\';

filePathWAVs = readAllWAVfilePaths(dirName);




nxd = [];
fileInformationArray = {};

% get the YAML files
dirNameYAML = strcat(dirName,'YAMLessentiaExtractorMusic');

YAMLfileInformationArray = getAllFileNames(dirNameYAML);

for k =1: length(YAMLfileInformationArray)
     featureVector = [];
   YAMLcurrentFilePath = YAMLfileInformationArray{k,1}
   
   YAMLindexOfSlashes = strfind(YAMLcurrentFilePath, '\');
   YAMLindexOfLastSlash = YAMLindexOfSlashes(end);
%    indexOfFolderSlash = YAMLindexOfSlashes(end -1);
   
   YAMLcurrentFileName = YAMLcurrentFilePath(YAMLindexOfLastSlash+1 : end)
   
   
   fileNameFromYAML = strrep(YAMLcurrentFileName, '.yaml', '')
   
   
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


   
  fileInformationArray{k,1} = currentFilePath;
  fileInformationArray{k,2} =    fileNameFromYAML;
  
   
   
   YAMLStruct = yaml.ReadYaml(YAMLcurrentFilePath);
%       total energy - MISSING - spectral energy used instead
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.mean
        
      featureVector(1,end+1)= YAMLStruct.lowlevel.zerocrossingrate.mean; %Noisy signals tend to have higher zero-crossing rate
      
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_centroid.mean;
      
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_spread.mean;
      
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.mean;
      
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.mean;
      
%       loudness - MISSING
%       sharpness - MISSING
      
       featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.mean;
            
       featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.mean; % measure of how noise-like a sound is, as opposed to being tone-like. 
   
     featureVector(1,end+1) = YAMLStruct.lowlevel.melbands_crest.mean;
      
%      spectral slope - MISSING

       featureVector(1,end+1) =YAMLStruct.lowlevel.spectral_decrease.mean;
     
      featureVector(1,end+1) = YAMLStruct.lowlevel.spectral_rolloff.mean;
      
%       spectral variation - MISSING
      
      % % % %         mfcc
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,1};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,2};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,3};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,4};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,5};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,6};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,7};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,8};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,9};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,10};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,11};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,12};
     featureVector(1,end+1)=YAMLStruct.lowlevel.mfcc.mean{1,13};
     

   
    nxd = [nxd; featureVector];
end

% set Paramters
no_dims = 2;
initial_dims = 17;
perplexity = 15;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults

figure();
gscatter(mappedX(:,1), mappedX(:,2));


essentiaViewPortTransformAndCreateTXTfile(mappedX, fileInformationArray, 'MediaCycleTimbre', dirName);