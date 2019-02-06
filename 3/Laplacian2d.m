clc;
clear;

Q=-1;
dx=0.1;
n=3/dx+1;

% create initial equation: A*phi=0
A=zeros(n*n,n*n);
phi=zeros(n*n,1);

% give the D boundary values:phi(y=0)=0,phi(y=3)=Q
for i=1:n
    phi(i)=0;
    phi(n*n+1-i)=Q;
end

%create the matrix A
for i=1:n*n
    
    % get (x,y) from i
    if mod(i,n)==0
      x=n;
    else
      x=mod(i,n);
    end
    y=ceil(i/n);
    
    
    if y==1 % D boundary condition, phi=0
        A(i,i)=1;
    else
        if y==n
            A(i,i)=1; % D boundary condition, phi=Q
        else
            if x==1 % N boundary condition
                A(i,i)=-3;
                A(i,i+1)=1;
                A(i,i+n)=1;
                A(i,i-n)=1;
            else
                if x==n  % on the edge of x=3
                    if y<=1/dx+1 % D boundary, phi=0
                        A(i,i)=1;
                    else
                        if y>=2/dx+1 % D boundary, phi=Q
                            A(i,i)=1;
                            phi(i)=Q;
                        else
                            % N boundary
                            A(i,i)=-3;
                            A(i,i-1)=1;
                            A(i,i+n)=1;
                            A(i,i-n)=1;
                        end
                    end
                else
                    % for the points which are not on the boundary
                    A(i,i)=-4;
                    A(i,i+1)=1;
                    A(i,i-1)=1;
                    A(i,i+n)=1;
                    A(i,i-n)=1;
                end
                
            end
        end
    end
end

X=A;
b=zeros(n*n,1);
l=1;
% construct new matrix X from A and new vector b from phi
for i=1:n*n
    if A(i,i)==1
        for j=1:n*n
         if A(j,i)==1
             b(j)=b(j)-phi(i); % find and eliminate the D boundary points 
         end
        end
end
end
for i=1:n*n
l=n*n+1-i;
if X(l,l)==1
    %create X by eliminating the D boundary points
 b(l,:)=[];
 X(l,:)=[];
 X(:,l)=[];
end
end
kk=size(b);

% now we have matrix X and vector b to be solved.
for i=1:kk
    x(i,1)=1;
end
r=b-X*x;
p=r;
I=0;
% use CG
while norm(r,inf)>0.001
    a=r'*r/(p'*X*p);
    x=x+a*p;
    rk=r-a*X*p;
    p=rk+(rk'*rk/(r'*r))*p;
    r=rk;
    I=I+1;
end
l=1;

%relocate the results x(l) back to vector phi(i)
for i=1:n*n
if A(i,i)~=1
phi(i)=x(l);
l=l+1;
end   
end

%use a matrix ph(i,j) to represent phi
for i=1:n*n
    if mod(i,n)==0
      x=n;
    else
      x=mod(i,n);
    end
    y=ceil(i/n);
    ph(x,y)=phi(i);
end

%plot phi
x=0:dx:3;
y=0:dx:3;
[xx,yy]=meshgrid(x,y);
figure(1);
contour(xx,yy,ph');


hold on;
 
%caculate (U,V)
for i=2:3/dx
    for j=2:3/dx
      u(i,j)=(ph(i,j+1)-ph(i,j-1))/(2*dx);
      v(i,j)=-(ph(i+1,j)-ph(i-1,j))/(2*dx);
    end
end
figure(2);
xxx=0:dx:3-dx;
yyy=xxx;
%plot (U,V)
quiver(xxx,yyy,v',u');
