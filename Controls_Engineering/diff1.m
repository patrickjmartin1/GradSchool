clear all
close all
format compact
A = [0,1,0;0,0,1;-30,-31,-10];
B = [0;0;1];
% first = A*B;
% second = A^2 *B;
% Pc = [B X Y];
% 
% det(Pc) ; %if this is not equal to 0 then we have a controllable system

H = [2,0,0;0,2,0;0,0,2] ;
Q = [2,0,0;0,1,0;0,0,2];
syms k1 k2 k3 k4 k5 k6 k7 k8 k9;
% 
K=[k1 k2 k3; k2 k5 k4; k7 k8 k9];
% 
ricatti = - K*A - (A')*K - Q + K*B*B'*K

[t,k] = ode23t(@a,[10,0],H);

F1 = -k(:,7) %These three lines define our feedback gains
F2 = -k(:,8)
F3 = -k(:,9)

%the following lines plot our K and F's for this system.

figure
plot(t,k(:,1),'r',t,k(:,2),':k',t,k(:,3),'b',t,k(:,4),'g',t,k(:,5),'m',t,k(:,6),'--k',t,k(:,7),'k',t,k(:,8),'--r',t,k(:,9),'--b');
grid on;
hold on;
plot(t,F1,'--b',t,F2,'--r',t,F3,'--g','LineWidth',2)
legend('k1','k2','k3','k4','k5','k6','k7','k8','k9','F1','F2','F3');
title('K(t) & F(t) vs. t')
xlabel('Time')
ylabel('K(t), F(t)') 

figure
plot(t,k(:,7),'k',t,k(:,8),'--r',t,k(:,9),'--b');
grid on;
hold on;
plot(t,F1,'--b',t,F2,'--r',t,F3,'--g','LineWidth',2)
legend('k31','k32','k33','F1','F2','F3');
title('K(t) & F(t) vs. t')
xlabel('Time')
ylabel('K(t), F(t)') 

%Below we work through our state equation to see how our system responds
%with the feedback gains we have determined

F = [F1 F2 F3] 
x = [2 ;4 ;1]
ut = []
xt = []
for i =1:132
    ustar = F(133-i,:)*x
    x = A*x + B*ustar
    ut = [ustar;ut]
    xt = [x';xt]
end

figure
plot(t,xt,t,ut)
legend('x1','x2','x3','u');
title('x(t) & u(t) vs. t')
xlabel('Time')
ylabel('x(t), u(t)')
