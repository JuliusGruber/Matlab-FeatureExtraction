function [ clusterNumbers ] = doClustering(nxd, numClusters )
%DOCLUSTERING Summary of this function goes here
%   Detailed explanation goes here
 
% n = size(nxd,1);

% clusterNumbers = [];
clusterNumbers = clusterdata(nxd,'linkage','ward','savememory','on', 'maxclust', numClusters);



end

