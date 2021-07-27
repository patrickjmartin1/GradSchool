
A = [0,1,0;0,0,1;-30,-31,-10];
B = [0;0;1];
R = 1;
H = [2,0,0;0,2,0;0,0,2] ;
Q = [2,0,0;0,1,0;0,0,2];
syms T s1 s2 s3;
r = [T;0;0];
S = [s1;s2;s3];
syms k1 k2 k3 k4 k5 k6;


[t,s] = ode45(@c,[10,0],-H*[10;0;0]);

plot(t,s(:,1),'r',t,s(:,2),':k',t,s(:,3),'b');
grid on;
hold on;
%plot(t,F1,'--b',t,F2,'--r',t,F3,'--g','LineWidth',2)
%legend('k1','k2','k3','k4','k5','k6','k7','k8','k9','F1','F2','F3');
title('K(t) & F(t) vs. t')
xlabel('Time')
ylabel('K(t)') 
