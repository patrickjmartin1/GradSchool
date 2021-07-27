function p = pulseshape(t,T,B)
p = (1/T)*sinc(t/T)*(cos(pi*B*t/T))/(1-(2*B*t/T)^2);
