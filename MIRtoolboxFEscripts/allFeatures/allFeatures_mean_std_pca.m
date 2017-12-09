%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\BD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\BD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\SD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\SD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\HH_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\P_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\M_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\M_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\FSD_1\';
dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_max_pca_vs_mfcc\GSD_1\';


computeFeatures = 0;

% set Paramters, this feature set has 32 features
no_dims = 2;
initial_dims = 32;
perplexity = 5;

viewName = 'MIR_allFeat_mean_std_pca';

if computeFeatures
filePathWAVs = readAllWAVfilePaths(dirName);
nxd = [];
fileInformationArray = {};
% featureData = cell(size( filePathWAVs,1), 10);
featureData = cell(10, 10);
counterNoNaNs = 0;
    
for i = 1:size( filePathWAVs,1)
    featureVector = [];
    
    
    fileName = filePathWAVs(i).fullFilePath;
%     trimmed = miraudio(fileName, 'Trim');
    framed = mirframe(fileName, 'Length', 0.02, 's');%default half overlapping
    result = mirfeatures(framed, 'Stat');
    
    % %%%%%%%%%%%%%%%%%%%% list of available features %%%%%%%%%%%%%%%%%%%%%%
    % %%%%%%%%% DYNAMICS%%%%%%%%%%%%%%
     featureVector(1,end+1) = result.dynamics.rms.Mean;
     featureVector(1,end+1) = result.dynamics.rms.Std;
    
     
         %  %%%%%%%%SPECTRAL%%%%%%%%%%%%%%%%%%%%%
    % spectral Centroid
    featureVector(1,end+1) = result.spectral.centroid.Mean;
    featureVector(1,end+1) = result.spectral.centroid.Std;
 

    % brightness
    featureVector(1,end+1) = result.spectral.brightness.Mean;
    featureVector(1,end+1) =result.spectral.brightness.Std;


    % spread
    featureVector(1,end+1) =result.spectral.spread.Mean;
    featureVector(1,end+1) =result.spectral.spread.Std;


    % skewness
    featureVector(1,end+1) = result.spectral.skewness.Mean;
    featureVector(1,end+1) =result.spectral.skewness.Std;


    % kurtosis
    featureVector(1,end+1) = result.spectral.kurtosis.Mean;
    featureVector(1,end+1) = result.spectral.kurtosis.Std;
   

    % rollOf95
    featureVector(1,end+1) = result.spectral.rolloff95.Mean;
    featureVector(1,end+1) =result.spectral.rolloff95.Std;


    % rollOff85
    featureVector(1,end+1) = result.spectral.rolloff85.Mean;
    featureVector(1,end+1) =result.spectral.rolloff85.Std;
   

    % specEntropy
    featureVector(1,end+1) = result.spectral.spectentropy.Mean;
    featureVector(1,end+1) =result.spectral.spectentropy.Std;
    

    % flatness
    featureVector(1,end+1) = result.spectral.flatness.Mean;
    featureVector(1,end+1) =result.spectral.flatness.Std;


    % roughness - Std produces NAN for some files
    featureVector(1,end+1) = result.spectral.roughness.Mean;
%     featureVector(1,end+1)= result.spectral.roughness.Std;


    % irregularity - Std produces NAN for some files
    featureVector(1,end+1) = result.spectral.irregularity.Mean;
%     featureVector(1,end+1)= result.spectral.irregularity.Std;
  

    % mfcc
    mfccMean = result.spectral.mfcc.Mean;
    mfccStd =result.spectral.mfcc.Std;

    
%     add MFCC to featureVector
     for l=1:length(mfccMean)
             featureVector(1,end+1)=mfccMean(l,1);
     end
     
     for l=1:length(mfccStd)
             featureVector(1,end+1)=mfccStd(l,1);
     end
       
     

    % deltaMFCC
    mfccDeltaMean = result.spectral.dmfcc.Mean;
%     mfccDeltaStd =result.spectral.dmfcc.Std;

    
    %     add delta MFCC to featureVector
     for l=1:length(mfccDeltaMean)
             featureVector(1,end+1)=mfccDeltaMean(l,1);
     end
     
     for l=1:length(mfccDeltaStd)
             featureVector(1,end+1)=mfccDeltaStd(l,1);
     end
       
   
     
     % deltaDeltaMFCC
    mfccDeltaDeltaMean = result.spectral.ddmfcc.Mean;

    
        %     add delta MFCC to featureVector
     for l=1:length(mfccDeltaDeltaMean)
%              featureVector(1,end+1)=mfccDeltaDeltaMean(l,1);
     end
     


    %  %%%%%%%%TIMBRE%%%%%%%%%%%%%%%%%%%%%
    % Zero Crossing Rate
    featureVector(1,end+1) = result.timbre.zerocross.Mean;
    featureVector(1,end+1) =result.timbre.zerocross.Std;


    % low energy
    featureVector(1,end+1) = result.timbre.lowenergy.Mean;

    % spectral flux
    featureVector(1,end+1) = result.timbre.spectralflux.Mean;
%     featureVector(1,end+1) =result.timbre.spectralflux.Std;
 

    % %%%%%%%% TONAL%%%%%%%%%%%%%%%%%%%%%%%%%%
%     featureVector(1,end+1) = result.tonal.chromagram.centroid.Mean;
%     featureVector(1,end+1) =result.tonal.chromagram.centroid.Std;
%  
% 
%     featureVector(1,end+1) = result.tonal.keyclarity.Mean;
%     featureVector(1,end+1) = result.tonal.keyclarity.Std;
% 
% 
%     featureVector(1,end+1) = result.tonal.mode.Mean;
%     featureVector(1,end+1) = result.tonal.mode.Std;
%   

% use featureVectors with no  NaN Values only
    featureVectorHasNaN = ismember(1,isnan(featureVector));
    
    
    if featureVectorHasNaN
        strcat('NAN Warn for: ', filePathWAVs(i).fullFilePath)
     
     end
    
    if not(featureVectorHasNaN)
        
        counterNoNaNs(1,1) = counterNoNaNs(1,1)+1;
        
       nxd = [nxd; featureVector]; 
       
      fileInformationArray{counterNoNaNs(1,1),1} = filePathWAVs(i).fullFilePath;
      fileInformationArray{counterNoNaNs(1,1),2} =   filePathWAVs(i).name;
    
       
          %  add feature data for mat file
    featureData{counterNoNaNs(1,1),1} = filePathWAVs(i).fullFilePath;
    for k = 1: length(featureVector)
        featureData{counterNoNaNs(1,1),k+1}=featureVector(1,k);
    end
    
    
    end
     
     
  
    
    
    
end

end



% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults

figure();
gscatter(mappedX(:,1), mappedX(:,2));


% essentiaViewPortTransformAndCreateTXTfile(mappedX, fileInformationArray, 'AllFeatures', dirName);
viewPortTransformAndCreateViewMatFile(mappedX, fileInformationArray, viewName, dirName);


%%%%%  STORE feature data %%%%%%

save([dirName viewName ], 'featureData');