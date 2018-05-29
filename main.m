clear
clc
% load temp
load Inkdata
Inkdata(:,3)=[];
global NumPoints SquareSize AngleRange AnglePrecision Phi NumTemplates
NumTemplates=10;
NumPoints=64;
SquareSize=0.5;
AngleRange=pi/4;
AnglePrecision=pi/90;
Phi=0.5*(-1+sqrt(5)); % golden ratio
[length] =path_length(Inkdata);
[data] = resample(Inkdata,length);
[data2] = rotatepoints(data);
[data3] = scaling(data2);
% [name,score] = recognize(data3,temp);
% disp(name);
% disp(round(score*100));









    










