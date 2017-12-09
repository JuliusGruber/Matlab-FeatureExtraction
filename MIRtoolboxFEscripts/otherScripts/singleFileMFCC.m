fileName = 'C:\Users\Julius\Desktop\SampleDatenbanken\bassDrumGroups\marker-30.wav';

mfccStruct= mirstat(mirmfcc(fileName, 'Frame', 0.02, 's', 0.01, 's'));
valuesMean = mfccStruct.Mean;

%plot a bar graph of the mfcc values
figure();
bar(valuesMean)