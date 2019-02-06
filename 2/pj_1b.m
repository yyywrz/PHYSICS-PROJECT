clc;clear;
syms x y;
f= @(x) ((7.9+0.13*x(1)+0.21*x(2)-0.05*x(1)*x(1)-0.016*x(2)*x(2)-0.007*x(1)*x(2)));
x0=[-9,1;-8,18;1,19;9,10];
fxy=-(7.9+0.13*x+0.21*y-0.05*x*x-0.016*y*y-0.007*x*y);
jxy=jacobian(fxy);
jacob= @(x) ([ 13/100 - (7*x(2))/1000 - x(1)/10; 21/100 - (4*x(2))/125 - (7*x(1))/1000]);
h=hessian(fxy,[x,y]);
h=vpa(h);
for i=1:4
tol=1000;
j=1;
path(i,j,:)=vpa(x0(i,:));
while tol>1e-6
    s=h\jacob(path(i,j,:));
    path(i,j+1,1)=s(1)+path(i,j,1);
    path(i,j+1,2)=s(2)+path(i,j,2);
    tol=abs(f(path(i,j+1,:))-f(path(i,j,:)));
    j=j+1;
    a=path(i,j,1);
    b=path(i,j,2);
end
j
[a,b]
f([a,b])
end
x=linspace(-10,10,41);
y=linspace(0,20,41);
[X Y]=meshgrid(x,y);
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
for l=1:4
figure(l);
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem -- Newton f1');
plot(a,b,'k*','MarkerSize',8);
plot(path(l,:,1),path(l,:,2),'o-r');
end