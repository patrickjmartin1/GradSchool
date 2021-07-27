function v = vit2(y,f)
    k = 1;
    gamma = zeros(4,1);
    P = log(1/(1/2));
    %Let's calculate the transition values for each lambda
    S = struct;
    S(1).name = 'pp'; %naming convention previous state - current state
    S(2).name = 'pn';
    S(3).name = 'np';
    S(4).name = 'nn';
    S(1).L = f(1) + f(2);
    S(2).L = -f(1) + f(2);
    S(3).L = f(1) - f(2);
    S(4).L = -f(1) - f(2);
    S(1).A = [1 1]; %These are the states
    S(2).A = [-1 1];
    S(3).A = [1 -1];
    S(4).A = [-1 -1];
    for i = 1:4
        S(i).V = S(i).A; %These will represent each state's best path thus far
    end
    while k<=100
        
        if k == 1
            S(1).gamma = P + abs(y(1)-f(1)*1)^2;
            S(2).gamma = S(1).gamma;
            S(3).gamma = P + abs(y(1)-f(1)*(-1))^2;
            S(4).gamma = S(3).gamma
            k =k+1;
            continue
            
        elseif k ==2 
            for j = 1:4
                S(j).gamma = S(j).gamma + P + abs(y(2)-f(1)*S(j).A(2)-f(2)*S(j).A(1))^2;
            	k = k+1;
            end
            continue
        else
            for j = 1:4
                S(j).p = [S(j).V 1];
                S(j).n = [S(j).V -1];
                S(j).gamman = S(j).gamma + P + abs(y(k)-f(1)*S(j).n(end)-f(2)*S(j).n(end-1))^2;
                S(j).gammap = S(j).gamma + P + abs(y(k)-f(1)*S(j).p(end)-f(2)*S(j).p(end-1))^2;
                S(j).pfinalstate = [S(j).p(end) S(j).p(end-1)];
                S(j).nfinalstate = [S(j).p(end) S(j).p(end-1)];
            end
            for j = 1:4
                state = S(j).A;
                l = 1;
                for i = 1:4
                    if S(i).pfinalstate == state
                        gamma(l) = S(i).gammap;
                        path(l) = [S(i).p];
                        l = l+1;
                    elseif S(i).nfinalstate == state
                        gamma(l) = S(i).gamman;
                        path(l) = [S(i).n];
                        l = l+1;
                    else 
                        continue
                    end
                end
            end
                if gamma(1)<gamma(2)
                    S(j).V = path(1)
                    S(j).gamma = gamma(1)
                else
                    S(j).V = path(2)
                    S(j).gamma = gamma(2)
                end
            k = k+1
        end
    end    
      
        
        