
fileName = 'C:\Users\Julius Gruber\Documents\MATLAB\Master\Datenbank\pacdv.com\ambient\airport-security-1.mp3';
[signal, fs] = audioread(fileName);

% sound(signal, fs);

win = 0.04;
step = 0.04;

shortTermFeatures = stFeatureExtraction(signal, fs, win, step);

% average of the short term features
meanStFeatures = mean(shortTermFeatures,2);
meanStFeatures = transpose(meanStFeatures);