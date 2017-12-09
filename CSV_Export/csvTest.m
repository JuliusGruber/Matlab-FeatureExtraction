
filePath = 'C:\Users\Julius Gruber\Desktop\MFCC_mw_std_ClusteringData\';

fileName = 'GSD_1_mfcc_mw_std.csv';

filePathAndName = strcat(filePath,fileName);

groupSize = 5;

numSamples = size(featureData, 1);

numGroups = numSamples/groupSize;

groupID = 0;

groupIDs = cell(numSamples, 1);



for i = 0 : numSamples-1
    
    if mod(i,groupSize)== 0
        groupID = groupID+1;
    end
    
    groupIDs{i+1,1}= groupID;
    
   
    
end



featureData = [groupIDs featureData];

featureTable = cell2table(featureData);

writetable(featureTable, filePathAndName, 'WriteVariableNames', true)



