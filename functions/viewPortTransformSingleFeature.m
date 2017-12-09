function returnFileInfoArray = viewPortTransformSingleFeature( fileInformationArray )
%VIEWPORTTRANSFORMSINGLEFEATURE Summary of this function goes here
%   Detailed explanation goes here


jsuiWidth = 800;
jsuiHeight = 600;

aspect = jsuiWidth/jsuiHeight;


maxFeatureValue = max(cell2mat(fileInformationArray(:,3)));
minFeatureValue = min(cell2mat(fileInformationArray(:,3)));

% Maximum x Wert Feature
maxXtsne=maxFeatureValue;
minXtsne=minFeatureValue;
spanneX = maxXtsne - minXtsne;
spanneHalbeX = (maxXtsne - minXtsne)/2;
% randX = (maxXtsne-minXtsne)/8;
randX = 0;

% Maximum y Werte =0
maxYtsne=0;
minYtsne=0;
spanneY = 0;
spanneHalbeY = 0;
% randY = (maxYtsne-minYtsne)/8;
randY= 0;

% which is the bigger range?
xClamping = 0;
if spanneX - spanneY >= 0
    xClamping = 1;
end
            
if xClamping
    
    % erster bekannter Punkt: (x1,y1), (x1', y1')
    x1 = maxXtsne;
    y1 = 0;
    xMsp1 = aspect;
    yMsp1 = 0;
% zweiter bekannter Punkt(x2,y2)

    x2 = minXtsne;
    y2= 0;
    xMsp2 = -aspect;
    yMsp2 = 0;



% if yCLamping
else


% erster bekannter Punkt: (x1,y1), (x1', y1')
x1 = 0;
y1 = 0;
xMsp1 = 0;
yMsp1 = 0;
% zweiter bekannter Punkt(x2,y2)
if maxYtsne > abs(minYtsne)
    x2 = 0;
    y2= maxYtsne +randY;
    xMsp2 = 0;
    yMsp2 = 1;
else
    x2 = 0;
    y2= minYtsne + randY;
    xMsp2 = 0;
    yMsp2 = -1;
end

end






u = [];
u(1 ,1) = xMsp1;
u(2, 1) = yMsp1;
u(3 ,1) = xMsp2;
u(4, 1) = yMsp2;

m= [];
m(1,1) = x1;
m(2,1) = -y1;
m(3,1) = x2;
m(4,1) = -y2;

m(1,2) = y1;
m(2,2) = x1;
m(3,2) = y2;
m(4,2) = x2;

m(1,3) = 1;
m(2,3) = 0;
m(3,3) = 1;
m(4,3) = 0;

m(1,4) = 0 ;
m(2,4) = 1 ; 
m(3,4) = 0 ;
m(4,4) = 1;

mKehrwert = inv(m);
resultMatrix = mKehrwert*u;


a= resultMatrix(1,1);
b= resultMatrix(2,1);
c= resultMatrix(3,1);
d= resultMatrix(4,1);

% mappedXtransformed = [];

for i = 1 : size(fileInformationArray,1)
   xCurrent= fileInformationArray{i,3};
   yCurrent= fileInformationArray{i,4};
   
  xMsp = a*xCurrent + b*yCurrent+c;
  yMsp = b*xCurrent - a*yCurrent+d;
  
  fileInformationArray{i,3}= xMsp;
  fileInformationArray{i,4}= yMsp;
  
end

% if yClamping then -x all the points- no idea why!?
if xClamping == 0 
    for i = 1 : size(fileInformationArray,1)
         fileInformationArray{i,3} = cell2mat(fileInformationArray(i,3))*-1;
    end
end

% if xClamping then -y all the points- no idea why!?
if xClamping == 1 
    for i = 1 : size(fileInformationArray,1)
         fileInformationArray{i,4} = cell2mat( fileInformationArray(i,4))*-1;
    end
end


returnFileInfoArray = fileInformationArray;
end

