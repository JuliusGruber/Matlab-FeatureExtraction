function demoSpectralCentroidSpread_frame(signal, fs)

[FFT, Freq] = getDFT(signal, fs);
[C,S] = feature_spectral_centroid(FFT, fs);

C*fs/2
S*fs/2

figure;
plot(Freq, FFT);
hold on;
nSamples = 1000000;
Samples = randn(nSamples,1) * S * fs/2 + C*fs/2;
[Hist, X] = hist(Samples, 50);
if (min(X)<0)
    Hist = Hist(X>=0);
    X = X(X>=0);
end
ratio = max(Hist) / max(FFT);
plot(X, Hist/ratio, 'r');
