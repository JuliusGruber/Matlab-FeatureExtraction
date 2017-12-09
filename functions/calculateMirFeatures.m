function nxd = calculateMirFeatures( fileInformationArray )
%CALCULATEMIRFEATURES Summary of this function goes here
%   Detailed explanation goes here

myflow = mirstruct;
nxd = [];
outputStruct = struct;

for k= 1: length(fileInformationArray)
    l= 1;
   
    currentFilePath = fileInformationArray{k,1};
    
%     myflow.tmp.mirAudio = miraudio('Design');
%     myflow.spectrum = mirspectrum(myflow.tmp.mirAudio');
    myflow.tmp.s = mirspectrum('Design', 'Frame');
   
    
%     myflow.tmp.mirAudio = miraudio('Design','Center');
%     myflow.spectrum = mirspectrum(myflow.tmp.mirAudio);
    
%%%%%% DYNAMIC FEATURES %%%%%%%%%%%%%%%%%%
%   rms
%     myflow.rms = mirrms(myflow.tmp.mirAudio);
%     myflow.rmsMedian = mirrms(myflow.tmp.mirAudio, 'Median');
%  low energy rate
    myflow.lowEnergyRate = mirlowenergy(myflow.tmp.s);
    myflow.lowEnergyRateASR = mirlowenergy(myflow.tmp.s, 'ASR');
%   zcr
    myflow.zcr = mirzerocross(myflow.tmp.s);
%   high frequency energy  
    myflow.highFrequencyEnergy = mirrolloff(myflow.tmp.s);
%   brightness
    myflow.brightness = mirbrightness(myflow.tmp.s);
%%%%%%% SPECTRAL FEATURES %%%%%%%%%%%%%%%%
    myflow.centroid = mircentroid(myflow.tmp.s);
    myflow.spread = mirspread(myflow.tmp.s);
    myflow.skewness = mirskewness(myflow.tmp.s);
    myflow.kurtosis = mirkurtosis(myflow.tmp.s);
    myflow.flatness = mirflatness(myflow.tmp.s);
    myflow.entropy = mirentropy(myflow.tmp.s);
%     myflow.regularity = mirregularity(myflow.tmp.mirAudio);

%%%%%%% MFCCs %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    myflow.mfcc = mirmfcc(myflow.tmp.s);
    
    
    
    
    
    
    
    myflow = mirstat(myflow);
    outputStruct = mireval(myflow, currentFilePath);

%     get all the values from outputStruct to a 1D feature Vektor
featureVector = [];
for field = fieldnames(outputStruct)'
    k = 1;
    subfeatureVector = [];
     for subfield = fieldnames(outputStruct.(field{1}))'
%          disp(field{1});
%          disp(subfield{1});
%          disp( outputStruct.(field{1}).(subfield{1})');
         
         if strcmp(field{1}, 'mfcc') == 0
             
           subfeatureVector(1,k) = outputStruct.(field{1}).(subfield{1})';
            k = k+1;
         else
             
            mfccVector = outputStruct.(field{1}).(subfield{1})';
            for i = 1 : length(mfccVector)
                subfeatureVector(1,k) = mfccVector(i);
                k= k+1;
            end
            
         end
     end
 featureVector =  [featureVector subfeatureVector];
 
end


nxd = [nxd; featureVector];
    

    

end

% delete features with NaN
m= 1;
deleteIndices = [];
 for d = 1 :size(nxd,2)
    a =  isnan(nxd(:, d));
    if ismember(1, a)
       deleteIndices (1,m) = d;
       m = m+1;
    end
    
 end
  
 nxd(:,deleteIndices) = [];
 
 nxdHasNaN = ismember(1,isnan(nxd))



% delete feature number 9
% nxd(:,8) = [];

end

