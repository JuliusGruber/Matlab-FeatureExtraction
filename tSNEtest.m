load 'mnist_train.mat';

% reduce data set and label set to 5000 random items
ind = randperm(size(train_X,1));
train_X =train_X(ind(1:5000),:);
train_labels=train_labels(ind(1:5000));



% set Paramters
no_dims = 2;
initial_dims = 50;
perplexity = 30;

% run t-SNE
mappedX = tsne(train_X, [], no_dims, initial_dims, perplexity);

% Plot reults
gscatter(mappedX(:,1), mappedX(:,2), train_labels);

