clc;clear;
syms x y r;
f= @(x) (100*(x(2)-x(1)*x(1))^2+(1-x(1))^2);
x0=[-1,1;0,1;2,1];
fxy=100*(y-x*x)^2+(1-x)^2;
jacob= @(x) ([ 2*x(1) - 400*x(1)*(- x(1)^2 + x(2)) - 2; - 200*x(1)^2 + 200*x(2)]);

for i=1:3
tol=1000;
j=1;
path(i,j,:)=vpa(x0(i,:));
s=[100;100];
while (abs(s(1))>1e-6)|(abs(s(2))>1e-6)
    xk=path(i,j,:);
    s=-jacob(xk);
    xs=xk(1)+r*s(1);
    ys=xk(2)+r*s(2);
    g=subs(fxy,x,xs);
    g=subs(g,y,ys);
    h=matlabFunction(g);
    gg=matlabFunction(diff(g));
    q=fzero(gg,0);
    path(i,j+1,1)=subs(xs,r,q);
    path(i,j+1,2)=subs(ys,r,q);
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
    
x=linspace(-2,2,41);
y=linspace(0,6,41);
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
xlabel('x'); ylabel('y'); title('Computer Problem 2d(1)');
plot(path1(:,1),path1(:,2),'r-o');
plot(a,b,'k*','MarkerSize',8);
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
xlabel('x'); ylabel('y'); title('Computer Problem 2d(2)');
plot(path2(:,1),path2(:,2),'r-o');
plot(a,b,'k*','MarkerSize',8);
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
xlabel('x'); ylabel('y'); title('Computer Problem 2d(3)');
plot(path3(:,1),path3(:,2),'r-o');
plot(a,b,'k*','MarkerSize',8);