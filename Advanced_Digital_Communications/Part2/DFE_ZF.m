function L_map = DFE_ZF(Y,g) %Y is the input string of symbols, g is the initial channel
b = 1;
a = [g(1) g(2)];
L = filter(b,a,Y);
%     L = L(1:end-1);
L_map(1) = MAP(L(1));
for i = 2:length(L)
    b_D = g(2) * L_map(i-1);
    L_map(i) = MAP(L(i)-b_D);
end
L_map = L_map(1:100);

    
    