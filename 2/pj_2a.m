clc;clear;
syms x y;
f= @(x) (100*(x(2)-x(1)*x(1))^2+(1-x(1))^2);
x0=[-1,1;0,1;2,1];
for i=1:3
[a,fval,exitf,foutput]=fminsearch(f,x0(i,:));
a
fval
foutput.iterations
end
%fmin=0
