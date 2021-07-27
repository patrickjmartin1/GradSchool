%% This kind of works 
function L_map = DFE_MMSE(Y,snr,g)
NumSym = length(Y);
zvD = ( (1/snr+(g*g'))-sqrt((1/snr+(g*g')).^2-4*abs(g(2))^2) ) ./ (2*conj(g(2)));
Z = fmmse6(Y,snr,g);
L = ifft(fft(Z,NumSym).*fft([1 -zvD],NumSym),NumSym);
L_map(1) = MAP(L(1));
for i = 2:length(L)
    L_map(i) = MAP(L(i)-zvD*L_map(i-1));
end
L_map = L_map(1:100);

    
    