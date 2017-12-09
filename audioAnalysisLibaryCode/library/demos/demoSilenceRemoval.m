[segs, classes, L1, C1] = silenceRemoval(['..' filesep '..' filesep 'data' filesep 'DubaiAirport.wav'], 0, 0);
[segs, classes, L2, C2] = silenceRemoval(['..' filesep '..' filesep 'data' filesep 'DubaiAirport.wav'], 1, 0);

s = subplot(2,1,1);
plot(C1, L1, 'k');
axis([0 max(C1) 0 3]);
set(s, 'YTick', [0 1 2 3])
set(s, 'YTickLabel', {'','Silence', 'Speech', ''})
xlabel('Time (sec)');
title('Simple merging');

s = subplot(2,1,2);
plot(C2, L2, 'k');
axis([0 max(C1) 0 3]);
set(s, 'YTick', [0 1 2 3])
set(s, 'YTickLabel', {'','Silence', 'Speech', ''})
xlabel('Time (sec)');
title('Viterbi smoothing');