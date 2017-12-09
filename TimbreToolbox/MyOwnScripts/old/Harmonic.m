
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

% Specifiy field as 1 if computation should be carried out, 0 if not.
% Here we compute only STFTpow (power STFT) features
do_s.b_TEE = 0;
do_s.b_STFTmag = 0;
do_s.b_STFTpow = 0;
do_s.b_Harmonic = 1;
do_s.b_ERBfft = 0;
do_s.b_ERBgam = 0;

% Parameters passed to function that computes harmonic-analysis-based descriptors
config_s.Harmonic = struct();
% examples of how to specify parameter
config_s.Harmonic.threshold_harmo = 0.2;
config_s.Harmonic.w_WinType = 'hamming';
config_s.Harmonic.f_WinSize_sec = 0.02;
config_s.Harmonic.F_HopSize_sec = 0.01;
% See @cHarmRep/cHarmRep.m to see parameters that can be specified.

% extract the features
for k= 1: length(fileInfoArrayWAVonly)
    featureVector = [];
    filePath = fileInfoArrayWAVonly{k,1};
    
    % Compute descriptors and representations
    [ALLDESC_s, ALLREP_s] = Gget_desc_onefile(filePath,do_s,config_s,0);

    % Compute other statistics from descriptors (median, inter-quartile range)
    ALLDESCSTATS_s=Gget_statistics(ALLDESC_s);
   
    featureVector(1,1) =ALLDESCSTATS_s.Harmonic_median.FrameErg; 
    featureVector(1,2) =ALLDESCSTATS_s.Harmonic_median.HarmErg;
    featureVector(1,3) =ALLDESCSTATS_s.Harmonic_median.NoiseErg;
    featureVector(1,4) =ALLDESCSTATS_s.Harmonic_median.Noisiness;
    featureVector(1,5) =ALLDESCSTATS_s.Harmonic_median.F0;
    featureVector(1,6) =ALLDESCSTATS_s.Harmonic_median.InHarm;
    featureVector(1,7) =ALLDESCSTATS_s.Harmonic_median.TriStim1; 
    featureVector(1,8) =ALLDESCSTATS_s.Harmonic_median.TriStim2; 
    featureVector(1,9) =ALLDESCSTATS_s.Harmonic_median.TriStim3; 
    featureVector(1,10) =ALLDESCSTATS_s.Harmonic_median.HarmDev;
    featureVector(1,11) =ALLDESCSTATS_s.Harmonic_median.OddEvenRatio;
    featureVector(1,12) =ALLDESCSTATS_s.Harmonic_median.f_Pow;
    featureVector(1,13) =ALLDESCSTATS_s.Harmonic_median.f_HarmPow;
    featureVector(1,14) =ALLDESCSTATS_s.Harmonic_median.f_NoisePow;
    featureVector(1,15) =ALLDESCSTATS_s.Harmonic_median.SpecCent;
    featureVector(1,16) =ALLDESCSTATS_s.Harmonic_median.SpecSpread; 
    featureVector(1,17) =ALLDESCSTATS_s.Harmonic_median.SpecSkew;
    featureVector(1,18) =ALLDESCSTATS_s.Harmonic_median.SpecKurt;
    featureVector(1,19) =ALLDESCSTATS_s.Harmonic_median.SpecSlope;
    featureVector(1,20) =ALLDESCSTATS_s.Harmonic_median.SpecDecr;
    featureVector(1,21) =ALLDESCSTATS_s.Harmonic_median.SpecRollOff;
    featureVector(1,22) =ALLDESCSTATS_s.Harmonic_median.SpecVar;
    
    featureVector(1,23) =ALLDESCSTATS_s.Harmonic_iqr_normal.FrameErg;
    featureVector(1,24) =ALLDESCSTATS_s.Harmonic_iqr_normal.HarmErg;
    featureVector(1,25) =ALLDESCSTATS_s.Harmonic_iqr_normal.NoiseErg; 
    featureVector(1,26) =ALLDESCSTATS_s.Harmonic_iqr_normal.Noisiness;
    featureVector(1,27) =ALLDESCSTATS_s.Harmonic_iqr_normal.F0;
    featureVector(1,28) =ALLDESCSTATS_s.Harmonic_iqr_normal.InHarm; 
    featureVector(1,29) =ALLDESCSTATS_s.Harmonic_iqr_normal.TriStim1;
    featureVector(1,30) =ALLDESCSTATS_s.Harmonic_iqr_normal.TriStim2;
    featureVector(1,31) =ALLDESCSTATS_s.Harmonic_iqr_normal.TriStim3;
    featureVector(1,32) =ALLDESCSTATS_s.Harmonic_iqr_normal.HarmDev;
    featureVector(1,33) =ALLDESCSTATS_s.Harmonic_iqr_normal.OddEvenRatio;
    featureVector(1,34) =ALLDESCSTATS_s.Harmonic_iqr_normal.f_Pow;
    featureVector(1,35) =ALLDESCSTATS_s.Harmonic_iqr_normal.f_HarmPow;
    featureVector(1,36) =ALLDESCSTATS_s.Harmonic_iqr_normal.f_NoisePow;
    featureVector(1,37) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecCent;
    featureVector(1,38) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecSpread;
    featureVector(1,39) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecSkew;
    featureVector(1,40) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecKurt;
    featureVector(1,41) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecSlope;
    featureVector(1,42) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecDecr;
    featureVector(1,43) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecRollOff;
    featureVector(1,44) =ALLDESCSTATS_s.Harmonic_iqr_normal.SpecVar;
     
    featureVector(1,45) =ALLDESCSTATS_s.Harmonic_mean.FrameErg;
    featureVector(1,46) =ALLDESCSTATS_s.Harmonic_mean.HarmErg;
    featureVector(1,47) =ALLDESCSTATS_s.Harmonic_mean.NoiseErg;
    featureVector(1,48) =ALLDESCSTATS_s.Harmonic_mean.Noisiness;
    featureVector(1,49) =ALLDESCSTATS_s.Harmonic_mean.F0;
    featureVector(1,5) =ALLDESCSTATS_s.Harmonic_mean.InHarm;
    featureVector(1,51) =ALLDESCSTATS_s.Harmonic_mean.TriStim1;
    featureVector(1,52) =ALLDESCSTATS_s.Harmonic_mean.TriStim2;
    featureVector(1,53) =ALLDESCSTATS_s.Harmonic_mean.TriStim3;
    featureVector(1,54) =ALLDESCSTATS_s.Harmonic_mean.HarmDev;
    featureVector(1,55) =ALLDESCSTATS_s.Harmonic_mean.OddEvenRatio;
    featureVector(1,56) =ALLDESCSTATS_s.Harmonic_mean.f_Pow;
    featureVector(1,57) =ALLDESCSTATS_s.Harmonic_mean.f_HarmPow;
    featureVector(1,58) =ALLDESCSTATS_s.Harmonic_mean.f_NoisePow;
    featureVector(1,59) =ALLDESCSTATS_s.Harmonic_mean.SpecCent;
    featureVector(1,60) =ALLDESCSTATS_s.Harmonic_mean.SpecSpread;
    featureVector(1,61) =ALLDESCSTATS_s.Harmonic_mean.SpecSkew;
    featureVector(1,62) =ALLDESCSTATS_s.Harmonic_mean.SpecKurt;
    featureVector(1,63) =ALLDESCSTATS_s.Harmonic_mean.SpecSlope; 
    featureVector(1,64) =ALLDESCSTATS_s.Harmonic_mean.SpecDecr; 
    featureVector(1,65) =ALLDESCSTATS_s.Harmonic_mean.SpecRollOff;
    featureVector(1,66) =ALLDESCSTATS_s.Harmonic_mean.SpecVar;
    
    nxd = [nxd; featureVector];
end

% replace NaN with 0
% nxd(isnan(nxd))=0;
% isnan(nxd)


% set t-SNE Paramters
no_dims = 2;
initial_dims = 40;
perplexity = 5;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% plot results
figure();
gscatter(mappedX(:,1), mappedX(:,2));

TimbreToolboxViewPortTransformAndCreateTXTfile(mappedX, fileInfoArrayWAVonly, 'Harmonic', dirName);