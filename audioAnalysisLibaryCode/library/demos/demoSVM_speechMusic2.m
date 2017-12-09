clear;

load modelSM;
Cs = [1 10 10^2 10^4 10^5 10^6];

options.Display = 'off';
options.MaxIter = 1000000;
nStatistics = length(Statistics);
% count number of short-features:
nSfeatures = size(Features{1}, 1) / nStatistics;
% get MEAN and STD indeces:
iMEAN = find(ismember(Statistics, 'mean'));
iSTD  = find(ismember(Statistics, 'std'));
% keep only STD of ZCR (1st feature) and MEAN of Spectral Flux (7th feature):
F      = [Features{1}([(iSTD-1)*nSfeatures + 1 (iMEAN-1)*nSfeatures + 7], :)...
          Features{2}([(iSTD-1)*nSfeatures + 1 (iMEAN-1)*nSfeatures + 7], :)]';            
Labels = cell(size(Features{1}, 2) + size(Features{2}, 2), 1);
Labels(1:size(Features{1}, 2)) = {'Speech'};
Labels(size(Features{1}, 2)+1:end) = {'Music'};

numOfSamples = length(Labels);
randPerm     = randperm(numOfSamples);
Ftrain       = F(randPerm(1:numOfSamples/2), :);
LabelsTrain  = Labels(randPerm(1:numOfSamples/2));
Ftest        = F(randPerm(numOfSamples/2+1:end), :);
LabelsTest   = Labels(randPerm(numOfSamples/2+1:end));
s1 = 0.25;
for i = 1:length(Cs)
    figure;
    svmStruct = svmtrain(Ftrain, LabelsTrain, 'kernel_function', 'rbf', 'rbf_sigma', s1, 'boxconstraint', Cs(i), 'options',options, 'showplot', true);
    xlabel('zcr std');
    ylabel('spectral flux mean');
    title(['C = ' num2str(Cs(i)) '   -  rbf sigma = ' num2str(s1)]);
    print('-depsc','-tiff','-r300',['demoSVM_speechMusic2_' num2str(i)])
    
    LabelsFound = svmclassify(svmStruct, Ftest);
    LabelsFoundTrain = svmclassify(svmStruct, Ftrain);
    
    Accuracy(i)      = length(find(strcmp(LabelsFound, LabelsTest))==1) / length(LabelsFound);
    AccuracyTrain(i) = length(find(strcmp(LabelsFoundTrain, LabelsTrain))==1) / length(LabelsFoundTrain);
end
figure;
semilogx(Cs, Accuracy, 'k')
hold on
semilogx(Cs, AccuracyTrain, '--k')
legend({'Accuracy','Training set accuracy'},'Location','South');
legend('boxoff')
xlabel('C');
ylabel('Accuracy');
print('-depsc','-tiff','-r300',['demoSVM_speechMusic2_Accuracy'])
