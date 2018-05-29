function [x,y] = centroid(points)
% find the centroid
x=sum(points(:,1));y=sum(points(:,2));
x=x/size(points,1);
y=y/size(points,1);

end

