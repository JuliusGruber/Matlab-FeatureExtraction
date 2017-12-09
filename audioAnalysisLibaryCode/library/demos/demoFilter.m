duration = 1; Fs = 8000; f = [200 600 1500];
t = 0:1/Fs:duration; % time vector
% signal definition:
x = cos(2*f(1)*pi*t);
for (i=2:length(f))
    x = x + cos(2*f(i)*pi*t); 
end
x = x / length(f); % signal normalization

Fs = 8000;      % sampling frequency
t = 0: 1/Fs: 1; % time range
x = cos(2*pi*250*t) + cos(2*pi*750*t) + cos(2*pi*1250*t); % signal

Fpass = 1000;    % end of passband: 150 Hz
Fstop = 1050;    % end of transition region: 200 Hz
Ap = 0.5;       % band-pass ripple: 2 db
As = 30;        % stopband attenuation: 40 db

% Step A: initialize the filter:
d = fdesign.lowpass('Fp,Fst,Ap,Ast', Fpass , Fstop, Ap, As, Fs);

% Step B: design the filter assuming FIR equiripple design
F = design(d,'equiripple'); b = F.Numerator;

% Step C: filtering:
y = filter(b, 1, x);

subplot(2, 2, 1);
spectrogram(x, 0.020 * Fs, 0.010 * Fs, Fs/2, Fs); axis xy;  view(90,90);
title('Spectrogram - original signal');
subplot(2, 2, 2);
spectrogram(y, 0.020 * Fs, 0.010 * Fs, Fs/2, Fs); axis xy;  view(90,90);
title('Spectrogram - filtered signal');
% get frequency response of the designed filter:
[H, F] = freqz(b, 1, Fs, Fs);
subplot(2, 2, 3); plot(F, 20*log10(abs(H)));
xlabel('Frequency (Hz)'); ylabel('Filter Gain (dB)');
title('Filter frequency response');
