function demoSpectralCentroidSpread(fileName)

% EXAMPLE:
% demoSpectralCentroidSpread(['..' filesep '..' filesep 'data' filesep '1WORD.WAV'])

% open the speech file:
[x,fs] = wavread(fileName);

% feature extraction:
Features = stFeatureExtraction(x, fs, 0.040, 0.020);
F = Features(4,:);

% compute time vectors:
timeFeature = 0.010:0.020:length(x)/fs;
time = 0:1/fs:length(x)/fs-1/fs;

% post-process time vectors, sequence vector and signal vector:
MIN1 = min([length(F);length(timeFeature)]);
timeFeature = timeFeature(1:MIN1);
F = F(1:MIN1);

MIN2 = min([length(x);length(time)]);
time = time(1:MIN2);
x = x(1:MIN2);

% plot zcr sequence and signal
subplot(2,1,1);
plot(time, x);
xlabel('Time (sec)');
title('Signal');
axis([0 max(time) min(x) max(x)])
subplot(2,1,2);
plot(timeFeature, F * fs);
xlabel('Time (sec)');
title('Spectral Centroid Sequence');
axis([0 max(timeFeature) min(F * fs) max(F * fs)])