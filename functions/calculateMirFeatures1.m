function nxd = calculateMirFeatures1( fileInformationArray )
%CALCULATEMIRFEATURES Summary of this function goes here
%   Detailed explanation goes here

% disp('calculateMirFeatures1() method " was called');
% myflow = mirstruct;
r = struct;
nxd = [];
outputStruct = struct;
mirwaitbar(0);

for k= 1: length(fileInformationArray)
    l= 1;
   
    currentFilePath = fileInformationArray{k,1};
    
    r.dynamics = mirstruct;
    r.dynamics.tmp.frames = mirframe('Design');


    r.dynamics.zcr = mirzerocross(r.dynamics.tmp.frames);
    r.dynamics.rms = mirrms(r.dynamics.tmp.frames);
    r.dynamics.lowenergy = mirlowenergy(r.dynamics.rms);
    r.dynamics.lowenergyASR = mirlowenergy(r.dynamics.rms, 'ASR');
    
    r.timbral = mirstruct;
    r.timbral.tmp.spectrum = mirspectrum('Design', 'Frame');
    
    r.timbral.mfcc = mirmfcc(r.timbral.tmp.spectrum);
    r.timbral.brightness = mirbrightness(r.timbral.tmp.spectrum);
    r.timbral.rolloff = mirrolloff(r.timbral.tmp.spectrum);
    r.timbral.centroid = mircentroid(r.timbral.tmp.spectrum);
    r.timbral.spread = mirspread(r.timbral.tmp.spectrum);
    r.timbral.skewness = mirskewness(r.timbral.tmp.spectrum);
    r.timbral.kurtosis = mirkurtosis(r.timbral.tmp.spectrum);
    r.timbral.flatness = mirflatness(r.timbral.tmp.spectrum);
    r.timbral.entropy = mirentropy(r.timbral.tmp.spectrum);
   
   
    
    r = mirstat(r);
    outputStruct =    mireval(r, currentFilePath);
    

   
    


    
    
    
    
    
%     get all the values from outputStruct to a 1D feature Vektor
featureVector = [];
for field = fieldnames(outputStruct)'
    
    k = 1;
    subfeatureVector = [];
    
    if strcmp(field{1}, 'dynamics') == 1
%         iterate over subfields
       for subfield = fieldnames(outputStruct.(field{1}))'
%            iterate over sub sub  fields
           for subSubField = fieldnames(outputStruct.(field{1}).(subfield{1}))'
               
%                 disp(field{1});
%                 disp(subfield{1});
%                 disp(subSubField{1});
%                 disp(outputStruct.(field{1}).(subfield{1}).(subSubField{1})');
               
                 subfeatureVector(1,k) = outputStruct.(field{1}).(subfield{1}).(subSubField{1})';
                 k= k+1;
            
           end
        
       end
    end
    
     if strcmp(field{1}, 'timbral') == 1
%          disp('starting timbral...');
            for subfield = fieldnames(outputStruct.(field{1}))'
%            iterate over sub sub  fields
                for subSubField = fieldnames(outputStruct.(field{1}).(subfield{1}))'
               
%                     disp(field{1});
%                     disp(subfield{1});
%                     disp(subSubField{1});
%                     disp(outputStruct.(field{1}).(subfield{1}).(subSubField{1})');


                    if strcmp(subfield{1}, 'mfcc') == 0
%                         disp(field{1});
%                         disp(subfield{1});
%                         disp(subSubField{1});
%                         disp(outputStruct.(field{1}).(subfield{1}).(subSubField{1})');
                        subfeatureVector(1,k) = outputStruct.(field{1}).(subfield{1}).(subSubField{1})';
                        k = k+1;
                    else
%                         disp('starting mfcc...');
%                         disp(field{1});
%                         disp(subfield{1});
%                         disp(subSubField{1});
%                         disp(outputStruct.(field{1}).(subfield{1}).(subSubField{1})');
                        mfccVector = outputStruct.(field{1}).(subfield{1}).(subSubField{1})';
                        for i = 1 : length(mfccVector)
                            subfeatureVector(1,k) = mfccVector(i);
                            k= k+1;
                        end
                    end
               
                
            
            
        
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
 
 nxdHasNaN = ismember(1,isnan(nxd));



% delete feature number 9
% nxd(:,8) = [];

end

