function demoZCR_Speech(fileName)

% EXAMPLE: demoZCR_Speech(['..' filesep '..' filesep 'data' filesep '1WORD.WAV']);

% open the speech file:
[x,fs] = wavread(fileName);

% feature extraction:
Features = stFeatureExtraction(x, fs, 0.020, 0.020);
F = Features(1,:);
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
hold on;
plot(time, x);
plot(timeFeature, F(1,:), 'r');
xlabel('Time (sec)');
legend({'Signal', 'ZCR Sequence'});
