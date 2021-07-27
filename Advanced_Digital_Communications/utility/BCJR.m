function J = BCJR(Y,f,snr) %f is the ISI channel representation
Y = [0 Y 0];
M = length(Y);
U = struct;
% Apply states names to U 
U(1).state = [1 1]; % Naming convention: previous state -> current state
U(2).state = [1 -1];
U(3).state = [-1 1];
U(4).state = [-1 -1];
for i = 1:4
    U(i).a = zeros(1,M);
    U(i).a(1) = 1 ;
    U(i).b = zeros(1,M);
    U(i).b(end) = 1;
    U(i).g = zeros(1,M);
    U(i).lambda = zeros(1,M);
    U(i).sigma = zeros(1,M);
end
for i = 2:M
    for j = 1:4 
        if i == 2
            state_r = Y(i) ;
            state_t = [ 0, U(j).state(1)]; 
            U(j).g(i) = Gamma(state_r, state_t,snr);
            U(j).a(i) = U(j).g(i)*U(j).a(i-1);
        else
            state_r = Y(i) ;
            state_t = [U(j).state(1)*f(2), U(j).state(2) ]; 
            U(j).g(i) = Gamma(state_r, state_t,snr);
            U(j).a(i) = U(j).g(i)*U(j).a(i-1);
        end
    end
end

for i = M-1:-1:2
    for j = 1:4 
        if i == M-1 
        state_r = Y(i);
        state_t = [U(j).state(1)*f(2), 0];
        U(j).b(i) = U(j).g(i+1)*U(j).b(i+1);    
        else
        state_r = Y(i);
        state_t = [U(j).state(1)*f(2), U(j).state(2)];
        U(j).b(i) = U(j).g(i+1)*U(j).b(i+1);
        end
    end
end

for i = 2:M
    for j = 1:4
        U(j).lambda(i) = U(j).a(i)*U(j).b(i);
    end
end
for i = 2:M
    for j = 1:4
        U(j).sigma(i) = U(j).a(i-1)*U(j).g(i)*U(j).b(i);
    end
end
J = U ;