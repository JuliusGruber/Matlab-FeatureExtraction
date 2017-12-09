function Chromagram = demoChromaVector(fileName)

% EXAMPLE:
% demoChromaVector('../../data/speech_music_sample.wav');

% open the speech file:
[x,fs] = wavread(fileName);

% feature extraction:
Features = stFeatureExtraction(x, fs, 0.050, 0.050);
Chromagram = Features(23+1:23+12, :);

imshow(imresize(Chromagram, 10, 'nearest'), [])