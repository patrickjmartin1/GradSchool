clear all
close all
format compact

B = [0;0;1];  %defines B matrix
A = [0,1,0;0,0,1;-1/4,1/2,1/2]; %defines A matrix
I = [1,0,0;0,1,0;0,0,1];
Q = [1,0,0;0,2,0;0,0,2];
x_0 = [2;2;2];

Pc = [B A*B (A^2)*B];  %defines our controllability matrix

det(Pc);  %calculates the determinant of our controllability matrix to determine if it is controllable. 
P = [2,0,0;0,2,0;0,0,2] ;%defines P matrix
F1 = -(1+B'*P*B)^-1 %calculates the inverse part of the feedback gains
F2 = B'*P*A %calculates the second part of feedback gains
F = F1*F2  %calculates the full feedback gains
% Ftotfrac = rat( F1*F2 ) %returns feedback gains as fraction. 

Pnew = P %Set P(0) = to this variable to calculate its iterations appropriately
Fnew = F
Gains = F'

for k = 1:7 %This is our for loop for calculating the feedback gains and applying them to a matrix appropriately. 
    Pnew = (A' + Fnew'*B')*Pnew*(A + B*Fnew) + Q + Fnew'*Fnew
    Fnew = -((1+B'*Pnew*B)^-1)*B'*Pnew*A
    Gains = [Fnew' Gains]
end

figure %This code plots our feedback gains vs. k
m = linspace(1,8,8)
plot(m,Gains(1,1:8),'-r')
hold on
plot(m, Gains(2,1:8),'-b')
hold on
plot(m, Gains(3,1:8),'-g')
title('Feedback Gains vs. k')
xlabel ( 'Index, k' ) ;
ylabel ( 'Feedback Gains, F(k)' ) ;
grid on ;
hold off

xstate = x_0; %This code allows us to come up with a state history
xplus1 = x_0
controls = [0;0;0]
for j = 1:8;
    controlplus1 = B*Gains(1:3,j)'*xplus1
    controls = [controls controlplus1]
    xplus1 = A*xplus1 + B*Gains(1:3,j)'*xplus1
    xstate = [xstate xplus1] 
end

figure %This code plots our feedback gains vs. k
n = linspace(0,8,9)
plot(n,xstate(1,1:9),'-r')
hold on
plot(n, xstate(2,1:9),'-b')
hold on
plot(n, xstate(3,1:9),'-g')
plot(n,controls(1,1:9),'--ok')
hold on
plot(n, controls(2,1:9),'--m')
hold on
plot(n, controls(3,1:9),'--k')
title('States and Controls vs. k')
xlabel ( 'Index, k' ) ;
ylabel ( 'State and Controls, x(k), u(k)' ) ;
grid on ;
hold off
