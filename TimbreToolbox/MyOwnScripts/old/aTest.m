filename='C:\Users\Julius Gruber\Desktop\SampleDatenbanken\RolandJX3P\JX3P-Heavy_Decay-39.wav';

disp(sprintf('Filename: %s\n',filename));

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

do_s = struct();

% Specifiy field as 1 if computation should be carried out, 0 if not.
% Here we compute all descriptors
do_s.b_TEE = 1;
do_s.b_STFTmag = 0;
do_s.b_STFTpow = 0;
do_s.b_Harmonic = 0;
do_s.b_ERBfft = 0;
do_s.b_ERBgam = 0;

% Compute descriptors and representations
[ALLDESC_s, ALLREP_s] = Gget_desc_onefile(filename,do_s,config_s,0);

% Compute other statistics from descriptors (median, inter-quartile range)
ALLDESCSTATS_s=Gget_statistics(ALLDESC_s);