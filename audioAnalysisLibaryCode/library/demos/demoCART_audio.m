clear;

load modelMusicGenres3;

nStatistics = length(Statistics);
% count number of short-features:
nSfeatures = size(Features{1}, 1) / nStatistics;
% get MEAN and STD indeces:
iMEAN = find(ismember(Statistics, 'mean'));
iMIN  = find(ismember(Statistics, 'min'));
% keep only STD of ZCR (1st feature) and MEAN of Spectral Flux (7th feature):
F      = [Features{1}([(iMIN-1)*nSfeatures + 3 (iMEAN-1)*nSfeatures + 7], :)...
          Features{2}([(iMIN-1)*nSfeatures + 3 (iMEAN-1)*nSfeatures + 7], :)...
          Features{3}([(iMIN-1)*nSfeatures + 3 (iMEAN-1)*nSfeatures + 7], :)]';
      
Color = [0 0 0; 0.3 0.3 0.3; 0.8 0.8 0.8];
      
Labels = cell(size(Features{1}, 2) + size(Features{2}, 2)  + size(Features{3}, 2), 1) ;
Labels(1:size(Features{1}, 2)) = {ClassNames{1}};
Labels(size(Features{1}, 2)+1: size(Features{1}, 2)+size(Features{2}, 2)) = {ClassNames{2}};
Labels(size(Features{1}, 2)+size(Features{2}, 2)+1: end) = {ClassNames{3}};

numOfSamples = length(Labels);
numOfClasses = 3;
randPerm     = randperm(numOfSamples);
Ftrain       = F;
LabelsTrain  = Labels;
%Ftrain       = F(randPerm(1:numOfSamples/2), :);
%LabelsTrain  = Labels(randPerm(1:numOfSamples/2));
%Ftest        = F(randPerm(numOfSamples/2+1:end), :);
%LabelsTest   = Labels(randPerm(numOfSamples/2+1:end));

tc = classregtree(Ftrain, LabelsTrain, 'names', {'min of Energy Entropy', 'mean of Spectral Flux'}, 'minparent', size(F,1)/3);

MIN = min(F); MAX = max(F);
nGrid = 40;
rangeX = MIN(1):(MAX(1)-MIN(1))/(nGrid-1):MAX(1);
rangeY = MIN(2):(MAX(2)-MIN(2))/(nGrid-1):MAX(2);

w = (MAX(1) - MIN(1)) / (nGrid-1);
h = (MAX(2) - MIN(2)) / (nGrid-1);
[x,y] = meshgrid(rangeX, rangeY);
x = x(:);
y = y(:);
[results, nodes] = tc.eval([x y]);
figure; %gscatter(x ,y, results, 'kr', 'ox')
hold on
for i=1:length(x) 
    I = strmatch(results(i), ClassNames); 
    rectangle('Position',[x(i)-w*0.02,y(i)-h*0.02,1.1*w,1.1*h],'FaceColor',Color(I, :), 'EdgeColor', Color(I, :));
end
xlabel('min of Energy Entropy'); ylabel('mean of Spectral Flux')
axis([MIN(1) MAX(1) MIN(2) MAX(2)])
figure;
hold on;
uniqueIndecesClasses = zeros(numOfClasses, 1);
for i=1:size(Ftrain, 1) 
    I = strmatch(LabelsTrain(i), ClassNames);
    uniqueIndecesClasses(I) = i;
    P(i) = plot(Ftrain(i, 1), Ftrain(i, 2), '*', 'DisplayName',ClassNames{I});
    set(P(i), 'Color', Color(I, :));
end
xlabel('min of Energy Entropy'); ylabel('mean of Spectral Flux')
legend(P(uniqueIndecesClasses));
axis([MIN(1) MAX(1) MIN(2) MAX(2)])
view(tc)