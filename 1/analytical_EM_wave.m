clc;
clear;
t=0;
a=22.86/1000;
f=8.2*10^9;
lc=2*a;
u=4*pi*10^(-7);
b=10.16/1000;
H0=1;
l=(3*10^8)/f;
c=0.05;
lg=l/((1-(l/lc)^2)^0.5);
B=2*pi/lg;
dx=2.5/1000;
w=B*(3*10^8);
xx=0:dx:a;
yy=0:dx:b;
zz=0:dx:c;

[x,y,z]=meshgrid(xx,yy,zz);
dt=(3e-11)/48*2*pi;
figure;
f = getframe;
[im,map] = rgb2ind(f.cdata,256,'nodither');

for i=1:48
hold off
t=t+dt;
hx=-B.*(a/pi).*H0.*sin(pi.*x./a).*sin(w*t-B.*z);
hy=zeros(size(y));
hz=H0*cos(pi.*x./a).*cos(w*t-B.*z);
quiver3(z,x,y,hz,hx,hy,'b');
hold on;
ex=zeros(size(x));
ey=u*w*(a/pi)*H0*sin((pi/a).*x).*cos(w*t-B.*z);
ez=zeros(size(z));
quiver3(z,x,y,ez,ex,ey,'r');

axis equal;
ylabel('x');
zlabel('y');
f=getframe;
im(:,:,1,i) = rgb2ind(f.cdata,map,'nodither');
end

imwrite(im,map,'Analytical.gif','DelayTime',0,'LoopCount',inf)

