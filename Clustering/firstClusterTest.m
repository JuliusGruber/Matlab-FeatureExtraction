% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\99DrumSamples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\33DrumSamples\';
dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\snareGroups\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\bassDrumGroups\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\synth-samples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\FX\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\Instruments\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\synth-groups\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\DReinleitung\';
computeFeatures =1;



if computeFeatures
filePathWAVs = readAllWAVfilePaths(dirName);
nxd = [];
fileInformationArray = {};
    
    
for i = 1:size( filePathWAVs,1)
  mirAudio = miraudio(filePathWAVs(i).fullFilePath);


  fileInformationArray{i,1} = filePathWAVs(i).fullFilePath;
  fileInformationArray{i,2} =   filePathWAVs(i).name;




mfccStruct= mirstat(mirmfcc(mirAudio, 'Frame', 0.02, 's', 0.01, 's'));
valuesMean = mfccStruct.Mean;


featureVector = [];

 
%  add MFCC 

 for l=1:length(valuesMean)
             featureVector(1,end+1)=valuesMean(l,1);
            
 end



 
 nxd = [nxd; featureVector];

end
   
    
end


% Z = linkage(nxd,'ward','euclidean');
% dendrogram(Z)

% c = clusterdata(nxd,'linkage','ward','savememory','on', 'maxclust', 3);

c = doClustering(nxd, 5);

