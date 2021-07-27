%% This kind of works 
function n = fmmse6(Y,snr,g)
NumSym = length(Y);
g_matched_filter = conj([g(2) g(1)]);
ggD = conv(g_matched_filter,g); %g(D)*g^*(1/D)
a = ggD; 
a(2) = a(2) + 1/snr; % g(D)*g^*(1/D) + 1/snr;
n = ifft(fft(Y,NumSym).*fft(g_matched_filter,NumSym)./fft(a,NumSym),NumSym);

    
    