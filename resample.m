function [newpoints] = resample(points,path_length)
% Resample the points
global NumPoints
I=path_length/(NumPoints-1);
D=0;
newpoints(1,:)=[points(1,1),points(1,2)];
j=2;
for i=2:size(points,1)
    d=Distance(points(i-1,:),points(i,:));
    if D+d >= I
        qx=points(i-1,1)+((I-D)/d)*(points(i,1)-points(i-1,1));
        qy=points(i-1,2)+((I-D)/d)*(points(i,2)-points(i-1,2));
        points(i,:)=[qx,qy];
        newpoints(j,:)=[qx,qy];
        j=j+1;      
        D=0;
    else 
        D=D+d;
    end
end

end

