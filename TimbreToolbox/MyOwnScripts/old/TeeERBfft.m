
dirName ='C:\Users\Julius\Desktop\SampleDatenbanken\synth-groups\';
% dirName ='C:\Users\Julius\Desktop\SampleDatenbanken\synth-samples\';
fileInformationArray = getAllFileNames(dirName);
fileInfoArrayWAVonly = [];
nxd = [];

for k =1: length(fileInformationArray)
   currentFilePath = fileInformationArray{k,1};
   
   indexOfSlashes = strfind(currentFilePath, '\');
   indexOfLastSlash = indexOfSlashes(end);
   indexOfFolderSlash = indexOfSlashes(end -1);
   
   
   
   currentFileName = currentFilePath(indexOfLastSlash+1 : end);
%    test if it is a .wav file
    indexDots =  strfind(currentFileName, '.');
    indexOfLastDot = indexDots(end);
    currentFileExtension = currentFileName(indexOfLastDot+1 : end)
   
    if(strcmpi(currentFileExtension,'wav'))
        b = [];
        b{1,1} = currentFilePath;
        b{1,2} = currentFileName;
        fileInfoArrayWAVonly =[fileInfoArrayWAVonly;b];% add one row
    end  

  
end

% config setup
config_s = struct();

% Parameters passed to function that loads sound file
config_s.SOUND = struct();
% The following parameters are mandatory if a raw file is read in 
config_s.SOUND.w_Format = 'double';
config_s.SOUND.i_Channels = 2;
config_s.SOUND.f_Fs = 48000;
config_s.SOUND.i_Samples = 480001;
% To see what other parameters can be specified, see cSound.m

% Parameters passed to function that computes time-domain descriptors
config_s.TEE = struct();
% example of how to specify parameter
config_s.TEE.xcorr_nb_coeff = 12;
% See @cSound/FCalcDescr.m to see parameters that can be specified.

% Parameters passed to function computing spectral features
config_s.ERBgam = struct();
config_s.ERBgam.f_Exp = 1/8;
config_s.ERBgam.w_Method = 'fft';
config_s.ERBgam.f_HopSize_sec = 0.02;
% See @cERBRep/cERBRep.m to see parameters that can be specified.



% Specifiy field as 1 if computation should be carried out, 0 if not.
% Here we compute only STFTpow (power STFT) features
do_s.b_TEE = 1;
do_s.b_STFTmag = 0;
do_s.b_STFTpow = 0;
do_s.b_Harmonic = 0;
do_s.b_ERBfft = 1;
do_s.b_ERBgam = 0;

% Parameters passed to function
config_s.ERBfft = struct();	
% example of how to specify parameter
config_s.ERBfft.f_Exp = 1/8;
% The parameter w_Method will be overridden, so specifying it here is futile.
% See @cERBRep/cERBRep.m to see parameters that can be specified.

% extract the features
for k= 1: length(fileInfoArrayWAVonly)
    featureVector = [];
    filePath = fileInfoArrayWAVonly{k,1};
    
    % Compute descriptors and representations
    [ALLDESC_s, ALLREP_s] = Gget_desc_onefile(filePath,do_s,config_s,0);

    % Compute other statistics from descriptors (median, inter-quartile range)
    ALLDESCSTATS_s=Gget_statistics(ALLDESC_s);
   
     featureVector(1,1) =ALLDESCSTATS_s.ERBfft_median.SpecCent;
     featureVector(1,2) =ALLDESCSTATS_s.ERBfft_median.SpecSpread;
     featureVector(1,3) =ALLDESCSTATS_s.ERBfft_median.SpecSkew;
     featureVector(1,4) =ALLDESCSTATS_s.ERBfft_median.SpecKurt;
     featureVector(1,5) =ALLDESCSTATS_s.ERBfft_median.SpecSlope; 
     featureVector(1,6) =ALLDESCSTATS_s.ERBfft_median.SpecDecr;
     featureVector(1,7) =ALLDESCSTATS_s.ERBfft_median.SpecRollOff;
     featureVector(1,8) =ALLDESCSTATS_s.ERBfft_median.SpecVar;
     featureVector(1,9) =ALLDESCSTATS_s.ERBfft_median.FrameErg;
     featureVector(1,10) =ALLDESCSTATS_s.ERBfft_median.SpecFlat;
     featureVector(1,11) =ALLDESCSTATS_s.ERBfft_median.SpecCrest;
    
     featureVector(1,12) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecCent;
     featureVector(1,13) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecSpread;
     featureVector(1,14) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecSkew;
     featureVector(1,15) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecKurt;
     featureVector(1,16) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecSlope;
     featureVector(1,17) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecDecr;
     featureVector(1,18) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecRollOff; 
     featureVector(1,19) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecVar;
     featureVector(1,20) =ALLDESCSTATS_s.ERBfft_iqr_normal.FrameErg; 
     featureVector(1,21) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecFlat; 
     featureVector(1,22) =ALLDESCSTATS_s.ERBfft_iqr_normal.SpecCrest;
    
     featureVector(1,23) =ALLDESCSTATS_s.ERBfft_mean.SpecCent;
     featureVector(1,24) =ALLDESCSTATS_s.ERBfft_mean.SpecSpread;
     featureVector(1,25) =ALLDESCSTATS_s.ERBfft_mean.SpecSkew;
     featureVector(1,26) =ALLDESCSTATS_s.ERBfft_mean.SpecKurt;
     featureVector(1,27) =ALLDESCSTATS_s.ERBfft_mean.SpecSlope;
     featureVector(1,28) =ALLDESCSTATS_s.ERBfft_mean.SpecDecr;
     featureVector(1,29) =ALLDESCSTATS_s.ERBfft_mean.SpecRollOff;
     featureVector(1,30) =ALLDESCSTATS_s.ERBfft_mean.SpecVar;
     featureVector(1,31) =ALLDESCSTATS_s.ERBfft_mean.FrameErg;
     featureVector(1,32) =ALLDESCSTATS_s.ERBfft_mean.SpecFlat;
     featureVector(1,33) =ALLDESCSTATS_s.ERBfft_mean.SpecCrest;
     
    featureVector(1,34) = ALLDESC_s.TEE.Att;
    featureVector(1,35) = ALLDESC_s.TEE.Dec;
    featureVector(1,36) = ALLDESC_s.TEE.Rel;
    featureVector(1,37) = ALLDESC_s.TEE.LAT;
    featureVector(1,38) =  ALLDESC_s.TEE.AttSlope;
    featureVector(1,39) = ALLDESC_s.TEE.DecSlope;
    featureVector(1,40) = ALLDESC_s.TEE.TempCent;
    featureVector(1,41) = ALLDESC_s.TEE.EffDur;
    featureVector(1,42) = ALLDESC_s.TEE.FreqMod;
    featureVector(1,43) = ALLDESC_s.TEE.AmpMod;
    
    
     featureVector(1,44) =ALLDESCSTATS_s.AS_median.AutoCorr1;
     featureVector(1,45) =ALLDESCSTATS_s.AS_median.AutoCorr2;
     featureVector(1,46) =ALLDESCSTATS_s.AS_median.AutoCorr3;
     featureVector(1,47) =ALLDESCSTATS_s.AS_median.AutoCorr4;
     featureVector(1,48) =ALLDESCSTATS_s.AS_median.AutoCorr5;
     featureVector(1,49) =ALLDESCSTATS_s.AS_median.AutoCorr6; 
     featureVector(1,50) =ALLDESCSTATS_s.AS_median.AutoCorr7;
     featureVector(1,51) =ALLDESCSTATS_s.AS_median.AutoCorr8;
     featureVector(1,52) =ALLDESCSTATS_s.AS_median.AutoCorr9; 
     featureVector(1,53) =ALLDESCSTATS_s.AS_median.AutoCorr1; 
     featureVector(1,54) =ALLDESCSTATS_s.AS_median.AutoCorr11;
     featureVector(1,55) =ALLDESCSTATS_s.AS_median.AutoCorr12;
     featureVector(1,56) =ALLDESCSTATS_s.AS_median.ZcrRate;
     
     featureVector(1,57) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr1;
     featureVector(1,58) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr2;
     featureVector(1,59) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr3;
     featureVector(1,60) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr4;
     featureVector(1,61) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr5;
     featureVector(1,62) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr6; 
     featureVector(1,63) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr7; 
     featureVector(1,64) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr8;
     featureVector(1,65) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr9; 
     featureVector(1,66) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr10;
     featureVector(1,67) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr11; 
     featureVector(1,68) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr12; 
     featureVector(1,69) =ALLDESCSTATS_s.AS_iqr_normal.ZcrRate;
     
     featureVector(1,70) =ALLDESCSTATS_s.AS_mean.AutoCorr1;
     featureVector(1,71) =ALLDESCSTATS_s.AS_mean.AutoCorr2;
     featureVector(1,72) =ALLDESCSTATS_s.AS_mean.AutoCorr3;
     featureVector(1,73) =ALLDESCSTATS_s.AS_mean.AutoCorr4;
     featureVector(1,74) =ALLDESCSTATS_s.AS_mean.AutoCorr5; 
     featureVector(1,75) =ALLDESCSTATS_s.AS_mean.AutoCorr6; 
     featureVector(1,76) =ALLDESCSTATS_s.AS_mean.AutoCorr7;
     featureVector(1,77) =ALLDESCSTATS_s.AS_mean.AutoCorr8;
     featureVector(1,78) =ALLDESCSTATS_s.AS_mean.AutoCorr9; 
     featureVector(1,79) =ALLDESCSTATS_s.AS_mean.AutoCorr10; 
     featureVector(1,80) =ALLDESCSTATS_s.AS_mean.AutoCorr11;
     featureVector(1,81) =ALLDESCSTATS_s.AS_mean.AutoCorr12;
     featureVector(1,82) =ALLDESCSTATS_s.AS_mean.ZcrRate;
     
      featureVector(1,83) =ALLDESCSTATS_s.TEE_median.RMSEnv;
      featureVector(1,84) =ALLDESCSTATS_s.TEE_iqr_normal.RMSEnv;
      featureVector(1,85) =ALLDESCSTATS_s.TEE_mean.RMSEnv;
    
    nxd = [nxd; featureVector];
end

% replace NaN with 0
% nxd(isnan(nxd))=0;

% normalize the data columnwise
% nxdNorm = normc(nxd);

% set t-SNE Paramters
no_dims = 2;
initial_dims = 40;
perplexity = 10;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% plot results
figure();
gscatter(mappedX(:,1), mappedX(:,2));

TimbreToolboxViewPortTransformAndCreateTXTfile(mappedX, fileInfoArrayWAVonly, 'TeeERBfft', dirName);