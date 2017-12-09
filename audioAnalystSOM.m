
dirName ='C:\Users\Julius Gruber\Documents\MATLAB\Master\Datenbank\myDB short sounds';

stWin = 0.04;
stStep = 0.04;

mtWin = 1;
mtStep = 0.25;

featureStatistics = {'mean', 'median', 'std', 'stdbymean' 'max', 'min'}; 

[FeaturesDir, FileNames] =  featureExtractionDirMyVersion(dirName, stWin, stStep, mtWin, mtStep, featureStatistics);


musicVisualizationDemoSOM(FeaturesDir, FileNames, 3, 0)