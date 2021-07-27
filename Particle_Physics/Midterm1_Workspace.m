clear all
format compact
sig1 = [0 1 ; 1 0];
sig2 = [0 -i ; i 0];
sig3 = [1 0 ; 0 -1];
zero = zeros(2);
I = [1 0 ; 0 1];
gam0 = [I zero;zero -I];
gam1 = [zero sig1 ; -sig1 zero];
gam2 = [zero sig2 ; -sig2 zero];
gam3 = [zero sig3 ; -sig3 zero];
syms t2
syms t
syms s
syms c
syms E
assume(t2,'real');
assume(t,'real');
assume(s, 'real');
assume(c, 'real');
assume(E>0)
% ur = sqrt(E)*[c;s;c;s]; %note that for ur and ul as they apply to particles 3 and 4, we need to effectively multiply many of the values by -1, so the spinors for u3 and v4 will be correct
% ul = sqrt(E)*[-s;c;s;-c];
% vr = sqrt(E)*[c;s;-c;-s];
% vl = sqrt(E)*[s;-c;s;-c];
u3 = sqrt(E)*[1;0;1;0];
v4 = u3
% u1l = sqrt(E)*[0;1;0;-1];
u1= sqrt(E)*[1;0;-1;0];
v2 = sqrt(E)*[0;-1;0;1];
% u3r = ur;
% u3l = ul;
% v4r = vr;
% v4l = vl;

%Sample Calculation
v2l'*gam0*gam0*v4l
v2l'*gam0*gam1*v4l
v2l'*gam0*gam2*v4l
v2l'*gam0*gam3*v4l

