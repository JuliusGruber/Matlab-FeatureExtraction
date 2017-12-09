function demoFo

% load the file with the "real" frequences:
load(['..' filesep '..' filesep 'data' filesep 'frequency.txt'])

% open the speech file:
[x,fs] = wavread(['..' filesep '..' filesep 'data' filesep 'BassClarinet_model1.wav']);

% feature extraction:
Features = stFeatureExtraction(x, fs, 0.10, 0.020);

% keep only the pitch (23 feature):
F = Features(23,:);

% compute time vectors:
timeFeature = 0.020:0.020:length(x)/fs;
time = 0:1/fs:length(x)/fs-1/fs;

% post-process time vectors, sequence vector and signal vector:
MIN1 = min([length(F);length(timeFeature)]);
timeFeature = timeFeature(1:MIN1);
F = F(1:MIN1);

MIN2 = min([length(x);length(time)]);
time = time(1:MIN2);
x = x(1:MIN2);

realF = zeros(size(timeFeature));
for i=2:size(frequency, 2)
    realF(timeFeature<=frequency(2, i) & timeFeature>frequency(2, i-1)) = frequency(1, i-1);
end
realF(timeFeature>frequency(2, end)) = frequency(1, end);


% plot zcr sequence and signal
subplot(3,1,1);
plot(time, x);
xlabel('Time (sec)');
title('Signal');
axis([0 max(time) min(x) max(x)])
subplot(3,1,2);
plot(timeFeature, F);
hold on
plot(timeFeature, realF, 'r');
xlabel('Time (sec)');
ylabel('Pitch (Hz)');
legend({'Estimated','Real'})
axis([0 max(timeFeature) 0 1.2*max(F)])
subplot(3,1,3);
plot(timeFeature, abs(realF - F));
axis([0 max(timeFeature) 0 1.2*max(abs(realF-F))])
ylabel('Abs Error');
xlabel('Time (sec)');
title(sprintf('Average absolute error: %.1f', mean(abs(realF - F)))); 
