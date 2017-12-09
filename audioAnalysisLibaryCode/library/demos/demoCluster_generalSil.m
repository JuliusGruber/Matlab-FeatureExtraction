Colors = {'k*','k^','ko','k+'};
STD = 0.2;
nSamplesPerCluster = 200;
means = [0.0 0.0; 0.0 1.0; 1.0 0.0; 1.0 1.0];
stds  = [STD STD; STD STD; STD STD; STD STD];
Features(1:nSamplesPerCluster, :) = ...
    [stds(1,1) * randn(nSamplesPerCluster, 1)  + means(1,1)  stds(1,2) * randn(nSamplesPerCluster, 1) + means(1,2)];
Features(nSamplesPerCluster+1:nSamplesPerCluster*2, :) = ...
    [stds(2,1) * randn(nSamplesPerCluster , 1) + means(2,1)  stds(2,2) * randn(nSamplesPerCluster, 1) + means(2,2)];
Features(nSamplesPerCluster*2+1:nSamplesPerCluster*3, :) = ...
    [stds(3,1) * randn(nSamplesPerCluster , 1) + means(3,1) stds(3,2) * randn(nSamplesPerCluster, 1) + means(3,2)];
Features(nSamplesPerCluster*3+1:nSamplesPerCluster*4, :) = ...
    [stds(4,1) * randn(nSamplesPerCluster , 1) + means(4,1) stds(4,2) * randn(nSamplesPerCluster, 1) + means(4,2)];

% 
nClusters = 2:10;
for i=1:length(nClusters)   
    IDX = kmeans(Features, nClusters(i));
    S = silhouette(Features, IDX);
    meanS(i) = mean(S);
end

figure;
hold on;
for i=1:size(Features, 1)
    plot(Features(i, 1), Features(i, 2), 'k*');
end
xlabel('x_1'); ylabel('x_2'); title('Initial (unlabelled) data')
figure;
plot(nClusters, meanS, 'k')
xlabel('Number of clusters')
ylabel('Average Silhouette')
