function v = vit(y,f)
    k = 1;
    x = zeros(4,101);
    x(1:2,1) = 1;
    x(3:4,1)= -1;
    x(1,2) = 1;
    x(2,2) = -1;
    x(3,2) = 1;
    x(4,2) = -1;
    gamma = zeros(4,1);
    P = log(1/(1/2));
    %Let's calculate the transition values for each lambda
    S = struct;
    S(1).name = pp;
    S(2).name = pn;
    S(3).name = np;
    S(4).name = nn;
    S(1).A = f(1) + f(2);
    S(2).A = f(1) - f(2);
    S(3).A = -f(1) + f(2);
    S(4).A = -f(1) - f(2);
    S(1).V = [1 1];
    S(2).V = [1 -1];
    S(3).V = -S(2).V;
    S(4).V = -S(1).V;
    while k<=101
        
        if k == 1
            gamma(1:2) = P + abs(y(1)-f(1)*1)^2
            gamma(3:4) = P + abs(y(1)-f(1)*(-1))^2
            k =k+1
            continue
        else
            for i = 1:4
                for j = 1:2
                    if j == 1:
                        a1 = 1
                    else
                        a1 = -1
                    end
                x(i,1:k+1,j+1) =  [x(i,1:k,1) a1]
                gamma(j) = gamma(j) + lambda(y(k),x(j,k-1),c(j))
            end
        end
        
        
        
        
