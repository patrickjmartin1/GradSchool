clear all
close all
format compact

Gf = 1.166e-5
Mt = 1.777

Gamma_tot = 5*(Gf^2 * Mt^5)/(192*pi^3)

Gam_eV = Gamma_tot*1e9

hbar = 4.13567e-15

t  = hbar/Gam_eV

t_tau = 2.96e-13
gam1 = hbar/t_tau
gam2 = gam1 * 1e-9

x = (Gf^2 * Mt^5)/(gam2*pi^3)

y = 192/x