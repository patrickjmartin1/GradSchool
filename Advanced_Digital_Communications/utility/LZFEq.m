function L = LZFEq(Y,g) %Y is the input string of symbols, g is the initial channel
    f = 1/(g(1)+g(2));
    L  = Y*f;
    