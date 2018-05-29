function [newpoints] = rotatepoints(points)
% rotate points so that their indicative angle is 0
% find the centroid
[x,y] = centroid(points);

theta=atan2(y-points(1,2),x-points(1,1));
newpoints=rotateby(points,-theta);


end

