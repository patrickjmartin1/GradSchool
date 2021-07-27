function [ kxValue,kyValue ] = KFetcher( kxIndex,kyIndex )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    h = .4*10^-6; %Full Width of wave guide
    t = .6*10^-6;
    c = 3*10^8; %speed of light
    n1 = 3.48; %n inside the wave guide
    n2 = 1; %ambient index of refraction 
    n3 = 1.44; %index of underlying substrate
    lambda = .1e-6; %wavelength of incident light
    w = c/lambda; %frequency of light (in vacuum)

    gEven =@(k) (k^-2).*((w/c)^2)*(n1^2-n2^2)-1-(cot(k*t/2).^2);
    jEven =@(l) (l^-2).*((w/c)^2)*(n1^2-n2^2)-1-((cot(l*h/2))).^2;
    gOdd =@(k) (k^-2).*((w/c)^2)*(n1^2-n2^2)-1-(tan(k*t/2).^2);
    jOdd =@(l) (l^-2).*((w/c)^2)*(n1^2-n2^2)-1-((tan(l*h/2))).^2;
    
    if(kxIndex == 0)
        x0 = 1.5e6;
        kx = fzero(gOdd,x0);
    else
        x0 = 1e6;
        kx = fzero(gEven,x0);
    end
    
    if(kyIndex == 0)
        x0 = 1e6;
        ky = fzero(jOdd,x0);
    else
        x0 = 1e6;
        ky = fzero(jEven,x0);
    end
    kxValue = kx;
    kyValue = ky;
end

