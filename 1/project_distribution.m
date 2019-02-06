clear;
clc;
xm=10;
ym=10;
zm=10;
tol=0.1;
dx=1;
n=xm/dx+1;
phi=zeros(n,n,n);
b=ones(n,n,n);
p=2*tol;
figure(1);
while p>tol
b=phi;
m=0;
for i=1:n
    for j=1:n
        for k=1:n
         if i==1 || i==n || j==1 || j==n || k==1 
             phi(i,j,k)=0;
         else
         if k==n
             phi(i,j,k)=50;
         else
             phi(i,j,k)=(phi(i+1,j,k)+phi(i-1,j,k)+phi(i,j+1,k)+phi(i,j-1,k)+phi(i,j,k+1)+phi(i,j,k-1))/6;
         end
         end
         t=phi(i,j,k)-b(i,j,k);
         if abs(t)>m
             m=abs(t);
         end
        end
    end
end
p=m;
end

for i=1:n
    for j=1:n
        tt(i,j)=phi(i,round(n/2),j);
    end
end
xx=0:dx:xm;
yy=0:dx:ym;
[x,y]=meshgrid(xx,yy);
contour(x,y,tt');
xlabel('x');
ylabel('z');

figure(2);
for i=1:n-1
    for j=1:n-1
        for k=1:n-1
         u(i,j,k)=(phi(i+1,j,k)-phi(i,j,k))/dx;
         v(i,j,k)=(phi(i,j+1,k)-phi(i,j,k))/dx;
         w(i,j,k)=(phi(i,j,k+1)-phi(i,j,k))/dx;
        end
    end
end

xx=0:dx:xm-dx;
yy=0:dx:ym-dx;
zz=0:dx:zm-dx;

[x,y,z]=meshgrid(xx,yy,zz);
quiver3(x,y,z,u,v,w);

for i=1:n
    for j=1:n
        tt(i,j)=phi(i,round(n/2),j);
    end
end


phi=zeros(n,n,n);
b=ones(n,n,n);
p=2*tol;
figure(3);
while p>tol
b=phi;
m=0;
for i=1:n
    for j=1:n
        for k=1:n
         if  k==1  
             phi(i,j,k)=0;
         else
            if k==n
             phi(i,j,k)=50;
         else
             if (i*j==1)||(i*j==n)||(i*j==n*n)
               phi(i,j,k)=(phi(i,j,k+1)+phi(i,j,k-1))/2;
             else
             if (i==1 || i==n)&&(j~=1)&&(j~=n)&&(k~=n)
                 phi(i,j,k)=(phi(i,j+1,k)+phi(i,j-1,k)+phi(i,j,k+1)+phi(i,j,k-1))/4;
             else
                 if (j==1 || j==n)&&(i~=1)&&(i~=n)&&(k~=n)
                     phi(i,j,k)=(phi(i+1,j,k)+phi(i-1,j,k)+phi(i,j,k+1)+phi(i,j,k-1))/4;
                    else
             phi(i,j,k)=(phi(i+1,j,k)+phi(i-1,j,k)+phi(i,j+1,k)+phi(i,j-1,k)+phi(i,j,k+1)+phi(i,j,k-1))/6;
         end
                 end
             end
             end
         end
         t=phi(i,j,k)-b(i,j,k);
         if abs(t)>m
             m=abs(t);
         end
        end
    end
end
p=m;
end

for i=1:n
    for j=1:n
        tt(i,j)=phi(i,round(n/2),j);
    end
end
xx=0:dx:xm;
yy=0:dx:ym;
[x,y]=meshgrid(xx,yy);
contour(x,y,tt');
xlabel('x');
ylabel('z');
figure(4)
for i=1:n-1
    for j=1:n-1
        for k=1:n-1
         u(i,j,k)=(phi(i+1,j,k)-phi(i,j,k))/dx;
         v(i,j,k)=(phi(i,j+1,k)-phi(i,j,k))/dx;
         w(i,j,k)=(phi(i,j,k+1)-phi(i,j,k))/dx;
        end
    end
end

xx=0:dx:xm-dx;
yy=0:dx:ym-dx;
zz=0:dx:zm-dx;

[x,y,z]=meshgrid(xx,yy,zz);
quiver3(x,y,z,u,v,w);


phi=zeros(n,n,n);
b=ones(n,n,n);
p=2*tol;
figure(5);
while p>tol
b=phi;
m=0;
for i=1:n
    for j=1:n
        for k=1:n
         if  k==1 || i==1 
             phi(i,j,k)=0;
         else
            if k==n
             phi(i,j,k)=50;
         else
             if (i*j==1)||(i*j==n)||(i*j==n*n)
               phi(i,j,k)=(phi(i,j,k+1)+phi(i,j,k-1))/2;
             else
             if (i==1 || i==n)&&(j~=1)&&(j~=n)&&(k~=n)
                 phi(i,j,k)=(phi(i,j+1,k)+phi(i,j-1,k)+phi(i,j,k+1)+phi(i,j,k-1))/4;
             else
                 if (j==1 || j==n)&&(i~=1)&&(i~=n)&&(k~=n)
                     phi(i,j,k)=(phi(i+1,j,k)+phi(i-1,j,k)+phi(i,j,k+1)+phi(i,j,k-1))/4;
                    else
             phi(i,j,k)=(phi(i+1,j,k)+phi(i-1,j,k)+phi(i,j+1,k)+phi(i,j-1,k)+phi(i,j,k+1)+phi(i,j,k-1))/6;
         end
                 end
             end
             end
         end
         t=phi(i,j,k)-b(i,j,k);
         if abs(t)>m
             m=abs(t);
         end
        end
    end
end
p=m;
end

for i=1:n
    for j=1:n
        tt(i,j)=phi(i,round(n/2),j);
    end
end
xx=0:dx:xm;
yy=0:dx:ym;
[x,y]=meshgrid(xx,yy);
contour(x,y,tt');
xlabel('x');
ylabel('z');
figure(6)
for i=1:n-1
    for j=1:n-1
        for k=1:n-1
         u(i,j,k)=(phi(i+1,j,k)-phi(i,j,k))/dx;
         v(i,j,k)=(phi(i,j+1,k)-phi(i,j,k))/dx;
         w(i,j,k)=(phi(i,j,k+1)-phi(i,j,k))/dx;
        end
    end
end

xx=0:dx:xm-dx;
yy=0:dx:ym-dx;
zz=0:dx:zm-dx;

[x,y,z]=meshgrid(xx,yy,zz);
quiver3(x,y,z,u,v,w);