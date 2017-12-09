

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\15Samples\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\snareGroups\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\synth-groups\';
% dirName =  'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\Orchester3instruments\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\OrchesterBassSnareDrum\';

readInFeatures = 0;

% set t-SNE Paramters, this feature set has 25 features
no_dims = 2;
initial_dims = 25;
perplexity = 5;

viewName = 'efsMFCC_SCmean';

filePathWAVs = readAllWAVfilePaths(dirName);





% get the YAML files
dirNameYAML =strcat(dirName,'YAMLessentiaFreesound');
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

   
   YAMLcurrentFileName = YAMLcurrentFilePath(YAMLindexOfLastSlash+1 : end);
   
   fileNameFromYAML = strrep(YAMLcurrentFileName, '.yaml_statistics.yaml', '');
   fileNameFromYAML = strcat(fileNameFromYAML, '.wav')
   
%        get the fullFilePath from the filePathWAVs struct
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

% %%%%%%%%%%%%%% mfcc %%%%%%%%%%%%%%%%%%%%%%%
         values = cell2mat(YAMLStruct.lowlevel.mfcc.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
  
%%%%%%%%%%%%% spetral contrast %%%%%%%%%%%%%%%%%%%%%%%
%        values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.dmean);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
%         
%          values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.dmean2);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
% 
%         values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.dvar);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
% 
%          values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.dvar2);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  

%          values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.max);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
        
         values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
% 
%          values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.min);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
        
%          values = cell2mat(YAMLStruct.lowlevel.spectral_contrast.var);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
     
     
     
  

%%%%%%%%%%%%%%%% sc valleys %%%%%%%%%%%%%%%%%%%%%%
%     values = cell2mat(YAMLStruct.lowlevel.scvalleys.dmean);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
%         
%           values = cell2mat(YAMLStruct.lowlevel.scvalleys.dmean2);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
%         
%           values = cell2mat(YAMLStruct.lowlevel.scvalleys.dvar);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end 
%         
%           values = cell2mat(YAMLStruct.lowlevel.scvalleys.dvar2);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
%         
%           values = cell2mat(YAMLStruct.lowlevel.scvalleys.max);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
%           values = cell2mat(YAMLStruct.lowlevel.scvalleys.min);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end
%         
%           values = cell2mat(YAMLStruct.lowlevel.scvalleys.var);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  

  
        

          
          
         
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
          
    end%end of wavAvailable
   
   
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