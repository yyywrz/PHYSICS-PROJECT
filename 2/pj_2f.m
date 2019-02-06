clc;clear;
syms x y r;
f= @(x) (100*(x(2)-x(1)*x(1))^2+(1-x(1))^2);
x0=[-1,1;0,1;2,0]; % change (2,1) to (2,0) as the three initial points are colinear. 
B=[0 0];G=[0 0];W=[0 0];M=[0 0];T=B;C1=B;C2=B;C=B;

tol=1000;
v=x0;
j=1;
for m=1:3
    for n=1:2
      path(m,n)=v(m,n);
    end
end
while tol>1e-7
    B(1)=path(3*j-2,1);
    G(1)=path(3*j-1,1);
    W(1)=path(3*j,1);
    B(2)=path(3*j-2,2);
    G(2)=path(3*j-1,2);
    W(2)=path(3*j,2);
    if f(B)>f(W) 
        T=B;
        B=W;
        W=T;
    else
        if f(B)>f(G)
            T=G;
            G=B;
            B=T;
        else
            if f(G)>f(W)
                T=G;
                G=W;
                W=T;
            end
        end
    end        
    M=(G+B)/2;
    R=2*M-W;
    E=2*R-M;
    if f(R)<f(W)
        W=R;
        if f(E)<f(W)
            W=E;
        end
    else
        C1=(R+M)/2;
        C2=(M+W)/2;
        if f(C1)>f(C2) 
            C=C2;
        else
            C=C1;
        end
        if f(C)<f(W)
            W=C;
        else
            W=(B+W)/2;
        end
    end
    j=j+1;
    path(3*j-2,1)=B(1);
    path(3*j-1,1)=G(1);
    path(3*j,1)=W(1);
    path(3*j-2,2)=B(2);
    path(3*j-1,2)=G(2);
    path(3*j,2)=W(2);
    tol=abs(f(B)-f(G));
end
p=j
B
-f(B)


x=linspace(-2,2,41);
y=linspace(-2,2,41);
[X Y]=meshgrid(x,y);
figure;
    
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y'); title('Computer Problem -- Contour Plot of f and Steepest Descent');

    for j=1:p
    x=[path(3*j-2,1),path(3*j-1,1),path(3*j,1),path(3*j-2,1)];
    y=[path(3*j-2,2),path(3*j-1,2),path(3*j,2),path(3*j-2,2)];
     plot(x,y);
     plot(B(1),B(2),'k*','MarkerSize',8);
     hold on
    end