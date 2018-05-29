function [distance] = distanceatangle(points,temp,theta)
% calculate the distance at specific angle
newpoints = rotateby(points,theta);
distance=pathdistance(newpoints,temp);


end

