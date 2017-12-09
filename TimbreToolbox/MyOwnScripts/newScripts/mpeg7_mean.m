%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\BD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\BD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\SD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\SD_2\';
dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\HH_1\';

computeFeatures =0;

% set t-SNE Paramters, this feature set has 3 features
no_dims = 2;
initial_dims = 3;
perplexity =5;

viewName = 'TT_mpeg7_mw';

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

    % Parameters passed to function that computes time-domain descriptors
    config_s.TEE = struct();
    % example of how to specify parameter
    config_s.TEE.xcorr_nb_coeff = 12;
    % See @cSound/FCalcDescr.m to see parameters that can be specified.
    

    
    % Parameters passed to function that computes spectrogram-based descriptors
    config_s.STFTpow = struct();	
    % example of how to specify parameter
%     config_s.STFTpow.i_FFTSize = 4096;
    config_s.STFTpow.f_WinSize_sec = 0.02; %The size of the window in seconds.
    config_s.STFTpow.f_HopSize_sec = 0.01;% The hop size in seconds.
    % The parameter w_DistType will be overridden, so specifying it is futile.
    % See @cFFTRep/cFFTRep.m to see parameters that can be specified.

    do_s = struct();
    % Specifiy field as 1 if computation should be carried out, 0 if not.
    do_s.b_TEE = 1;
    do_s.b_STFTmag = 0;
    do_s.b_STFTpow = 1;
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
            
            
%             %%%%%%%%%%%%%%% add TEMPORAL ENRERGY ENVELOPE FEATURES %%%%%%%%%%%%%%%%%%%%%%%
           
            featureVector(1,end+1) =  ALLDESC_s.TEE.LAT;%Log Attack Time
           
            featureVector(1,end+1) = ALLDESCSTATS_s.TEE_mean.TempCent;

           
           
           %%%%%%%%%%%%%% add STFT power Features %%%%%%%%%%%%%%%%%%%%
          featureVector(1,end+1) = ALLDESCSTATS_s.STFTpow_mean.SpecCent;
%           featureVector(1,end+1) = ALLDESCSTATS_s.STFTpow_median.SpecCent;
%           featureVector(1,end+1) = ALLDESCSTATS_s.STFTpow_iqr.SpecCent;
%           featureVector(1,end+1) = ALLDESCSTATS_s.STFTpow_iqr_normal.SpecCent;
          
           
       
            
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