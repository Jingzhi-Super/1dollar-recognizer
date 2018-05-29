function [finalpoints] = scaling(points)
% scale the points to the square and then translate to the origin
global SquareSize
% find the bounding
minX=min(points(:,1));
maxX=max(points(:,1));
minY=min(points(:,2));
maxY=max(points(:,2));

j=1;newpoints=zeros(size(points));
for i=1:size(points,1)
    qx=points(i,1)*SquareSize/(maxX - minX);
    qy=points(i,2)*SquareSize/(maxY - minY);
    newpoints(j,:)=[qx,qy];
    j=j+1;
end

% find the centroid
[x,y] = centroid(newpoints);
j=1;finalpoints=zeros(size(points));
for i=1:size(newpoints,1)
    qx=newpoints(i,1)-x;
    qy=newpoints(i,2)-y;
    finalpoints(j,:)=[qx,qy];
    j=j+1;
end




end

