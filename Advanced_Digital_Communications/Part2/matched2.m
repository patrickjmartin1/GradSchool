function y = matched2(x,g)
%     h = g(1) + g(2);
%     f = 1;%-(1/(g(2)));
    %h = conj(g(1)) + conj(g(2));
    b = conj([g(2) g(1)]);
    a = 1;
    n = filter(b,a,[x 0]);
    y = n(2:end);
end
