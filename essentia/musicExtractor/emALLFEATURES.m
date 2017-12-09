readInFeatures = 1;
if readInFeatures
    clear
    readInFeatures = 1;
end

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName ='C:\Users\Julius Gruber\Desktop\HighHats\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds1\';
% dirName ='C:\Users\Julius Gruber\Desktop\rastafarianWAV\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\SnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\NintyNineDrumSamples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\15Samples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\33DrumSamples\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\snareGroups\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\synth-groups\';
% dirName =  'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\Orchester3instruments\';





% set t-SNE Paramters, this feature set has 743 features
no_dims = 2;
initial_dims = 44;
perplexity = 5;

viewName = 'emALL FEATURES';

filePathWAVs = readAllWAVfilePaths(dirName);








% get the YAML files

dirNameYAML =strcat(dirName,'YAMLessentiaMusic');
YAMLfileInformationArray = getAllFileNames(dirNameYAML);


if readInFeatures
nxd = [];
fileInformationArray = {};
featureData = cell(size( 10, 10));
counterNoNaNs = 0;
for k =1: length(YAMLfileInformationArray)
   featureVector = [];
   
   YAMLcurrentFilePath = YAMLfileInformationArray{k,1}
   
   YAMLindexOfSlashes = strfind(YAMLcurrentFilePath, '\');
   YAMLindexOfLastSlash = YAMLindexOfSlashes(end);
%    indexOfFolderSlash = YAMLindexOfSlashes(end -1);
   
   YAMLcurrentFileName = YAMLcurrentFilePath(YAMLindexOfLastSlash+1 : end);
   
   
   fileNameFromYAML = strrep(YAMLcurrentFileName, '.yaml', '');
   fileNameFromYAML = strcat(fileNameFromYAML, '.wav');
   
%    splittArray = strsplit(YAMLcurrentFileName,'.');
%    YAMLfileNameWithExt = strcat(splittArray(1,1),'.', splittArray(1,end))% e.g. "come-selectah.wav"
%    YAMLfileNameWithExtString = YAMLfileNameWithExt{:}
   
   
%    get the fullFilePath from the filePathWAVs struct
    wavAvailable = 0;
    for i =1: length(filePathWAVs)
        
      if(strcmp(filePathWAVs(i).name, fileNameFromYAML ))      
        currentFilePath = filePathWAVs(i).fullFilePath;
        wavAvailable = 1;
        break;
      end
    end


   
    if(wavAvailable)
   
        YAMLStruct = yaml.ReadYaml(YAMLcurrentFilePath);
         
%    %%%%%%% average loudness %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
   featureVector(1,end+1) = YAMLStruct.lowlevel.average_loudness;
   
   %    %%%%%%%%%%% barkbands crest %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1) =  YAMLStruct.lowlevel.barkbands_crest.dmean;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.dmean2;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.dvar;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.dvar2;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.max;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.mean;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.median;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.min;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_crest.var;

 
   
   
   %%%%%%%%%%%%%%%% barkbands flatness %%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.dmean;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.dmean2;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.dvar;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.dvar2;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.max;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.mean;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.median;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.min;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_flatness_db.var;
    
%    %%%%%%%%%%% barkbands kurtosis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dmean;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dmean2;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dvar;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dvar2;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.max;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.mean;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.median;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.min;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.var;
    
    %%%%%%%%%%%%% barkbands_skewness %%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.dmean;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.dmean2;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.dvar;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.dvar2;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.max;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.mean;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.median;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.min;
    featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_skewness.var;
    

   
%    %%%%%%%%%%% barkbands spread %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dmean;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dmean2;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dvar;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dvar2;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.max;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.mean;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.median;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.min;
    featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.var;
   
%    %%%%%%%%%% dissonance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.dmean;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.dmean2;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.dvar;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.dvar2;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.max;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.mean;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.median;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.min;
    featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.var;
   
   %%%%%%%%%%%%% dynamic_complexity %%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1)= YAMLStruct.lowlevel.dynamic_complexity;
   
   %%%%%%%%%%%%%%% erbbands crest %%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.dmean;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.dmean2;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.dvar;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.dvar2;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.max;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.mean;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.median;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.min;
   featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_crest.var;
     
     %%%%%%%%%%%%%%%%  erbbands flatness db %%%%%%%%%%%%%%%%%%%%%
     featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.dmean;
     featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.dmean2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.dvar;
     featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.dvar2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.mean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.median;
      featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_flatness_db.var;
      
     %%%%%%%%%%%%% erbbands_kurtosis %%%%%%%%%%% 
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.dmean;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.dmean2;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.dvar;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.dvar2;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.max;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.mean;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.median;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_kurtosis.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.erbbands_kurtosis.var;
      
     %%%%%%%%%%%%%% erbbands skewness %%%%%%%%%%%%%% 
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.dmean;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.dmean2;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.dvar;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.dvar2;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.max;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.mean;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.median;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.min;
     featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_skewness.var;
     
     %%%%%%%%%%%%%%% erbbands spread %%%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.dmean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.dmean2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.dvar;
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.dvar2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.max;
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.mean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.median;
       featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.min;
      featureVector(1,end+1)= YAMLStruct.lowlevel.erbbands_spread.var;
      
   
