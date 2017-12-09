fileName ='C:\Users\Julius Gruber\Documents\MATLAB\Master\Datenbank\rastafarian\six-million-ways-to-die.wav';
nxd = [];
featureVector = [];
tic
% audio = miraudio(fileName);
frames  = mirframe(fileName);

zcr = mirzerocross(frames);
rms = mirrms(frames);
lowenergy = mirlowenergy(frames);
lowenergyASR = mirlowenergy(frames, 'ASR');

spectrum = mirspectrum(frames);

mfcc = mirmfcc(spectrum);
rolloff = mirrolloff(spectrum);
brightness = mirbrightness(spectrum);


peaks  = mirpeaks(spectrum);
roughness  = mirroughness(peaks);
irregularity = mirregularity(peaks);

centroid = mircentroid(spectrum);
spread = mirspread(spectrum);
skewness = mirskewness(spectrum);
kurtosis = mirkurtosis(spectrum);
flatness = mirflatness(spectrum);
entropy = mirentropy(spectrum);


k = 1;
zcrStruct = mirstat(zcr);
for field = fieldnames(zcrStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = zcrStruct.(field{1})';
        k = k+1;
  
    end  
end

rmsStruct = mirstat(rms);
for field = fieldnames(rmsStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = rmsStruct.(field{1})';
        k = k+1;
  
    end  
end


lowEnergyStruct = mirstat(lowenergy);
for field = fieldnames(lowEnergyStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = lowEnergyStruct.(field{1})';
        k = k+1;
  
    end  
end

lowenergyASRstruct = mirstat(lowenergyASR);
for field = fieldnames(lowenergyASRstruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = lowenergyASRstruct.(field{1})';
        k = k+1;
  
    end  
end

mfccStruct= mirstat(mfcc);
for field = fieldnames(mfccStruct)'
     if( strcmp('FileNames',(field{1})) ~= 1)
        values = mfccStruct.(field{1});
        for i=1:length(values)
             featureVector(1,k)  = values(i,1);
             k = k+1;
        end
       
  
    end  
end


rolloffStruct = mirstat(rolloff);
for field = fieldnames(rolloffStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = rolloffStruct.(field{1})';
        k = k+1;
  
    end  
end

brightnessStruct = mirstat(brightness);
for field = fieldnames(brightnessStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = brightnessStruct.(field{1})';
        k = k+1;
  
    end  
end


roughnessStruct = mirstat(roughness);
irregularityStruct = mirstat(irregularity);


centroidStruct = mirstat(centroid );
for field = fieldnames(centroidStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = centroidStruct.(field{1})';
        k = k+1;
  
    end  
end

spreadStruct = mirstat(spread);
for field = fieldnames(spreadStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = spreadStruct.(field{1})';
        k = k+1;
  
    end  
end

skewnessStruct = mirstat(skewness);
for field = fieldnames(skewnessStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = skewnessStruct.(field{1})';
        k = k+1;
  
    end  
end

kurtosisStruct = mirstat(kurtosis);
for field = fieldnames(kurtosisStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = kurtosisStruct.(field{1})';
        k = k+1;
  
    end  
end

flatnessStruct = mirstat(flatness);
for field = fieldnames(flatnessStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = flatnessStruct.(field{1})';
        k = k+1;
  
    end  
end

entropyStruct = mirstat(entropy );
for field = fieldnames(entropyStruct)'
    
    if( strcmp('FileNames',(field{1})) ~= 1)
        featureVector(1,k) = entropyStruct.(field{1})';
        k = k+1;
  
    end  
end



nxd = [nxd; featureVector];

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
 
 nxdHasNaN = ismember(1,isnan(nxd));

toc
