clc;clear;
syms x y;
f= @(x) (100*((x(2)-x(1)*x(1))^2)+(1-x(1))^2);
x0=[-1,1;0,1;2,1];
fxy=100*(y-x*x)^2+(1-x)^2;
jacob= @(x) ([ 2*x(1) - 400*x(1)*(- x(1)^2 + x(2)) - 2; - 200*x(1)^2 + 200*x(2)]);
xi=[0;0];
for kkk=1:3
xi(1)=x0(kkk,1);
xi(2)=x0(kkk,2);
j=1;
B=eye(2);
tol=10000;
path=xi;
maxx=-100;
maxy=-100;
minx=100;
miny=100;
y=[100;100];
while (abs(y(2))>1e-6)|(abs(y(1))>1e-6)
    s=-inv(B)*jacob(xi);
    xii=xi+s;
    y=jacob(xii)-jacob(xi);
    B=B+(y*(y'))/((y')*s)-(B*s*(s')*B)/((s')*B*s);
    tol=abs(f(xii)-f(xi));
    xi=xii;
    j=j+1;
    if xi(1)>maxx 
        maxx=xi(1);
    end
    if xi(2)>maxy 
        maxy=xi(2);
    end
    if xi(1)<minx 
        minx=xi(1);
    end
    if xi(2)<miny 
        miny=xi(2);
    end
    path(1,j)=xi(1);
    path(2,j)=xi(2);
    path(3,j)=f(xi);
end
figure(kkk);
j

x=linspace(round(minx),round(maxx),101);
y=linspace(round(miny),round(maxy),101);
[X Y]=meshgrid(x,y);
for i=1:1:101
for l=1:1:101
xym=[X(i,l), Y(i,l)];
Z(i,l)=f(xym);
end
end
contour(X,Y,Z,100);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem -- f2');
plot(path(1,:),path(2,:),'r-o');
plot(xi(1),xi(2),'k*','MarkerSize',8);
hold on

end