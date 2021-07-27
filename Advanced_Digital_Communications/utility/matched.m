function y = matched(x,g)
    h = conj(g(1)) + conj(g(2));
    y = x*h;%(h/f);
end
