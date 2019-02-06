clc;clear;
syms x y;
f= @(x) (100*(x(2)-x(1)*x(1))^2+(1-x(1))^2);
x0=[-1,1;0,1;2,1];
fxy=100*(y-x*x)^2+(1-x)^2;
jxy=jacobian(fxy);
jacob= @(x) ([ 2*x(1) - 400*x(1)*(- x(1)^2 + x(2)) - 2; - 200*x(1)^2 + 200*x(2)]);
hxy=hessian(fxy,[x,y]);
hes= @(x) ([1200*x(1)^2 - 400*x(2) + 2,-400*x(1);-400*x(1),200]);
for i=1:3
tol=1000;
j=1;
path(i,j,:)=vpa(x0(i,:));
while tol>1e-6
    h=hes(path(i,j,:));
    s=-h\jacob(path(i,j,:));
    path(i,j+1,1)=s(1)+path(i,j,1);
    path(i,j+1,2)=s(2)+path(i,j,2);
    tol=abs(f(path(i,j+1,:))-f(path(i,j,:)));
    j=j+1;
    a=path(i,j,1);
    b=path(i,j,2);
end
p(i)=j
[a,b]
f([a,b])
end
    for j=1:p(1)
    path1(j,1)=path(1,j,1);
    path1(j,2)=path(1,j,2);
    end
    
    for j=1:p(2)
    path2(j,1)=path(2,j,1);
    path2(j,2)=path(2,j,2);
    end
   
    for j=1:p(3)
    path3(j,1)=path(3,j,1);
    path3(j,2)=path(3,j,2);
    end
    
x=linspace(-4,4,41);
y=linspace(-4,4,41);
[X Y]=meshgrid(x,y);
figure(1);
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem --Newton f2');
plot(a,b,'k*','MarkerSize',8);
plot(path1(:,1),path1(:,2),'r-o');
hold on

figure(2);
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem -- Newton f2');
plot(a,b,'k*','MarkerSize',8);
plot(path2(:,1),path2(:,2),'r-o');
hold on

figure(3);
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem -- Newton f2');
plot(a,b,'k*','MarkerSize',8);
plot(path3(:,1),path3(:,2),'r-o');