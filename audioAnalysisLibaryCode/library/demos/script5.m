% generate a signal with equally-distance frequencies in the range:
% startHz:spaceHz:endHz
clear;
fs = 2000;
windowSizeMs1 = 100;
windowSizeMs2 = 50;
windowSizeMs3 = 10;
signalLenghtMs = 2000;

% time vector:
t = 0:1/fs:signalLenghtMs/1000;

% fm parameters:
fc1 = 500; fc2 = 590; fm = 1; Dfm = 200;

% fm signal:
signal1 = cos(2*pi*fc1*t + Dfm*cos(2*pi*fm*t));
signal2 = cos(2*pi*fc2*t + Dfm*cos(2*pi*fm*t));
signal = (signal1 + signal2) / 2;

% spectrogram calculation:
subplot(3,1,1);
[S,F,T,P] = spectrogram(signal, windowSizeMs1 * fs / 1000, 0, ...
    windowSizeMs1 * fs / 1000, fs);
surf(T, F, 10*log10(abs(P)),'EdgeColor','none');   
axis xy; axis tight; colormap(jet); view(0,90);
title(sprintf('Spectrogram for window = %d msecs', windowSizeMs1));
xlabel('time (seconds)'); ylabel('freq (Hz)');

subplot(3,1,2);
[S,F,T,P] = spectrogram(signal, windowSizeMs2 * fs / 1000, 0, ...
    windowSizeMs2 * fs / 1000, fs);
surf(T, F, 10*log10(abs(P)),'EdgeColor','none');   
axis xy; axis tight; colormap(jet); view(0,90);
title(sprintf('Spectrogram for window = %d msecs', windowSizeMs2));
xlabel('time (seconds)'); ylabel('freq (Hz)');

subplot(3,1,3);
[S,F,T,P] = spectrogram(signal, windowSizeMs3 * fs / 1000, 0, ...
    windowSizeMs3 * fs / 1000, fs);
surf(T, F, 10*log10(abs(P)),'EdgeColor','none');   
axis xy; axis tight; colormap(jet); view(0,90);
title(sprintf('Spectrogram for window = %d msecs', windowSizeMs3));
xlabel('time (seconds)'); ylabel('freq (Hz)');

fprintf('Freq resolution 1: %d Hz\n', 1000 / windowSizeMs1);
fprintf('Freq resolution 2: %d Hz\n', 1000 / windowSizeMs2);
fprintf('Freq resolution 3: %d Hz\n', 1000 / windowSizeMs3);

%soundOS(signal, fs);

