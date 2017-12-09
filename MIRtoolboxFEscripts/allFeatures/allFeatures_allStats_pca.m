%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\bassDrumGroups\';% 56
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\cinematicSFX\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\Orchester3instruments\'; %150
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\Orchester10Instruments\'; % 80
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\OrchesterBassSnareDrum\'; % 30
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\OrchesterPercussion\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\RolandJX3P\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\snareGroups\'; % 50
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\synth-groups\'; % 44
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\synth-groups2\'; % 127
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_MIRtoolbox\TSD - Reggae Snares - 100\';


computeFeatures =1;

% set Paramters, this feature set has 182 features
no_dims = 2;
initial_dims = 30;
perplexity = 50;

viewName = 'MIR_allFeat_allStats_pca';

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
     featureVector(1,end+1) = result.dynamics.rms.Slope;
     featureVector(1,end+1) = result.dynamics.rms.PeriodEntropy;
     
         %  %%%%%%%%SPECTRAL%%%%%%%%%%%%%%%%%%%%%
    % spectral Centroid
    featureVector(1,end+1) = result.spectral.centroid.Mean;
    featureVector(1,end+1) = result.spectral.centroid.Std;
    featureVector(1,end+1) = result.spectral.centroid.Slope;
    featureVector(1,end+1) = result.spectral.centroid.PeriodEntropy;

    % brightness
    featureVector(1,end+1) = result.spectral.brightness.Mean;
    featureVector(1,end+1) =result.spectral.brightness.Std;
    featureVector(1,end+1) =result.spectral.brightness.Slope;
    featureVector(1,end+1) =result.spectral.brightness.PeriodEntropy;

    % spread
    featureVector(1,end+1) =result.spectral.spread.Mean;
    featureVector(1,end+1) =result.spectral.spread.Std;
    featureVector(1,end+1) =result.spectral.spread.Slope;
    featureVector(1,end+1) = result.spectral.spread.PeriodEntropy;

    % skewness
    featureVector(1,end+1) = result.spectral.skewness.Mean;
    featureVector(1,end+1) =result.spectral.skewness.Std;
    featureVector(1,end+1) =result.spectral.skewness.Slope;
    featureVector(1,end+1) =result.spectral.skewness.PeriodEntropy;

    % kurtosis
    featureVector(1,end+1) = result.spectral.kurtosis.Mean;
    featureVector(1,end+1) = result.spectral.kurtosis.Std;
    featureVector(1,end+1) = result.spectral.kurtosis.Slope;
    featureVector(1,end+1) = result.spectral.kurtosis.PeriodEntropy;

    % rollOf95
    featureVector(1,end+1) = result.spectral.rolloff95.Mean;
    featureVector(1,end+1) =result.spectral.rolloff95.Std;
    featureVector(1,end+1) =result.spectral.rolloff95.Slope;
    featureVector(1,end+1) =result.spectral.rolloff95.PeriodEntropy;

    % rollOff85
    featureVector(1,end+1) = result.spectral.rolloff85.Mean;
    featureVector(1,end+1) =result.spectral.rolloff85.Std;
    featureVector(1,end+1) =result.spectral.rolloff85.Slope;
    featureVector(1,end+1) =result.spectral.rolloff85.PeriodEntropy;

    % specEntropy
    featureVector(1,end+1) = result.spectral.spectentropy.Mean;
    featureVector(1,end+1) =result.spectral.spectentropy.Std;
    featureVector(1,end+1) =result.spectral.spectentropy.Slope;
    featureVector(1,end+1) =result.spectral.spectentropy.PeriodEntropy;

    % flatness
    featureVector(1,end+1) = result.spectral.flatness.Mean;
    featureVector(1,end+1) =result.spectral.flatness.Std;
    featureVector(1,end+1) =result.spectral.flatness.Slope;
    featureVector(1,end+1) =result.spectral.flatness.PeriodEntropy;

    % roughness
    featureVector(1,end+1) = result.spectral.roughness.Mean;
    featureVector(1,end+1)= result.spectral.roughness.Std;
    featureVector(1,end+1) =result.spectral.roughness.Slope;
    featureVector(1,end+1) =result.spectral.roughness.PeriodEntropy;

    % irregularity
    featureVector(1,end+1) = result.spectral.irregularity.Mean;
    featureVector(1,end+1)= result.spectral.irregularity.Std;
    featureVector(1,end+1) =result.spectral.irregularity.Slope;
    featureVector(1,end+1) =result.spectral.irregularity.PeriodEntropy;

    % mfcc
    mfccMean = result.spectral.mfcc.Mean;
    mfccStd =result.spectral.mfcc.Std;
    mfccSlope =result.spectral.mfcc.Slope;
    mfccPeriodEntropy =result.spectral.mfcc.PeriodEntropy;
    
