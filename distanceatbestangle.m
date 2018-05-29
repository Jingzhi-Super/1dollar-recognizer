function [result] =distanceatbestangle(points,temp,A,B)
% calculate distance at so called best angle
global Phi AnglePrecision 
x1=Phi*A+(1-Phi)*B;
f1=distanceatangle(points,temp,x1);
x2=(1-Phi)*A+Phi*B;
f2=distanceatangle(points,temp,x2);
i=1;
while abs(B-A)>AnglePrecision 
    if f1<f2
        B=x2;
        x2=x1;
        f2=f1;
        x1=Phi*A+(1-Phi)*B;
        f1=distanceatangle(points,temp,x1);
        F(i)=f1;
        i=i+1;
    else
        A=x1;
        x1=x2;
        f1=f2;
        x2=(1-Phi)*A+Phi*B;
        f2=distanceatangle(points,temp,x2);
        F(i)=f2;
        i=i+1;
    end
end
result=min(F);

end

