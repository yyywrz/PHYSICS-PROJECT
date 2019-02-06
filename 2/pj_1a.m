clc;clear;
syms x y;
f= @(x) (-(7.9+0.13*x(1)+0.21*x(2)-0.05*x(1)*x(1)-0.016*x(2)*x(2)-0.007*x(1)*x(2)));
x0=[-9,1;-8,18;1,19;9,10];
for i=1:4
[a,fval,exitf,foutput]=fminsearch(f,x0(i,:));
a
-fval
foutput.iterations
end

