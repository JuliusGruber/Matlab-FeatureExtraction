% Rabiner's silence detector:
[B1, E1, B2, E2, Er, Zr] = silenceDetectorUtterance(...
    ['..' filesep '..' filesep 'data' filesep '1WORD.WAV'], 0.020, 0.010);
% plot results:
[x, fs] = wavread( ['..' filesep '..' filesep 'data' filesep '1WORD.WAV']); T = 0:1/fs:(length(x)-1)/fs; 
plot(T, x); xlabel('Time (sec)'); hold on; 
line([B2 B2], [-1 1], 'Color', [1 0 0], 'LineWidth', 2); 
line([E2 E2], [-1 1], 'Color', [1 0 0], 'LineWidth', 2);
