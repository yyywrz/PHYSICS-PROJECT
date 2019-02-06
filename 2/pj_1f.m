clc;clear;
syms x y r;
f= @(x) (-(7.9+0.13*x(1)+0.21*x(2)-0.05*x(1)*x(1)-0.016*x(2)*x(2)-0.007*x(1)*x(2)));
x0=[-9,1;-8,18;1,19;9,10];
B=[0 0];G=[0 0];W=[0 0];M=[0 0];T=B;C1=B;C2=B;C=B;

for it=1:4
tol=1000;
l=1;
for j=1:4
    if j~=it
        v(l,:)=x0(j,:);
        l=l+1;
    end
end
j=1;
for m=1:3
    for n=1:2
      path(it,m,n)=v(m,n);
    end
end
while tol>1e-6
    B(1)=path(it,3*j-2,1);
    G(1)=path(it,3*j-1,1);
    W(1)=path(it,3*j,1);
    B(2)=path(it,3*j-2,2);
    G(2)=path(it,3*j-1,2);
    W(2)=path(it,3*j,2);
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
    path(it,3*j-2,1)=B(1);
    path(it,3*j-1,1)=G(1);
    path(it,3*j,1)=W(1);
    path(it,3*j-2,2)=B(2);
    path(it,3*j-1,2)=G(2);
    path(it,3*j,2)=W(2);
    tol=abs(f(B)-f(G));
end
p(it)=j
B
-f(B)
end


x=linspace(-10,10,41);
y=linspace(0,20,41);
[X Y]=meshgrid(x,y);
for it=1:4
    figure(it);
    
for i=1:1:41
for j=1:1:41
xym=[X(i,j), Y(i,j)];
Z(i,j)=f(xym);
end
end
contour(X,Y,Z,40);
hold on;
xlabel('x'); ylabel('y');

    for j=1:p(it)
    x=[path(it,3*j-2,1),path(it,3*j-1,1),path(it,3*j,1),path(it,3*j-2,1)];
    y=[path(it,3*j-2,2),path(it,3*j-1,2),path(it,3*j,2),path(it,3*j-2,2)];
     plot(x,y);
     hold on
    end
    hold on
end