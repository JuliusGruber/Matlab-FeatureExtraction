clear
probEst(1:10, 1) = [0.8 0.85 0.9 0.72 0.45 0.8 0.87 0.2 0.1 0.3]
probEst(1:10, 2) = 1 - probEst(1:10, 1);
probEst = resample(probEst, 5, 1);
probEst = probEst';

[MAX, Labels] = max(probEst);
LabelsSmoothed = viterbiBestPath([0.5 0.5], [0.35 0.15; 0.15 0.35], probEst)

subplot(3,1,1); hold on;
plot(0:size(probEst,2) - 1, probEst(1, :), 'k');
plot(0:size(probEst,2) - 1,probEst(2, :), 'k--');
legend({'Speech prob', 'Music prob'});
axis([0 size(probEst, 2)-1 0 1]);
xlabel('Time');
ylabel('P');
title('Classifier probability estimations');

PP = subplot(3,1,2); hold on;
plot(0:size(probEst,2) - 1, Labels, 'k');
xlabel('Time'); 
title('Labels using simple thresholding + merging');
axis([0 size(probEst, 2)-1 0.7 2.3]);
set(PP, 'YTick', [1 2]);
set(PP, 'YTickLabel', {'Speech','Music'});

PP = subplot(3,1,3); hold on;
plot(0:size(probEst,2) - 1, LabelsSmoothed, 'k');
xlabel('Time'); 
title('Labels using smoothing of probability estimations');
axis([0 size(probEst, 2)-1 0.7 2.3]);
set(PP, 'YTick', [1 2]);
set(PP, 'YTickLabel', {'Speech','Music'});
