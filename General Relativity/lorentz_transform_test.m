x = [10; 20; 14; 1];
v = 0.7;
phi = atanh(v);

Lambda_phi = [
    [cosh(phi),     -sinh(phi), 0,  0];
    [-sinh(phi),    cosh(phi),  0,  0];
    [0,             0,          1,  0];
    [0,             0,          0,  1]
    ];

Lambda_v = [
    [gam(v),        -gam(v) * v,	0,  0];
    [-gam(v) * v,   gam(v),         0,  0];
    [0,             0,              1,  0];
    [0,             0,              0,  1]
    ];

x_phi = Lambda_phi * x;
x_v = Lambda_v * x;

disp(x_phi)
disp(x_v)
      