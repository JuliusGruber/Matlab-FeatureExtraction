function demoSpectralHarmonic(wavFileName)

% EXAMPLE: demoSpectralHarmonic(['..' filesep '..' filesep 'data' filesep '1WORD.WAV'])

% read the input wav file
[x,fs] = wavread(wavFileName);
Window  = 25*fs/1000;
Overlap = 0;
Step = Window-Overlap;
nFFT = fs/2;

% feature extraction
curPos = 1;
L = length(x);

% compute the total number of frames:
numOfFrames = floor((L-Window)/Step) + 1;
% number of features to be computed:
HR = zeros(numOfFrames, 1);
F0 = zeros(numOfFrames, 1);
T = zeros(numOfFrames, 1);
Ham = window(@hamming, Window);

for i=1:numOfFrames % for each frame
    T(i) = (i-1)*Step/fs;
    % get current frame:
    frame  = x(curPos:curPos+Window);
    % hamming:        
    frame  = frame .* Ham;
    
    if (sum(abs(frame))>eps)
        % compute current frame's HR and F0:
        [HR(i), F0(i)] = feature_harmonic(frame, fs);
    end    
    curPos = curPos + Step;     
end


subplot(2,1,1);
plot(T, F0);
%axis([0 max(T) 0 fs/2]);
%set(PLOT, 'linewidth', 2);
xlabel('time (secs)');
ylabel('frequency (Hz)');
title('Spectral Rolloff Sequence');