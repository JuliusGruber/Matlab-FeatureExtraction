

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\OrchesterBassSnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\Orchester3instruments\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\OrchesterPercussion\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\synth-groups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\snareGroups\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Hiphop Snares -500\';



% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\synth-groups\';


readInFeatures = 1;

% set t-SNE Paramters
no_dims = 2;
initial_dims = 45;
perplexity = 5;

viewName = 'ShortSound';

filePathWAVs = readAllWAVfilePaths(dirName);









% get the YAML files

dirNameYAML =strcat(dirName,'YAMLessentiaShortSounds');
YAMLfileInformationArray = getAllFileNames(dirNameYAML);

if readInFeatures
    fileInformationArray = {};
    featureData = cell(size( 10, 10));
    counterNoNaNs = 0;
    nxd = [];
    
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
