

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName ='C:\Users\Julius Gruber\Desktop\HighHats\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds1\';
% dirName ='C:\Users\Julius Gruber\Desktop\rastafarianWAV\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\SnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\NintyNineDrumSamples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\15Samples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\33DrumSamples\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\snareGroups\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\synth-groups\';
% dirName =  'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\Orchester3instruments\';


readInFeatures = 1;

% set t-SNE Paramters, this feature set has 144 features
no_dims = 2;
initial_dims = 40;
perplexity =40;

viewName = 'emSPECTRAL';


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
         
%    %%%%%%% add features here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
   

    


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
