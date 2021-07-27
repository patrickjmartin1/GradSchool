clear all
% format compact
% 
% fun = @(x) x.^2  
% integral(fun,-1,1)
syms 
eqn = sin(x)*sin(8*pi*cos(x))/(8*pi*cos(x)) == 1/(sqrt(2));
solx = solve(eqn,x)



