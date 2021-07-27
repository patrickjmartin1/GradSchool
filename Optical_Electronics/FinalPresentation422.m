clc;close all;clear all;
h = .4*10^-6; %Full Width of wave guide
t = .6*10^-6;
c = 3*10^8; %speed of light
n1 = 3.48; %n inside the wave guide
n2 = 1; %ambient index of refraction 
n3 = 1.44; %index of underlying substrate
lambda = .1e-6; %wavelength of incident light
w = c/lambda; %frequency of light (in vacuum)
a = input('Enter number of horizontal nodes');
b = input('Enter number of vertical nodes');
if(a>1 || b>1)
    disp('Please enter values of a and b either 0 or 1');
    return;
end
[kx,ky] = KFetcher(a,b);

x = linspace(-.6e-6, .6e-6, 1200); %horizontal domain for our wave guide
y = linspace(-.6e-6, .6e-6, 1200); %Vertical Domain

    
if(a == 0 )
    C2 = cos(kx*t/2);
    C3 = C2;
    C4 = cos(ky*h/2);
    C5 = C4;
    B = sqrt( (w*n1/c)^2 - kx^2 - ky^2 );
    gam2 = sqrt( B^2 - (w*n2/c)^2 + ky^2 );
    gam3 = gam2;
    gam4 = sqrt( B^2 - (w*n2/c)^2 + kx^2 );
    gam5 = gam4;
    Ex = [];
    E3 = [];
    for i = 901:1200
        e = C3*exp(-1*gam3*(x(i)-(t/2)));
        E3 = [E3 e];
    end
    E1  = [];
    for i = 301:900
        e = cos(kx*x(i));
        E1 = [E1 e];
    end
    E2 =[];
    for i = 1:300
        e = C2*exp(gam2*(x(i)+(t/2)));
        E2 = [E2 e];
    end
    Ex = [E2 E1 E3];
else
    C2 = -sin(kx*t/2);
    C3 = -C2;
    C4 = -sin(ky*h/2);
    C5 = -C4;
    B = sqrt( (w*n1/c)^2 - kx^2 - ky^2 );
    gam2 = sqrt( B^2 - (w*n2/c)^2 + ky^2 );
    gam3 = gam2;
    gam4 = sqrt( B^2 - (w*n2/c)^2 + kx^2 );
    gam5 = gam4;
    E3 = [];
    for i = 901:1200
        e = C3*exp(-1*gam3*(x(i)-(t/2)));
        E3 = [E3 e];
    end
    E1  = [];
    for i = 301:900
        e = sin(kx*x(i));
        E1 = [E1 e];
    end
    E2 =[];
    for i = 1:300
        e = C2*exp(gam2*(x(i)+(t/2)));
        E2 = [E2 e];
    end
    Ex = [E2 E1 E3];
end
Ey = [];
if(b == 0)
    C2 = cos(kx*t/2);
    C3 = C2;
    C4 = cos(ky*h/2);
    C5 = C4;
    B = sqrt( (w*n1/c)^2 - kx^2 - ky^2 );
    gam2 = sqrt( B^2 - (w*n2/c)^2 + ky^2 );
    gam3 = gam2;
    gam4 = sqrt( B^2 - (w*n2/c)^2 + kx^2 );
    gam5 = gam4;
    E4 = [];
    for i = 1:400
        e = C4*exp(gam4*(y(i)+(h/2)));
        E4 = [E4 e];
    end
    E6  = [];
    for i = 401:800
        e = cos(ky*y(i));
        E6 = [E6 e];
    end
    E5 =[];
    for i = 801:1200
        e = C5*exp(-1*gam5*(y(i)-(h/2)));
        E5 = [E5 e];
    end
    Ey = [E4 E6 E5];
else
    C2 = -sin(kx*t/2);
    C3 = -C2;
    C4 = -sin(ky*h/2);
    C5 = -C4;
    B = sqrt( (w*n1/c)^2 - kx^2 - ky^2 );
    gam2 = sqrt( B^2 - (w*n2/c)^2 + ky^2 );
    gam3 = gam2;
    gam4 = sqrt( B^2 - (w*n2/c)^2 + kx^2 );
    gam5 = gam4;
    E4 = [];
    for i = 1:400
        e = C4*exp(gam4*(y(i)+(h/2)));
        E4 = [E4 e];
    end
    E6  = [];
    for i = 401:800
        e = sin(ky*y(i));
        E6 = [E6 e];
    end
    E5 =[];
    for i = 801:1200
        e = C5*exp(-1*gam5*(y(i)-(h/2)));
        E5 = [E5 e];
    end
    Ey = [E4 E6 E5];
end

%boundary = rectangle('Position',[300,400,600,400]);
Etotal = Ey'*Ex;
EtotAbs = Etotal.^2;
figure;
surf(Etotal,'EdgeColor','none');
colormap default;
hold on;
rectangle('Position',[300,400,600,400],'EdgeColor','r');