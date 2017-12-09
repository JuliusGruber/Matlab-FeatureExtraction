fileName   = ['..' filesep '..' filesep 'data' filesep '4ClassStream.wav']; 
gtFileName = ['..' filesep '..' filesep 'data' filesep '4ClassStreamGT.mat']; kNN = 11;
% 4-class demo:
% Step 1: mid-term classification (classifier trained on 4 classes):
[labels, Ps, Conf, centers, classNames] = mtFileClassification(...
    fileName, kNN, 'model4.mat');
% Plot the class probabilities:
plot(centers, Ps); xlabel('Time (secs)'); title('Class Probabilities');
legend(classNames, 'Location', 'EastOutside','Interpreter', 'none');
load(gtFileName); % Load ground truth
% Step 2: extract segment boundaries:
[a, fs] = wavread(fileName, 'size'); totalDuration = a(1) / fs; 
% 2A: naive merging:
[segs, classes, Labels] = segmentationProbSeq(...
    Ps, centers, totalDuration, 0); % segmentation (merging)
figure; segmentationCompareResults(segs, classes, ...
    segsReal, classesReal, fileName, {'Results','Ground-truth'});
subplot(2,1,1);
colorbar('Ytick',1:length(classNames), 'YTickLabel', classNames)
subplot(2,1,2);
colorbar('Ytick',1:length(classNames), 'YTickLabel', classNames)
% 2B: probability smoothing
[segs, classes, Labels] = segmentationProbSeq(...
    Ps, centers, totalDuration, 1); % segmentation (probability smoothing)
figure; segmentationCompareResults(segs, classes, ...
    segsReal, classesReal, fileName, {'Results','Ground-truth'});
subplot(2,1,1);
colorbar('Ytick',1:length(classNames), 'YTickLabel', classNames)
subplot(2,1,2);
colorbar('Ytick',1:length(classNames), 'YTickLabel', classNames)
