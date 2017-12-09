% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\BassDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\NintyNineDrumSamples\';
dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\snareGroups\';


pointDataFileName = 'spectral_centroidMIR';
% pointDataFileName = 'ALIGNspectral_centroidMIR';



filePathWAVs = readAllWAVfilePaths(dirName);
nxd = [];
fileInformationArray = {};
    
    
for i = 1:size( filePathWAVs,1)
    
%  frames =    miraudio(filePathWAVs(i).fullFilePath, 'Frame', 0.02, 's', 0.01, 's')
    
mirAudio = miraudio(filePathWAVs(i).fullFilePath);
samplingRate = cell2mat(get(mirAudio ,'Sampling'));
numSamplesCell = get(mirAudio ,'Length');
numSamples = cell2mat(numSamplesCell{1,1});
durationInSec = numSamples/samplingRate;

  fileInformationArray{i,1} = filePathWAVs(i).fullFilePath;
  fileInformationArray{i,2} =   filePathWAVs(i).name;
  fileInformationArray{i,4} = 0;%y - Coordinate
   
%  miraudio(..., ‘Frame’, w, wu, h, hu)
  %    x- Coordinate = spectral_centroid  
 if strcmp(pointDataFileName,'spectral_centroidMIR' )||strcmp(pointDataFileName,'ALIGNspectral_centroidMIR');
     centroidStruct = mirstat(mircentroid(mirAudio, 'Frame', 0.02, 's', 0.01, 's'));
    fileInformationArray{i,3}=centroidStruct.Mean %brigthness of a sound
end



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
 
    

