
% erster bekannter Punkt: (x1,y1), (x1', y1')
x1 = 0;
y1 = 0;
xMsp1 = 0;
yMsp1 = 0;

% Maximum y Wert t-SNE
maxTsne=max(mappedX(:,2));

% zweiter bekannter Punkt(x2,y2)
x2 = 0;
y2 = maxTsne + 10;
xMsp2 = 0;
yMsp2 = 1;

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

% fileID = fopen('pointData.txt','w');
fileIDDesktop = fopen('C:\Users\Julius Gruber\Desktop\pointData.txt','w');

formatSpec = '%f %f %s %s\n';


for i = 1 : size(mappedXtransformed,1)
   xFile= mappedXtransformed(i,1);
   yFile= mappedXtransformed(i,2);
   pathOfFile = fileInformationArray{i,1};
   nameOfFile = fileInformationArray{i,2};
%    fprintf(fileID,formatSpec,xFile, yFile, pathOfFile, nameOfFile);
   fprintf(fileIDDesktop,formatSpec,xFile, yFile, pathOfFile, nameOfFile);
end
%  fclose(fileID);
 fclose(fileIDDesktop);