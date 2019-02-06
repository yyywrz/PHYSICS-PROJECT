clc;clear;
syms x y r;
f= @(x) ((7.9+0.13*x(1)+0.21*x(2)-0.05*x(1)*x(1)-0.016*x(2)*x(2)-0.007*x(1)*x(2)));
x0=[-9,1;-8,18;1,19;9,10];
fxy=-(7.9+0.13*x+0.21*y-0.05*x*x-0.016*y*y-0.007*x*y);
jacob= @(x) ([ 13/100 - (7*x(2))/1000 - x(1)/10; 21/100 - (4*x(2))/125 - (7*x(1))/1000]);
h=vpa(hessian(fxy,[x,y]));

for i=1:4
tol=1000;
j=1;
path(i,j,:)=vpa(x0(i,:));
while tol>1e-6
    xk=path(i,j,:);
    s=jacob(path(i,j,:));
    xs=xk(1)-r*s(1);
    ys=xk(2)-r*s(2);
    g=subs(fxy,x,xs);
    g=subs(g,y,ys);
    h=diff(g);
    q=solve(h,r);
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
    
    for j=1:p(4)
    path4(j,1)=path(4,j,1);
    path4(j,2)=path(4,j,2);
    end
    
x=linspace(-10,10,41);
y=linspace(0,20,41);
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
xlabel('x'); ylabel('y'); title('Computer Problem -- Contour Plot of f and Steepest Descent');
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
xlabel('x'); ylabel('y'); title('Computer Problem -- Contour Plot of f and Steepest Descent');
plot(a,b,'k*','MarkerSize',8);
plot(path2(:,1),path2(:,2),'r-o');
hold on

figure(4);
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem -- Contour Plot of f and Steepest Descent');
plot(a,b,'k*','MarkerSize',8);
plot(path3(:,1),path3(:,2),'r-o');
figure(3);
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem -- Contour Plot of f and Steepest Descent');
plot(a,b,'k*','MarkerSize',8);
plot(path4(:,1),path4(:,2),'r-o');