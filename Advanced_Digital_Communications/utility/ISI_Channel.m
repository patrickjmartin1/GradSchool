clear all
close all
clc
%% Constants

N = 100;
N0 = 1/25;
beta = 1/2*(1-1i); %Part of the baseband impulse response (See HW desc.)
inputbits = (rand(1,N) > 1/2); %A stream of random bits we wish to transmit (formerly 'infobits')

X = (2*inputbits)-1; % converting bits to 2PAM modulation
g = [1, beta]; % This results in the value of the channel @ every instant in time having the value 1+\Beta. It appears that \Beta represents our ISI
noise = sqrt(N0/2)*(randn(1,N+length(g)-1)+1i*randn(1,N+length(g)-1));
Y = conv(X,g)+noise;
%d
awgndec = sign(real(Y));%conj(g(1))*Y));% matched filter + 2PAM `slicer' - This is the Decoder0 
V = vit3(real((conj(g(1))*Y)),g);% Viterbi algorithm applied to the matched filter
L = sign(real(LZFEq(Y,g))); %Linear Zero Forcing Equalizer


