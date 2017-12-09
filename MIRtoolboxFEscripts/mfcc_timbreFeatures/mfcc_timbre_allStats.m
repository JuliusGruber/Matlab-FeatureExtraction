
%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\BD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\BD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\SD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\SD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\HH_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\P_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\M_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\M_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\FSD_1\';
dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\MIR_timbre_allStats\GSD_1\';


computeFeatures = 0;


%%%%%%%  T - SNE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% set Paramters this feature set has 89 features
no_dims = 2;
initial_dims = 89;
perplexity = 5;

viewName = 'mir_timbre_allStats';


if computeFeatures
filePathWAVs = readAllWAVfilePaths(dirName);
nxd = [];
fileInformationArray = {};

featureData = cell(size( 10, 10));
    
for i = 1:size( filePathWAVs,1)
mirAudio = miraudio(filePathWAVs(i).fullFilePath);


fileInformationArray{i,1} = filePathWAVs(i).fullFilePath;
fileInformationArray{i,2} =   filePathWAVs(i).name;

featureData{i,1} = filePathWAVs(i).fullFilePath;

featureVector = [];

framed = mirframe(filePathWAVs(i).fullFilePath, 'Length', 0.02, 's');%default half overlapping
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
%     featureVector(1,end+1) = result.spectral.roughness.Mean;
%     featureVector(1,end+1)= result.spectral.roughness.Std;
%     featureVector(1,end+1) =result.spectral.roughness.Slope;
%     featureVector(1,end+1) =result.spectral.roughness.PeriodEntropy;

   

   
    

    %  %%%%%%%%TIMBRE%%%%%%%%%%%%%%%%%%%%%
    % Zero Crossing Rate
    featureVector(1,end+1) = result.timbre.zerocross.Mean;
    featureVector(1,end+1) =result.timbre.zerocross.Std;
    featureVector(1,end+1) =result.timbre.zerocross.Slope;
    featureVector(1,end+1) =result.timbre.zerocross.PeriodEntropy;

   

    % spectral flux
    featureVector(1,end+1) = result.timbre.spectralflux.Mean;
    featureVector(1,end+1) =result.timbre.spectralflux.Std;
    featureVector(1,end+1) =result.timbre.spectralflux.Slope;
    featureVector(1,end+1) =result.timbre.spectralflux.PeriodEntropy;

 



  featureVectorHasNaN = ismember(1,isnan(featureVector));
     if featureVectorHasNaN
        strcat('NAN Warn for: ', filePathWAVs(i).fullFilePath)
     
     end




  
  
 nxd = [nxd; featureVector];
 
%  add feature data for mat file
for k = 1: length(featureVector)
    featureData{i,k+1}=featureVector(1,k);
end




 
 

end
   
    
end


% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot results

figure();
gscatter(mappedX(:,1), mappedX(:,2));


% essentiaViewPortTransformAndCreateTXTfile(mappedX, fileInformationArray, 'Spectral Envelope 3', dirName);
viewPortTransformAndCreateViewMatFile(mappedX, fileInformationArray, viewName, dirName);

%%%%%  STORE feature data %%%%%%

save([dirName viewName ], 'featureData');


