%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\bassDrumGroups\'; %56
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\cinematicSFX\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\Orchester3instruments\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\Orchester10Instruments\'; %80
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\OrchesterBassSnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\OrchesterPercussion\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\RolandJX3P\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\snareGroups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\synth-groups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\synth-groups2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_timbreFeatures\TSD - Reggae Snares - 100\';


computeFeatures = 1;

% set Paramters, this feature set has 78 features
no_dims = 2;
initial_dims = 78;
perplexity = 8;

viewName = 'mfcc_timbre_7Feat';

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

     %%%%%%%%%% log attack Time %%%%%%%%%%%%%%%%%%%%%%
     o = mironsets(filePathWAVs(i).fullFilePath,'Attack','Single', 'Filter' );
     attackTime = mirgetdata(mirattacktime(o, 'Log'));
     
     %  add lat
    featureVector(1,end+1)= attackTime(1,1);
    
    
    
    
    
    % %%%%%%%%%%%%%%%%%%%% list of available features %%%%%%%%%%%%%%%%%%%%%%

         %  %%%%%%%%SPECTRAL%%%%%%%%%%%%%%%%%%%%%


   

   
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