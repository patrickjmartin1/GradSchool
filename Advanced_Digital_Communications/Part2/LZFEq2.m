function L = LZFEq2(Y,g) %Y is the input string of symbols, g is the initial channel
    b = 1;
    a = [g(1) g(2)];
    L = filter(b,a,Y);
    L = L(1:end-1);
    