%    %%%%%%%% hfc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dmean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dmean2; 
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dvar; 
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dvar2; 
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.max; 
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.mean; 
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.median; 
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.min; 
      featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.var;
    
    
      %%%%%%%%%%%%%%%%% melbands crest %%%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.dmean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.dmean2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.dvar;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.dvar2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.max;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.mean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.median;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.min;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_crest.var;
      
      %%%% melbands flatness db %%%%%%%%%%%%%
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.dmean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.dmean2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.dvar;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.dvar2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.mean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.median;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.var;
      
      %%%%%% melbands kurtosis %%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.dmean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.dmean2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.dvar;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.dvar2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.max;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.mean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.median;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.min;
      featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_kurtosis.var;
        
        %%%%%%%%%%%%%%% melbands skewness %%%%%%%%%%%%%%
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.dmean;
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.dmean2;
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.dvar;
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.dvar2;
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.max;
         featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.mean;
         featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.median;
         featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_skewness.min;
         featureVector(1,end+1)=  YAMLStruct.lowlevel.melbands_skewness.var;
         
         %%%%%% melbands spread %%%%%%%%%%%%%
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.dmean;
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.dmean2;
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.dvar;
        featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.dvar2;
         featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.max;
         featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.mean;
          featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.median;
           featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.min;
         featureVector(1,end+1)= YAMLStruct.lowlevel.melbands_spread.var;
         
    %%%%%%%%%%%%%  pitch salience %%%%%%%%%%%%%%%  
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.dmean;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.dmean2;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.dvar;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.dvar2;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.max;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.mean;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.median;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.min;
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.var;

   

   

   
%    %%%%%%%%% silence_rate_20dB %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dmean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dmean2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dvar;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dvar2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.max;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.mean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.median;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.min;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.var;
%    
%    %%%%%%%%%%%%% silence_rate_30dB %%%%%%%%%%%%%%%%
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dmean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dmean2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dvar;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dvar2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.max;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.mean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.median;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.min;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.var;
%    
%    %%%%%%%%%%%%%%%% lowlevel.silence_rate_60dB %%%%%%%%%%%%%%
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dmean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dmean2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dvar;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dvar2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.max;
%      featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.mean;
%      featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.median;
%      featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.min;
%      featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.var;
   
   %%%%%%%%%%%% spectral_centroid%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dmean;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dmean2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dvar;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dvar2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.max;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.mean;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.median;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.min;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.var;
   
   %%%%%%%%%%%%%% spectral_complexity %%%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dmean;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dmean2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dvar;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dvar2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.max;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.mean;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.median;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.min;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.var;
    

    
    %%%%%%%%%%%%%%%%% spectral_decrease %%%%%%%%%%%%%%
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dmean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dmean2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dvar;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dvar2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.max;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.mean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.median;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.min;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.var;
    
    %%%%%%%%%%%%%%%%%%% spectral_energy %%%%%%%%%%%%%%%%%%%%%%%%%%
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dmean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dmean2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dvar;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dvar2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.mean; 
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.median;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.var;
     
     
     %%%%%%%%%%%%% spectral_energyband_high%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.var;
     
     %%%%%%%%%%%%%%%%%%% spectral_energyband_low %%%%%%%%%%%%%%%
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dmean;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dmean2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dvar;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dvar2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.max;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.mean;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.median;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.min;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.var;
     
     %%%%%%%%%%%%%%%%%% spectral_energyband_middle_high%%%%%%%%%%%%%%%%%%%%%%%%%%%
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.dmean;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.dmean2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.dvar;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.dvar2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.max;
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.mean; 
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.median;
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.min;
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.var;
      
      %%%%%%%%%%%%%%%%%% spectral_energyband_middle_low %%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dmean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dmean2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dvar;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dvar2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.mean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.median;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.var;

      %%%%%%%%%%%%%%%%  spectral entropy %%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.dmean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.dmean2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.dvar;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.dvar2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.max;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.mean;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.median;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.min;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_entropy.var;

      
      %%%%%%%%%%%% spectral_flux %%%%%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.dmean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.dmean2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.dvar;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.dvar2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.median;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.var;
      
      %%%%%%%%%%%%% spectral_kurtosis %%%%%%%%%%%%%%%%%%%%%%%
       featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dmean2;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dvar;
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dvar2;
           featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.max;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.mean;
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.median;
           featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.min;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.var;
        
        %%%%%%%%%%%%%% spectral_rms %%%%%%%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.median;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.var;
        
        %%%%%%%%%%%%% spectral_rolloff %%%%%%%%%%%%%%%%%%%%%%%%%%
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.dmean;
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.dmean2;
           featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.dvar;
            featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.dvar2;
             featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.mean;
         featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.median;
          featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.var;
        
        %%%%%%%%%%%%%% spectral_skewness %%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.median;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.var;
        
        
        %%%%%%%%%%%%% spectral_spread%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.median;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.var;
        
        %%%%%%%%%% spectral_strongpeak %%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.median;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.var;
        
        %%%%%%%%%%%%% ZCR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.max;
       featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.mean;
       featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.median;
       featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.var;
        
        %%%%%%%%%%%%% barkbands %%%%%%%%%%%%%%%%%%%%%%%%
          values = cell2mat(YAMLStruct.lowlevel.barkbands.dmean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
          values = cell2mat(YAMLStruct.lowlevel.barkbands.dmean2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
          values = cell2mat(YAMLStruct.lowlevel.barkbands.dvar);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
          values = cell2mat(YAMLStruct.lowlevel.barkbands.dvar2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
          values = cell2mat(YAMLStruct.lowlevel.barkbands.max);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
        values = cell2mat(YAMLStruct.lowlevel.barkbands.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
          values = cell2mat(YAMLStruct.lowlevel.barkbands.median);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
         
            
        values = cell2mat(YAMLStruct.lowlevel.barkbands.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end         
       
        %%%%%%%%%%%%%%  erb bands %%%%%%%%%%%%%%%%%%%%%
            
        values = cell2mat(YAMLStruct.lowlevel.erbbands.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
       
          values = cell2mat(YAMLStruct.lowlevel.erbbands.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
       
     %%%%%%%%%%%%%%%%%%%%  gfcc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             gfccMean = cell2mat(YAMLStruct.lowlevel.gfcc.mean);
        numFeatureValues = length(gfccMean);
        for b = 1 : numFeatureValues(1,1)
            featureVector(1,end+1)= gfccMean(1,b);
        end
                  
%         gfccCov = cell2mat(YAMLStruct.lowlevel.gfcc.cov);
%         numFeatureValues = length( gfccVar);
%         for b = 1 : numFeatureValues(1,1)
%             featureVector(1,end+1)= gfccVar(1,b);
%         end
%         
%           gfccIcov = cell2mat(YAMLStruct.lowlevel.gfcc.icov);
%         numFeatureValues = length( gfccVar);
%         for b = 1 : numFeatureValues(1,1)
%             featureVector(1,end+1)= gfccVar(1,b);
%         end
        
  
      %%%%%%%%%%%%%% melbands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           values = cell2mat(YAMLStruct.lowlevel.melbands.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
             values = cell2mat(YAMLStruct.lowlevel.melbands.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
     
   
        
        % %%%%%%%%   mfcc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             values = cell2mat(YAMLStruct.lowlevel.mfcc.cov);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
%         
%               values = cell2mat(YAMLStruct.lowlevel.mfcc.icov);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
      
        
        
        values = cell2mat(YAMLStruct.lowlevel.mfcc.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
  
        
%%%%%%%%%%%%%%%%  spectral_contrast_coeffs %%%%%%%%%%%%%%%%%
        values = cell2mat(YAMLStruct.lowlevel.spectral_contrast_coeffs.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
         values = cell2mat(YAMLStruct.lowlevel.spectral_contrast_coeffs.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  

%%%%%%%%%%%% spectral_contrast_valleys %%%%%%%%%%%%%%%%%%%%%%
  values = cell2mat(YAMLStruct.lowlevel.spectral_contrast_valleys.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
          values = cell2mat(YAMLStruct.lowlevel.spectral_contrast_valleys.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 





     

  


% use featureVectors with no  NaN Values only
    featureVectorHasNaN = ismember(1,isnan(featureVector));
    
    
    if featureVectorHasNaN
       warn = strcat('WARNING NaN for:', filePathWAVs(i).fullFilePath)
     
    end
    
    if not(featureVectorHasNaN)
        
         counterNoNaNs(1,1) = counterNoNaNs(1,1)+1;
        
         nxd = [nxd; featureVector]; 
       
        fileInformationArray{counterNoNaNs(1,1),1} = currentFilePath;
        fileInformationArray{counterNoNaNs(1,1),2} =   fileNameFromYAML;


 
         %  add feature data for mat file
        featureData{counterNoNaNs(1,1),1} = currentFilePath;
        for m = 1: length(featureVector)
            featureData{counterNoNaNs(1,1),m+1}=featureVector(1,m);
        end
    
    
    end
    
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
