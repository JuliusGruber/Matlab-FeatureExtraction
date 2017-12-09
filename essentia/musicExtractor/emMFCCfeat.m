

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\OrchesterBassSnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\Orchester3instruments\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\OrchesterPercussion\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\synth-groups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\snareGroups\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Hiphop Snares -500\';

dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc\bassDrumGroups\';

readInFeatures = 1;

% set t-SNE Paramters
no_dims = 2;
initial_dims = 17;
perplexity = 5;

viewName = 'emMFCCfeat';


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
      values = cell2mat(YAMLStruct.lowlevel.mfcc.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 


    featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.mean; %Noisy signals tend to have higher zero-crossing rate
    featureVector(1,end+1)=YAMLStruct.lowlevel.dissonance.mean;%measures perceptual roughness of the sound
    featureVector(1,end+1)=YAMLStruct.lowlevel.melbands_flatness_db.mean; % measure of how noise-like a sound is, as opposed to being tone-like. 
    featureVector(1,end+1)= YAMLStruct.lowlevel.pitch_salience.mean; %Unpitched sounds (non-musical sound effects) and pure tones have an average pitch salience value close to 0 whereas sounds containing several harmonics in the spectrum tend to have a higher value.

     

  


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
