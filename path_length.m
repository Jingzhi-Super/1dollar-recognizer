function [length] =path_length(points)
% calculate the path length
d=0;
for i=2:size(points,1)
    d=d+Distance(points(i-1,:),points(i,:));
end
length=d;

end

