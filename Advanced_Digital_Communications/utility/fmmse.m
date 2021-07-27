function m = fmmse(Y,snr,g)
    f = (snr)*(conj(g(1)) + conj(g(2)))/(snr*(g(1)+g(2))*(conj(g(1))+conj(g(2)))+1);
    m = Y*f;
    
    