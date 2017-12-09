function segmentationCompareResults(segs1, classes1, segs2, classes2, fileName, titles)

%
% function map = segmentationCompareResults(segs1, classes1, segs2, classes2, fileName, titles)
%
% This function can be used to visualize two different segmentation
% results for comparison purposes.
%
% RETURNS:
%  - the colormap of the visualization (to be used for further information
%  ploting, e.g. legend).
%
% Examples: see demoSegmentation2 and demoSegmentationSignalChange
%
% (c) 2014 T. Giannakopoulos, A. Pikrakis

classes1 = classes1 + 1; classes2 = classes2 + 1;

[a, fs] = wavread(fileName, 'size');
totalDuration = a(1) / fs;    % get the input file's duration in seconds

Width = 1000; Height = 70; Ratio = Width / totalDuration;

% Generate image to plot (from class labels):
plotLabels1 = []; plotLabels2 = [];
for i=1:size(segs1,1) plotLabels1 = [plotLabels1 classes1(i) * ones(Height, round(Ratio * (segs1(i,2)-segs1(i,1))))]; end
for i=1:size(segs2,1) plotLabels2 = [plotLabels2 classes2(i) * ones(Height, round(Ratio * (segs2(i,2)-segs2(i,1))))]; end

% choose a "lines" color mapping
map = colormap(lines(max([length(unique(classes1)) length(unique(classes2))])));
%map = colormap(gray(max([length(unique(classes1)) length(unique(classes2))])));

subplot(2,1,1); imshow(plotLabels1, map);
hold on;
% plot the time segment limits (text):
for i=1:size(segs1, 1)    
    T = text(segs1(i, 2) * (Width / totalDuration), -Height/3, sprintf('%.1f', segs1(i,2)));
    set(T, 'HorizontalAlignment', 'center');
end
xlabel(titles{1});

subplot(2,1,2); imshow(plotLabels2, map)
hold on;
% plot the time segment limits (text):
for i=1:size(segs2, 1)    
    T = text(segs2(i, 2) * (Width / totalDuration), -Height/3, sprintf('%.1f', segs2(i,2)));
    set(T, 'HorizontalAlignment', 'center');
end
xlabel(titles{2});
