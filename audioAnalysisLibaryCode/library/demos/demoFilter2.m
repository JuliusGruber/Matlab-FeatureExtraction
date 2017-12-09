[x,Fs] = wavread(['..' filesep '..' filesep 'data' ... 
        filesep 'diarizationExample.wav'], [280000 300000]);
x = x / max(abs(x));                        % normalize
N = rand(size(x)); N = N / max(abs(N));     % create white noise
Fst = 3000; Fp  = 3050; Ap = 0.5; As = 30;  % highpass - filter the noise:
hpFilter = fdesign.highpass('Fst,Fp,Ast,Ap', Fst, Fp, As, Ap, Fs);
F = design(hpFilter,'equiripple'); b = F.Numerator; N = filter(b, 1, N); 
% add noise to signal (weighted):
w = 0.05; xN = w * x + (1-w) * N; xN = xN / max(abs(xN));
% low-pass filter the noisy signal
Fpass = 3000; Fstop = 3050; Ap = 0.5; As = 30; 
lpFilter = fdesign.lowpass('Fp,Fst,Ap,Ast', Fpass , Fstop, Ap, As, Fs);
F = design(lpFilter,'equiripple'); b = F.Numerator;
y = filter(b, 1, xN); y = y / max(abs(y));
figure; subplot(2, 2, 1);                   % plot and playback results
spectrogram(x, 0.020 * Fs, 0.010 * Fs, Fs/2, Fs); axis xy;  view(90,90);
title('Spectrogram - original signal'); subplot(2, 2, 2);
spectrogram(N, 0.020 * Fs, 0.010 * Fs, Fs/2, Fs); axis xy;  view(90,90);
title('Spectrogram - noise'); subplot(2, 2, 3);
spectrogram(xN, 0.020 * Fs, 0.010 * Fs, Fs/2, Fs); axis xy;  view(90,90);
title('Spectrogram - noisy signal'); subplot(2, 2, 4);
spectrogram(y, 0.020 * Fs, 0.010 * Fs, Fs/2, Fs); axis xy;  view(90,90);
title('Spectrogram - filtered (deNd) signal');
fprintf('Playing original signal...\n'); sound(x, Fs);
fprintf('Playing noisy signal...\n'); sound(xN, Fs);
fprintf('Playing filtered signal...\n'); sound(y, Fs);
