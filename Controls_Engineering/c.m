function dsdt = c(t2,s)
dsdt = [ 2*t2 - s(3)*( 30);
  s(1) - s(3)*(31);
  s(2) - s(3)*(10)]