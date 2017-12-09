dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\Orchester3instruments\';



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

% Parameters passed to function that computes time-domain descriptors
config_s.TEE = struct();
% example of how to specify parameter
config_s.TEE.xcorr_nb_coeff = 12;
% See @cSound/FCalcDescr.m to see parameters that can be specified.

do_s = struct();

% Specifiy field as 1 if computation should be carried out, 0 if not.
% Here we compute only TEE (Time Energy Envelope) features
do_s.b_TEE = 1;
do_s.b_STFTmag = 0;
do_s.b_STFTpow = 0;
do_s.b_Harmonic = 0;
do_s.b_ERBfft = 0;
do_s.b_ERBgam = 0;

% extract the features
for k= 1: length(fileInfoArrayWAVonly)
    featureVector = [];
    filePath = fileInfoArrayWAVonly{k,1};
    
    % Compute descriptors and representations
    [ALLDESC_s, ALLREP_s] = Gget_desc_onefile(filePath,do_s,config_s,0);

    % Compute other statistics from descriptors (median, inter-quartile range)
    ALLDESCSTATS_s=Gget_statistics(ALLDESC_s);
    
    
   
    
    
     featureVector(1,11) =ALLDESCSTATS_s.AS_median.AutoCorr1;
     featureVector(1,12) =ALLDESCSTATS_s.AS_median.AutoCorr2;
     featureVector(1,13) =ALLDESCSTATS_s.AS_median.AutoCorr3;
     featureVector(1,14) =ALLDESCSTATS_s.AS_median.AutoCorr4;
     featureVector(1,15) =ALLDESCSTATS_s.AS_median.AutoCorr5;
     featureVector(1,16) =ALLDESCSTATS_s.AS_median.AutoCorr6; 
     featureVector(1,17) =ALLDESCSTATS_s.AS_median.AutoCorr7;
     featureVector(1,18) =ALLDESCSTATS_s.AS_median.AutoCorr8;
     featureVector(1,19) =ALLDESCSTATS_s.AS_median.AutoCorr9; 
     featureVector(1,20) =ALLDESCSTATS_s.AS_median.AutoCorr1; 
     featureVector(1,21) =ALLDESCSTATS_s.AS_median.AutoCorr11;
     featureVector(1,22) =ALLDESCSTATS_s.AS_median.AutoCorr12;
     
     
     featureVector(1,24) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr1;
     featureVector(1,25) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr2;
     featureVector(1,26) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr3;
     featureVector(1,27) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr4;
     featureVector(1,28) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr5;
     featureVector(1,29) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr6; 
     featureVector(1,30) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr7; 
     featureVector(1,31) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr8;
     featureVector(1,32) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr9; 
     featureVector(1,33) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr10;
     featureVector(1,34) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr11; 
     featureVector(1,35) =ALLDESCSTATS_s.AS_iqr_normal.AutoCorr12; 
     
     
     featureVector(1,37) =ALLDESCSTATS_s.AS_mean.AutoCorr1;
     featureVector(1,38) =ALLDESCSTATS_s.AS_mean.AutoCorr2;
     featureVector(1,39) =ALLDESCSTATS_s.AS_mean.AutoCorr3;
     featureVector(1,40) =ALLDESCSTATS_s.AS_mean.AutoCorr4;
     featureVector(1,41) =ALLDESCSTATS_s.AS_mean.AutoCorr5; 
     featureVector(1,42) =ALLDESCSTATS_s.AS_mean.AutoCorr6; 
     featureVector(1,43) =ALLDESCSTATS_s.AS_mean.AutoCorr7;
     featureVector(1,44) =ALLDESCSTATS_s.AS_mean.AutoCorr8;
     featureVector(1,45) =ALLDESCSTATS_s.AS_mean.AutoCorr9; 
     featureVector(1,46) =ALLDESCSTATS_s.AS_mean.AutoCorr10; 
     featureVector(1,47) =ALLDESCSTATS_s.AS_mean.AutoCorr11;
     featureVector(1,48) =ALLDESCSTATS_s.AS_mean.AutoCorr12;
     featureVector(1,49) =ALLDESCSTATS_s.AS_mean.ZcrRate;
    
    nxd = [nxd; featureVector];
    
end

% normalize the data columnwise
% nxdNorm = normc(nxd);

% set t-SNE Paramters
no_dims = 2;
initial_dims = 40;
perplexity = 5;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% plot results
figure();
gscatter(mappedX(:,1), mappedX(:,2));

TimbreToolboxViewPortTransformAndCreateTXTfile(mappedX, fileInfoArrayWAVonly, 'TEE', dirName);
