clc;
clear;
syms x y;
% boundary function f
fxy=(x^3)*y-x*(y^3)-0.5*x^2;
f=matlabFunction(fxy);
%first order partial differential function
fnx=matlabFunction(diff(fxy,x));
fny=matlabFunction(diff(fxy,y));
%second order partial differential function
fnxx=matlabFunction(diff(diff(fxy,x),x));
fnyy=matlabFunction(diff(diff(fxy,y),y));
% coefficiant D
D=1;
% Xmax & Ymax
xm=3;
ym=2;
% dt & dx
dt=0.001;
dx=0.1;

%set up the initial condition

for i=1:(xm/dx+1)
    for j=1:(ym/dx+1)
        if (i==1)||(j==1)||((i==1/dx+1)&(j>1/dx))||((j==1/dx+1)&(i>1/dx))
            %apply the D boundary 
            phi(1,i,j)=f((i-1)*dx,(j-1)*dx);
        else
            if (j==2/dx+1)&(i<1/dx+1)
                %apply the N boundary for y=2,0<x<1 (df/dy)
                phi(1,i,j)=fny((i-1)*dx,(j-1)*dx);
            else
                if (i==3/dx+1)&(j<1/dx+1)
                    %apply the N boundary for x=3,0<y<1 (df/dx)
                    phi(1,i,j)=fnx((i-1)*dx,(j-1)*dx);
                else
                    % rest of points phi(0)=0
                    phi(1,i,j)=0;
                end
            end
        end
        %copy the data in matrix [p] for plot
        p(i,j)=phi(1,i,j);
    end
end

figure
% draw the shape of the domain
x=0:dx:3;
y=0*x;
plot(x,y,'k');
y=0:dx:2;
x=0*y;
hold on
plot(x,y,'k');
x=1:dx:3;
y=(x./x)*1;
hold on
plot(x,y,'k');
hold on
y=1:dx:2;
x=(y./y)*1;
plot(x,y,'k');
hold on
% plot the initial value of phi by matrix [p]
[x,y]=meshgrid(0:dx:3,0:dx:2);
grid on
h=contour(x,y,p');
m(1)=getframe;
hold off

% start to caculate the phi with respect to time
for k=2:50 %iteration=50
    for i=1:(3/dx+1)
        for j=1:(2/dx+1)            
        if (i==1)||(j==1)||((i==1/dx+1)&(j>1/dx))||((j==1/dx+1)&(i>1/dx))
            %Ponits in D boundary 
            phi(k,i,j)=f((i-1)*dx,(j-1)*dx);
        else
            if (j==2/dx+1)&(i<1/dx+1)
                %points in N boundary y=2,0<x<1
                phi(k,i,j)=phi(k-1,i,j)+dt*D*fnyy((i-1)*dx,(j-1)*dx)+(phi(k-1,i,j)+phi(k-1,i,j-2)-2*phi(k-1,i,j-1))*(D*dt/(dx*dx));
            else
                if (i==3/dx+1)&(j<1/dx+1)
                %points in N boundary x=2,0<y<1
                    phi(k,i,j)=phi(k-1,i,j)+dt*D*fnxx((i-1)*dx,(j-1)*dx)+(phi(k-1,i,j)+phi(k-1,i-2,j)-2*phi(k-1,i-1,j))*(D*dt/(dx*dx));
                else
                    if (i<1/dx+1)||(j<1/dx+1)
                        % center points 
                     phi(k,i,j)=phi(k-1,i,j)+(phi(k-1,i+1,j)+phi(k-1,i-1,j)+phi(k-1,i,j+1)+phi(k-1,i,j-1)-4*phi(k-1,i,j))*(D*dt/(dx*dx));
                    end
                end
            end
        end
        %copy the data to the matrix [p]
        p(i,j)=phi(k,i,j);
        end
    end
    %plot the shape of domain
    x=0:dx:3;
y=0*x;
plot(x,y,'k');
y=0:dx:2;
x=0*y;
hold on
plot(x,y,'k');
x=1:dx:3;
y=(x./x)*1;
hold on
plot(x,y,'k');
hold on
y=1:dx:2;
x=(y./y)*1;
plot(x,y,'k');
hold on
%plot the current value of phi by matrix [p]
[x,y]=meshgrid(0:dx:3,0:dx:2);
grid on
h=contour(x,y,p');
m(k)=getframe;
hold off
end
