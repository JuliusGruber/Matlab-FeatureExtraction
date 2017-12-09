function mappedXtransformed = viewportTransformTSNEcordiantes( mappedX )
%VIEWPORTTRANSFORMTSNECORDIANTES Summary of this function goes here
%   Detailed explanation goes here

jsuiWidth = 913;
jsuiHeight = 730;

aspect = jsuiWidth/jsuiHeight;

% Maximum x Wert t-SNE
maxXtsne=max(mappedX(:,1));
minXtsne=min(mappedX(:,1));
spanneX = maxXtsne - minXtsne;
spanneHalbeX = (maxXtsne - minXtsne)/2;
% randX = (maxXtsne-minXtsne)/8;
randX = 0;

% Maximum y Wert t-SNE
maxYtsne=max(mappedX(:,2));
minYtsne=min(mappedX(:,2));
spanneY = maxYtsne-minYtsne;
spanneHalbeY = (maxYtsne-minYtsne)/2;
% randY = (maxYtsne-minYtsne)/8;
randY= 0;

% which is the bigger range?
xClamping = 0;
if spanneX - spanneY >= 0
    xClamping = 1;
end
            
if xClamping
    
    % erster bekannter Punkt: (x1,y1), (x1', y1')
    x1 = 0;
    y1 = 0;
    xMsp1 = 0;
    yMsp1 = 0;
% zweiter bekannter Punkt(x2,y2)
if maxXtsne > abs(minXtsne)
    x2 = maxXtsne +randX;
    y2= 0;
    xMsp2 = 1;
    yMsp2 = 0;
else
    x2 = minXtsne + randX;
    y2= 0;
    xMsp2 = -1;
    yMsp2 = 0;
end


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

mappedXtransformed = [];

for i = 1 : size(mappedX,1)
   xCurrent= mappedX(i,1);
   yCurrent= mappedX(i,2);
   
  xMsp = a*xCurrent + b*yCurrent+c;
  yMsp = b*xCurrent - a*yCurrent+d;
  
  mappedXtransformed(i,1)= xMsp;
  mappedXtransformed(i,2)= yMsp;
  
end

% if yClamping then -x all the points- no idea why!?
if xClamping == 0 
    for i = 1 : size(mappedXtransformed,1)
         mappedXtransformed(i,1) =  mappedXtransformed(i,1)*-1;
    end
end

% if xClamping then -y all the points- no idea why!?
if xClamping == 1 
    for i = 1 : size(mappedXtransformed,1)
         mappedXtransformed(i,2) =  mappedXtransformed(i,2)*-1;
    end
end

end

