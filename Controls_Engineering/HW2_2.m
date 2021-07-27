clear all
close all
format compact
A = [0,1,0;0,0,1;-30,-31,-10];
B = [0;0;1];
R = 1;
H = [2,0,0;0,2,0;0,0,2] ;
Q = [2,0,0;0,1,0;0,0,2];
syms T s1 s2 s3;
r = [T;0;0];
S = [s1;s2;s3];
syms k1 k2 k3 k4 k5 k6 k7 k8 k9;
BC = [2,0,0,0,2,0,0,0,2,-20,0,0]; %This is the boundary condition needed to solve this problem. 


K=[k1 k2 k3; k4 k5 k6; k7 k8 k9];  %We use this form for K since it must by a symmetric matrix

Kdot = (-K*A) - (A'*K) - Q + (K*B*(R^-1)*B'*K);
Sdot = (A'-K*B*B')*S+Q*r

[t,k] = ode45(@b,[10,0],BC);


F = [-k(:,7), -k(:,8), -k(:,9)]
v = -k(:,12)
figure
plot(t,F(:,1),'r',t,F(:,2),':k',t,F(:,3),'b',t,v,'g');
grid on;
hold on;
legend('F1','F2','F3','v');
title('F(t) & s(t) vs. t')
xlabel('Time')
ylabel('F(t) & s(t)') 

x = [0;0;0];
ut = [];
xt = [];
for i =1:869;
    ustar = F(870-i,:)*x+v(870-i,:);
    x = A*x + B*ustar;
    ut = [ustar;ut];
    xt = [x';xt];
end

figure
plot(t,xt)
legend('x1','x2','x3','u');
title('x(t) & u(t) vs. t')
xlabel('Time')
ylabel('x(t), u(t)')

