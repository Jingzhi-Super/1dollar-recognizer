function [distance] = pathdistance(A,B)
% calculate the distance between 2 path

d=0;
for i=1:size(A,1)
    d=d+Distance(A(i,:),B(i,:));
end
distance=d/size(A,1);


end

