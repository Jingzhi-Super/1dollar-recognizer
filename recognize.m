function [n,score] = recognize(points,temp)
% match points against a set of templates
global SquareSize NumTemplates AngleRange
d=zeros(NumTemplates,1);
for i=1:NumTemplates
    [d(i)]=distanceatbestangle(points,temp{i},-AngleRange,AngleRange);
end
templatename={'0','1','2','3','4','5','6','7','8','9'};
n=templatename{d==min(d)};
score=1-min(d)/(0.5*sqrt(SquareSize^2+SquareSize^2));
 
end

