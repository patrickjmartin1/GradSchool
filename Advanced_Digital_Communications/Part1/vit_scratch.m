clear all
close all
N = 100;
beta = 1/2*(1-1i); %Part of the baseband impulse response (See HW desc.)
N0 = 0.04;  % constant to select SNR 


        inputbits = (rand(1,N) > 1/2); %A stream of random bits we wish to transmit (formerly 'infobits')

        X = (2*inputbits)-1; % converting bits to 2PAM modulation
        f = [1, beta]; % This results in the value of the channel @ every instant in time having the value 1+\Beta. It appears that \Beta represents our ISI
        noise = sqrt(N0/2)*(randn(1,N+length(f)-1)+1i*randn(1,N+length(f)-1));
        y = conv(X,f)+noise;
    k = 1;
%     gamma = zeros(4,1);
    P = log(1/(1/2));
%% Let's set up a structure
    S = struct;
    S(1).name = 'pp'; %naming convention: previous state - current state
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
    
%% Code below
    while k<=100 %This loop controls each discrete step
        
        if k == 1
            S(1).gamma = P + abs(y(1)-f(1)*1)^2;
            S(2).gamma = S(1).gamma;
            S(3).gamma = P + abs(y(1)-f(1)*(-1))^2;
            S(4).gamma = S(3).gamma;
            k =k+1;
            continue
            
        elseif k ==2 
            for j = 1:4
                S(j).gamma = S(j).gamma + P + abs(y(2)-f(1)*S(j).A(2)-f(2)*S(j).A(1))^2;
            	
            end
            k = k+1;
            continue
        else
            for j = 1:4
                S(j).p = [S(j).V 1];
                S(j).n = [S(j).V -1];
                S(j).gamman = S(j).gamma + P + abs(y(k)-f(1)*S(j).n(end)-f(2)*S(j).n(end-1))^2;
                S(j).gammap = S(j).gamma + P + abs(y(k)-f(1)*S(j).p(end)-f(2)*S(j).p(end-1))^2;
                S(j).pfinalstate = [S(j).p(end-1) S(j).p(end)];
                S(j).nfinalstate = [S(j).n(end-1) S(j).n(end)];
            end
            for j = 1:4
                state = S(j).A;
                q = 1;
                T = struct;
                for i = 1:4
                    if S(i).pfinalstate == state
                        disp('t1')
                        T(q).g = S(i).gammap;
                        T(q).s = S(i).p;
                        q = q+1;
                    elseif S(i).nfinalstate == state
                        disp('t2')
                        T(q).g = S(i).gamman;
                        T(q).s = S(i).n;
                        q = q+1;
                    else 
                        continue
                    end
                end
                if T(1).g<T(2).g
                    S(j).V = T(1).s;
                    S(j).gamma = T(1).g;
                else
                    S(j).V = T(2).s;
                    S(j).gamma = T(2).g;
                end
                
            end
            k = k+1;
        end
    end
[m,i] = min([S.gamma])
V = S(i).V
L = X(1:100)-V