function SpectralRollOff = demoSpectralRollOff(wavFileName)

% EXAMPLE: demoSpectralRollOff(['..' filesep '..' filesep 'data' filesep '1WORD.WAV']);

% read the input wav file
[x,fs] = wavread(wavFileName);
Window  = 25*fs/1000;
Overlap = 0;
Step = Window-Overlap;
nFFT = fs/2;
subplot(2,1,1);
% step a: plot the spectrum of the input signal:
[S,F,T,P] = spectrogram(x, Window, Overlap, nFFT, fs);
surf(T, F, 10*log10(abs(P)),'EdgeColor','none');   
%mesh(T, F, 10*log10(abs(P)))
axis xy; axis tight; colormap(jet); view(0,90);


% feature extraction
curPos = 1;
L = length(x);

% compute the total number of frames:
numOfFrames = floor((L-Window)/Step) + 1;
% number of features to be computed:
SpectralRollOff = zeros(numOfFrames, 1);
Ham = window(@hamming, Window);

for i=1:numOfFrames % for each frame
    % get current frame:
    frame  = x(curPos:curPos+Window);
    % hamming:
    frame  = frame .* Ham;
    % compute fft:
    frameFFT = getDFT(frame, fs);
    
    if (sum(abs(frame))>eps)
        % compute current frame's spectral rolloff:
        SpectralRollOff(i) = feature_spectral_rolloff(frameFFT, 0.95);
    end    
    curPos = curPos + Step;    
end


title('Spectrogram');
xlabel('time (secs)');
ylabel('frequency (Hz)');

%figure;
subplot(2,1,2);
PLOT = plot(T, SpectralRollOff*fs/2, 'k');
axis([0 max(T) 0 fs/2]);
%set(PLOT, 'linewidth', 2);
xlabel('time (secs)');
ylabel('frequency (Hz)');
title('Spectral Rolloff Sequence');