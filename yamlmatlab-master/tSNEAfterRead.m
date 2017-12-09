dirName ='C:\Users\Julius Gruber\Desktop\HighHats\';

% set Paramters
no_dims = 2;
initial_dims = 300;
perplexity = 10;

% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults

figure();
gscatter(mappedX(:,1), mappedX(:,2));


TimbreToolboxViewPortTransformAndCreateTXTfile(mappedX, fileInfoArrayWAVonly, 'essentiaShortSounds', dirName);