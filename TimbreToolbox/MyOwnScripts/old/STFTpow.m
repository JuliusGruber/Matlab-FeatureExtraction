dirName ='C:\Users\Julius\Desktop\SampleDatenbanken\synth-samples\';


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
% config_s.SOUND.i_Samples = 480001;
% To see what other parameters can be specified, see cSound.m

% Specifiy field as 1 if computation should be carried out, 0 if not.
% Here we compute only STFTpow (power STFT) features
do_s.b_TEE = 0;
do_s.b_STFTmag = 0;
do_s.b_STFTpow = 1;
do_s.b_Harmonic = 0;
do_s.b_ERBfft = 0;
do_s.b_ERBgam = 0;

% Parameters passed to function that computes spectrogram-based descriptors
config_s.STFTpow = struct();	
% example of how to specify parameter
% config_s.STFTpow.i_FFTSize = 4096;
config_s.STFTpow.f_WinSize_sec = 0.02;
config_s.STFTpow.f_HopSize_sec = 0.01;
config_s.STFTpow.w_DistType = 'pow';
% The parameter w_DistType will be overridden, so specifying it is futile.
% See @cFFTRep/cFFTRep.m to see parameters that can be specified.

% extract the features
for k= 1: length(fileInfoArrayWAVonly)
    featureVector = [];
    filePath = fileInfoArrayWAVonly{k,1};
    
    % Compute descriptors and representations
    [ALLDESC_s, ALLREP_s] = Gget_desc_onefile(filePath,do_s,config_s,1);

    % Compute other statistics from descriptors (median, inter-quartile range)
    ALLDESCSTATS_s=Gget_statistics(ALLDESC_s);
   
    featureVector(1,1) =ALLDESCSTATS_s.STFTpow_median.SpecCent;
    featureVector(1,2) =ALLDESCSTATS_s.STFTpow_median.SpecSpread;
    featureVector(1,3) =ALLDESCSTATS_s.STFTpow_median.SpecSkew; 
    featureVector(1,4) =ALLDESCSTATS_s.STFTpow_median.SpecKurt;
    featureVector(1,5) =ALLDESCSTATS_s.STFTpow_median.SpecSlope;
    featureVector(1,6) =ALLDESCSTATS_s.STFTpow_median.SpecDecr;
    featureVector(1,7) =ALLDESCSTATS_s.STFTpow_median.SpecRollOff; 
    featureVector(1,8) =ALLDESCSTATS_s.STFTpow_median.SpecVar;
    featureVector(1,9) = ALLDESCSTATS_s.STFTpow_median.FrameErg; 
    featureVector(1,10) =ALLDESCSTATS_s.STFTpow_median.SpecFlat;
    featureVector(1,11) =ALLDESCSTATS_s.STFTpow_median.SpecCrest;
    
    featureVector(1,12) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecCent;
    featureVector(1,13) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecSpread; 
    featureVector(1,14) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecSkew; 
    featureVector(1,15) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecKurt; 
    featureVector(1,16) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecSlope; 
    featureVector(1,17) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecDecr; 
    featureVector(1,18) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecRollOff; 
    featureVector(1,19) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecVar;
    featureVector(1,20) =ALLDESCSTATS_s.STFTpow_iqr_normal.FrameErg;
    featureVector(1,21) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecFlat;
    featureVector(1,22) =ALLDESCSTATS_s.STFTpow_iqr_normal.SpecCrest;
    
    featureVector(1,23) =ALLDESCSTATS_s.STFTpow_mean.SpecCent;
    featureVector(1,24) =ALLDESCSTATS_s.STFTpow_mean.SpecSpread;
    featureVector(1,25) =ALLDESCSTATS_s.STFTpow_mean.SpecSkew; 
    featureVector(1,26) =ALLDESCSTATS_s.STFTpow_mean.SpecKurt;
    featureVector(1,27) =ALLDESCSTATS_s.STFTpow_mean.SpecSlope;
    featureVector(1,28) =ALLDESCSTATS_s.STFTpow_mean.SpecDecr;
    featureVector(1,29) =ALLDESCSTATS_s.STFTpow_mean.SpecRollOff;
    featureVector(1,30) =ALLDESCSTATS_s.STFTpow_mean.SpecVar;
    featureVector(1,31) =ALLDESCSTATS_s.STFTpow_mean.FrameErg;
    featureVector(1,32) =ALLDESCSTATS_s.STFTpow_mean.SpecFlat;
    featureVector(1,33) =ALLDESCSTATS_s.STFTpow_mean.SpecCrest;
    
      
    nxd = [nxd; featureVector];
end

% set t-SNE Paramters
no_dims = 2;
initial_dims = 33;
perplexity = 5;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% plot results
figure();
gscatter(mappedX(:,1), mappedX(:,2));

TimbreToolboxViewPortTransformAndCreateTXTfile(mappedX, fileInfoArrayWAVonly, 'STFTpow', dirName);