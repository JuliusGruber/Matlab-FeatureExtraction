clear;



% generate dataset 3 Classes - 2D space:

nSamplesPerClass = 200;
means = [0.0 1.2; 1.2 1.2; 0.0 0.0; 1.2 0.0];
stds  = [0.3 0.2; 0.2 0.3; 0.2 0.3; 0.2 0.3];
Ftrain(1:nSamplesPerClass, :) = ...
    [stds(1,1) * randn(nSamplesPerClass, 1)  + means(1,1)  stds(1,2) * randn(nSamplesPerClass, 1) + means(1,2)];
Ftrain(nSamplesPerClass+1:nSamplesPerClass*2, :) = ...
    [stds(2,1) * randn(nSamplesPerClass , 1) + means(2,1)  stds(2,2) * randn(nSamplesPerClass, 1) + means(2,2)];
Ftrain(nSamplesPerClass*2+1:nSamplesPerClass*3, :) = ...
    [stds(3,1) * randn(nSamplesPerClass , 1) + means(3,1) stds(3,2) * randn(nSamplesPerClass, 1) + means(3,2)];
Ftrain(nSamplesPerClass*3+1:nSamplesPerClass*4, :) = ...
    [stds(4,1) * randn(nSamplesPerClass , 1) + means(4,1) stds(4,2) * randn(nSamplesPerClass, 1) + means(4,2)];

ClassNames = {'A','B','C','D'};
numOfClasses = 4;
Color = [0 0 0; 0.25 0.25 0.25; 0.5 0.5 0.5; 0.75 0.75 0.75];

LabelsTrain = cell(4*nSamplesPerClass, 1) ;
LabelsTrain(1:nSamplesPerClass) = {ClassNames{1}};
LabelsTrain(1+nSamplesPerClass: nSamplesPerClass*2) = {ClassNames{2}};
LabelsTrain(1+2*nSamplesPerClass:3*nSamplesPerClass) = {ClassNames{3}};
LabelsTrain(1+3*nSamplesPerClass:end) = {ClassNames{4}};

tc = classregtree(Ftrain, LabelsTrain, 'names', {'x1', 'x2'}, 'minparent', nSamplesPerClass);

MIN = min(Ftrain); MAX = max(Ftrain);
nGrid = 30;
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
axis([MIN(1) MAX(1) MIN(2) MAX(2)])
xlabel('x_1'); ylabel('x_2');
figure;
hold on;
uniqueIndecesClasses = zeros(numOfClasses, 1);
for i=1:size(Ftrain, 1) 
    I = strmatch(LabelsTrain(i), ClassNames);
    uniqueIndecesClasses(I) = i;
    P(i) = plot(Ftrain(i, 1), Ftrain(i, 2), '*', 'DisplayName',ClassNames{I});
    set(P(i), 'Color', Color(I, :));
end
legend(P(uniqueIndecesClasses));
xlabel('x_1'); ylabel('x_2');
axis([MIN(1) MAX(1) MIN(2) MAX(2)])
view(tc)