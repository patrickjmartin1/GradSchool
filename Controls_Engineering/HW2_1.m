clear all 
close all
format compact

A = [0,1,0;0,0,1;-30,-31,-10];
B = [0;0;1];
X = A*B;
Y = A^2 *B;
Z = [B X Y];

%det(Z) ; %if this is not equal to 0 then we have a controllable system

H = [2,0,0;0,2,0;0,0,2] ;
Q = [2,0,0;0,1,0;0,0,2];
syms k1 k2 k3 k4 k5 k6 k7 k8 k9;

K=[k1 k2 k3; k4 k5 k6; k7 k8 k9];

ricatti = -K*A - A'*K - Q + K*B*B'*K