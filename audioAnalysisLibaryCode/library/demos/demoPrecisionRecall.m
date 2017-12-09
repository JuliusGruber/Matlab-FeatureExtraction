function demoPrecisionRecall(m1, m2, s1, s2, T)

% EXAMPLE: demoPrecisionRecall(0, 1.5, 1, 0.5, 0.5)

Color1 = [0 1 0];
Color2 = [1 0 0];

% Generate data for both classes:
nSamples = 2000000;
x1 = randn(nSamples, 1) * s1 + m1;
x2 = randn(nSamples, 1) * s2 + m2;

% Compute and normalize histograms:
nBins = 70;
MIN = min([x1;x2]); MAX = max([x1;x2]);
range = MIN:(MAX-MIN)/(nBins-1):MAX;
[H1, X1] = hist(x1, range);
[H2, X2] = hist(x2, range);
sumAll = sum(H1) + sum(H2);
H1 = H1 / (sumAll); H2 = H2 / (sumAll);

% Plot Histograms:
Pl1 = plot(X1, H1); set(Pl1, 'Color', Color1);
hold on;
Pl2 = plot(X2, H2); set(Pl2, 'Color', Color2);
str1 = sprintf('$$\\mathcal{N}(%.1f, %.1f)$$', m1, s1);
str2 = sprintf('$$\\mathcal{N}(%.1f, %.1f)$$', m2, s2);
L = legend({str1, str2},'Interpreter','latex');

% Plot error areas:
D1 = abs(X1 - T); D2 = abs(X2 - T);
[MIN, IMIN1] = min(D1); [MIN, IMIN2] = min(D2);
Error1AreaX = X1(IMIN1:end); Error1AreaY = H1(IMIN1:end);
Error2AreaX = X2(1:IMIN2);   Error2AreaY = H2(1:IMIN2);
A1 = area(Error1AreaX, Error1AreaY); 
A2 = area(Error2AreaX, Error2AreaY); 
set(A1, 'FaceColor', Color1); alpha(0.2); set(A1, 'EdgeColor', Color1);
set(A2, 'FaceColor', Color2); alpha(0.2); set(A2, 'EdgeColor', Color2);

% Compute confusion matrix and precision/recall:
CM = zeros(2);
CM(1,1) = length(find(x1<=T));
CM(1,2) = length(find(x1>T));
CM(2,1) = length(find(x2<=T));
CM(2,2) = length(find(x2>T));

Precision = 100*CM(1,1) / sum(CM(:,1));
Recall =    100*CM(1,1) / sum(CM(1,:));
strTitle = sprintf('Threshold: %.1f - Class 1 Precision: %.1f%% - Class 1 Recall: %.1f%%', T, Precision, Recall);
title(strTitle);