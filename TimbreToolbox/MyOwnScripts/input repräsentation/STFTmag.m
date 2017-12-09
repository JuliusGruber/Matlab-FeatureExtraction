%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\Orchester3instruments\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\OrchesterBassSnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\snareGroups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\synth-groups\';

% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\bassDrumGroups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\cinematicSFX\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\Orchester3instruments\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\OrchesterBassSnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\OrchesterPercussion\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\RolandJX3P\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\snareGroups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\synth-groups\';
% dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\synth-groups2\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\10TestDBs_mfcc_vs_timbreTollbox\TSD - Reggae Snares - 100\';

computeFeatures =1;

% set t-SNE Paramters, this feature set has 33 features
no_dims = 2;
initial_dims = 33;
perplexity = 5;

viewName = 'ttSTFTmag';

if computeFeatures
     nxd = [];
     featureData = cell(size( 10, 10));
     filePathWAVs = readAllWAVfilePaths(dirName);
      counterNoNaNs = 0;
      
     % config setup
    config_s = struct();
    % Parameters passed to function that loads sound file
    config_s.SOUND = struct();
    % The following parameters are mandatory if a raw file is read in 
    config_s.SOUND.w_Format = 'double';
    config_s.SOUND.i_Channels = 2;
%     config_s.SOUND.f_Fs = 48000;
    % config_s.SOUND.i_Samples = 480001;
    % To see what other parameters can be specified, see cSound.m

  
    

    
    % Parameters passed to function that computes spectrogram-based descriptors
    config_s.STFTmag = struct();	
    % example of how to specify parameter
%     config_s.STFTpow.i_FFTSize = 4096;
    config_s.STFTmag.f_WinSize_sec = 0.02; %The size of the window in seconds.
    config_s.STFTmag.f_HopSize_sec = 0.01;% The hop size in seconds.
    % The parameter w_DistType will be overridden, so specifying it is futile.
    % See @cFFTRep/cFFTRep.m to see parameters that can be specified.

    do_s = struct();
    % Specifiy field as 1 if computation should be carried out, 0 if not.
    do_s.b_TEE = 0;
    do_s.b_STFTmag = 1;
    do_s.b_STFTpow = 0;
    do_s.b_Harmonic = 0;
    do_s.b_ERBfft = 0;
    do_s.b_ERBgam = 0;
    
      for i =1: length(filePathWAVs)
            currentFilePath = filePathWAVs(i).fullFilePath;
            currentFileName = filePathWAVs(i).name;
            featureVector = [];
          
            
            % Compute descriptors and representations
            [ALLDESC_s, ALLREP_s] = Gget_desc_onefile(currentFilePath,do_s,config_s,0);

            % Compute other statistics from descriptors (median, inter-quartile range)
            ALLDESCSTATS_s=Gget_statistics(ALLDESC_s);
            
            
%     %%%%%%%%%%%%%%%% add Features here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecCent;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecSpread;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecSkew; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecKurt;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecSlope;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecDecr;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecRollOff; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecVar;
    featureVector(1,end+1) = ALLDESCSTATS_s.STFTmag_median.FrameErg; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecFlat;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_median.SpecCrest;
    
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecCent;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecSpread; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecSkew; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecKurt; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecSlope; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecDecr; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecRollOff; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecVar;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.FrameErg;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecFlat;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_iqr.SpecCrest;
    
    
    
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecCent;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecSpread;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecSkew; 
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecKurt;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecSlope;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecDecr;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecRollOff;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecVar;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.FrameErg;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecFlat;
    featureVector(1,end+1) =ALLDESCSTATS_s.STFTmag_mean.SpecCrest;   

           
         
           
       
            
            % use featureVectors with no  NaN Values only
            featureVectorHasNaN = ismember(1,isnan(featureVector));
            if featureVectorHasNaN
                warn = strcat('WARNING NaN for:', filePathWAVs(i).fullFilePath)
                
            end
    
            if not(featureVectorHasNaN)
                 counterNoNaNs(1,1) = counterNoNaNs(1,1)+1;
        
                 nxd = [nxd; featureVector];
                 
                 fileInformationArray{counterNoNaNs(1,1),1} = currentFilePath;
                 fileInformationArray{counterNoNaNs(1,1),2} = currentFileName;


 
                %  add feature data for mat file
                featureData{counterNoNaNs(1,1),1} = currentFilePath;
                for m = 1: length(featureVector)
                    featureData{counterNoNaNs(1,1),m+1}=featureVector(1,m);
                end
            end
            
          
      end
    
end


% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults

figure();
gscatter(mappedX(:,1), mappedX(:,2));


viewPortTransformAndCreateViewMatFile(mappedX, fileInformationArray, viewName, dirName);


%%%%%  STORE feature data %%%%%%

save([dirName viewName ], 'featureData');