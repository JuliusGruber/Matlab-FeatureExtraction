fileID = fopen('pointData.txt','w');
formatSpec = '%f %f\n';


for i = 1 : size(mappedX,1)
   x= mappedX(i,1);
   y= mappedX(i,2);
   
   fprintf(fileID,formatSpec,x, y);
end