%     add MFCC to featureVector
     for l=1:length(mfccMean)
             featureVector(1,end+1)=mfccMean(l,1);
     end
     
     for l=1:length(mfccStd)
             featureVector(1,end+1)=mfccStd(l,1);
     end
       
     for l=1:length(mfccSlope)
             featureVector(1,end+1)=mfccSlope(l,1);
     end
     
     for l=1:length(mfccPeriodEntropy)
             featureVector(1,end+1)=mfccPeriodEntropy(l,1);
     end

    % deltaMFCC
    mfccDeltaMean = result.spectral.dmfcc.Mean;
    mfccDeltaStd =result.spectral.dmfcc.Std;
    mfccDeltaSlope =result.spectral.dmfcc.Slope;
    mfccDeltaPeriodEntropy =result.spectral.dmfcc.PeriodEntropy;
    
    %     add delta MFCC to featureVector
     for l=1:length(mfccDeltaMean)
             featureVector(1,end+1)=mfccDeltaMean(l,1);
     end
     
     for l=1:length(mfccDeltaStd)
             featureVector(1,end+1)=mfccDeltaStd(l,1);
     end
       
     for l=1:length(mfccDeltaSlope)
             featureVector(1,end+1)=mfccDeltaSlope(l,1);
     end
     
     for l=1:length(mfccDeltaPeriodEntropy)
             featureVector(1,end+1)=mfccDeltaPeriodEntropy(l,1);
     end
     
     % deltaDeltaMFCC
    mfccDeltaDeltaMean = result.spectral.ddmfcc.Mean;
%     mfccDeltaDeltaStd =result.spectral.ddmfcc.Std;
%     mfccDeltaDeltaSlope =result.spectral.ddmfcc.Slope;
%     mfccDeltaDeltaPeriodEntropy =result.spectral.ddmfcc.PeriodEntropy;
    
        %     add delta MFCC to featureVector
     for l=1:length(mfccDeltaDeltaMean)
             featureVector(1,end+1)=mfccDeltaDeltaMean(l,1);
     end
     
%      for l=1:length(mfccDeltaDeltaStd)
%              featureVector(1,end+1)=mfccDeltaDeltaStd(l,1);
%      end
%        
%      for l=1:length(mfccDeltaDeltaSlope)
%              featureVector(1,end+1)=mfccDeltaDeltaSlope(l,1);
%      end
%      
%      for l=1:length(mfccDeltaDeltaPeriodEntropy)
%              featureVector(1,end+1)=mfccDeltaDeltaPeriodEntropy(l,1);
%      end

    %  %%%%%%%%TIMBRE%%%%%%%%%%%%%%%%%%%%%
    % Zero Crossing Rate
    featureVector(1,end+1) = result.timbre.zerocross.Mean;
    featureVector(1,end+1) =result.timbre.zerocross.Std;
    featureVector(1,end+1) =result.timbre.zerocross.Slope;
    featureVector(1,end+1) =result.timbre.zerocross.PeriodEntropy;

    % low energy
    featureVector(1,end+1) = result.timbre.lowenergy.Mean;

    % spectral flux
    featureVector(1,end+1) = result.timbre.spectralflux.Mean;
    featureVector(1,end+1) =result.timbre.spectralflux.Std;
    featureVector(1,end+1) =result.timbre.spectralflux.Slope;
    featureVector(1,end+1) =result.timbre.spectralflux.PeriodEntropy;

    % %%%%%%%% TONAL%%%%%%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1) = result.tonal.chromagram.centroid.Mean;
    featureVector(1,end+1) =result.tonal.chromagram.centroid.Std;
    featureVector(1,end+1) =result.tonal.chromagram.centroid.Slope;
    featureVector(1,end+1) =result.tonal.chromagram.centroid.PeriodEntropy;

    featureVector(1,end+1) = result.tonal.keyclarity.Mean;
    featureVector(1,end+1) = result.tonal.keyclarity.Std;
    featureVector(1,end+1) = result.tonal.keyclarity.Slope;
    featureVector(1,end+1) = result.tonal.keyclarity.PeriodEntropy;

    featureVector(1,end+1) = result.tonal.mode.Mean;
    featureVector(1,end+1) = result.tonal.mode.Std;
    featureVector(1,end+1) = result.tonal.mode.Slope;
    featureVector(1,end+1) = result.tonal.mode.PeriodEntropy;

% use featureVectors with no  NaN Values only
    featureVectorHasNaN = ismember(1,isnan(featureVector));
    
    
    if featureVectorHasNaN
       filePathWAVs(i).fullFilePath
     
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