clc;
clear;
    figure(1);
    
a=22.86/1000;
t=0;
T2=22.86/1000;
f=8.2*10^9;
lc=2*T2;
u=4*pi*10^(-7);
b=10.16/1000;
H0=1;
l=(3*10^8)/f;
c=0.05;
lg=l/((1-(l/lc)^2)^0.5);
B=2*pi/lg;
k=2*pi*f/(3*10^8);
dx=2.5/1000;
w=B*(3*10^8);

dt=(3e-11)/48*2*pi;
t=0:dt:48*dt;

for i=1:48
Tr(1)=H0;
T1r(1)=0;
T2r(1)=-w^2;
T1r(i+1)=T1r(i)+dt*T2r(i);
Tr(i+1)=Tr(i)+dt*T1r(i);
T2r(i+1)=-w^2*Tr(i+1);


Ti(1)=0;
T1i(1)=w;
T2i(1)=0;
T1i(i+1)=T1i(i)+dt*T2i(i);
Ti(i+1)=Ti(i)+dt*T1i(i);
T2i(i+1)=-w^2*Ti(i+1);
end
h3=plot(t,Tr,'b');
X=cos(w.*t);
hold on
h4=plot(t,Ti,'y');
xlabel('t');
ylabel('T');
legend([h3,h4],'Treal','Tima')
figure(2);
z=0:dx:c;
for i=1:20
    
Zr(1)=H0;
Z1r(1)=0;
Z2r(1)=-B^2;
Z1r(i+1)=Z1r(i)+dx*Z2r(i);
Zr(i+1)=Zr(i)+dx*Z1r(i);
Z2r(i+1)=-B^2*Zr(i+1);


Zi(1)=0;
Z1i(1)=-B;
Z2i(1)=0;
Z1i(i+1)=Z1i(i)+dx*Z2i(i);
Zi(i+1)=Zi(i)+dx*Z1i(i);
Z2i(i+1)=-B^2*Zi(i+1);
end
h1=plot(z,Zr,'b');
X=cos(-B.*z);
hold on
h2=plot(z,Zi,'y');

xlabel('z');
ylabel('Z');
legend([h1,h2],'Zreal','Zima')
figure(3);
f = getframe;
[im,map] = rgb2ind(f.cdata,256,'nodither');
xx=0:dx:a;
yy=0:dx:b;
zz=0:dx:c-dx;
[x,y,z]=meshgrid(xx,yy,zz);
for l=1:49
 for j=1:10
    for i=1:5
        for k=1:20
            hz(i,j,k)=H0*cos(pi*(j-1)*dx/a)*(Tr(l)*Zr(k)-Ti(l)*Zi(k));
            hx(i,j,k)=-B*(a/pi)*H0*sin(pi*(j-1)*dx/a)*(Ti(l)*Zr(k)+Tr(l)*Zi(k));
            hy(i,j,k)=0;
            ex(i,j,k)=0;
            ey(i,j,k)=-u*w*(a/pi)*H0*sin(pi*(j-1)*dx/a)*(Tr(l)*Zr(k)-Ti(l)*Zi(k));
            ez(i,j,k)=0;
        end
    end
 end
 quiver3(z,x,y,hz,hx,hy,'b');
 hold on
 quiver3(z,x,y,ez,ex,ey,'r');
 axis equal
 f=getframe;
im(:,:,1,l) = rgb2ind(f.cdata,map,'nodither'); 
hold off
end

imwrite(im,map,'Numerical.gif','DelayTime',0,'LoopCount',inf)

figure(4);
for l=1:49
    for k=1:20
        U(l,k)=(Tr(l)*Zr(k)-Ti(l)*Zi(k));
        uu(l,k)=cos(w*(l-1)*dt-B*(k-1)*dx);
    end
end
surf(U)
title('f=real(T(t)Z(z))');
figure(5)
surf(uu)
title('Exact Solution')
