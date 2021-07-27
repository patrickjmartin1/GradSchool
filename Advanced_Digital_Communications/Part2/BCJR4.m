%% Version 4 - WORKS to a certain extent, it does not throw-out non-

function J = BCJR4(Y,f) %f is the ISI channel representation
%% Constants
Y = [0 Y(1:end) 0]; %Prepare the received signal for decoding
M = length(Y);
U = struct;
%% State Assignment
U(1).current_state = 1;
U(2).current_state = -1;
U(1).previous_state(1) = 1;
U(1).previous_state(2) = -1;
U(2).previous_state(1) = 1;
U(2).previous_state(2) = -1;
%% Boundary Conditions
for i = 1:2
    U(i).gamma = zeros(2,M);
    U(i).a = zeros(1,M);
    U(i).a(1) = 1 ;
    U(i).b = zeros(1,M);
    U(i).b(end-1:end) = 1;

end
%% Calculate gamma
for j = 1:2
    for k = 1:2
        for i = 2:M-1
            signal_received = Y(i);
            if i == 2
                state_transmitted = [0 U(j).current_state];
                U(j).gamma(k,i) = prob2(signal_received, state_transmitted);
            elseif i == M-1
                state_transmitted = [U(j).previous_state(k)*f(2) 0];
                U(j).gamma(k,i) = prob2(signal_received, state_transmitted);
            else
                state_transmitted = [U(j).previous_state(k)*f(2) U(j).current_state];           
                U(j).gamma(k,i) = prob2(signal_received, state_transmitted);
            end

        end
    end
end

%% Calculate alpha

for i = 2:M
    for j = 1:2
        for k = 1:2
            U(j).a(i) = U(j).a(i) + U(j).gamma(k,i)*U(k).a(i-1);
        end
    end
end

%% Calculate Beta
for i = M-1:-1:2
    for j = 1:2 
        for k = 1:2
            U(j).b(i) = U(j).b(i) + U(k).gamma(j,i+1)*U(k).b(i+1);
        end
    end
end

%% Calculate lambda and sigma
for i = 2:M
    for j = 1:2
        for k = 1:2
        sigmas(j,k,i) = U(j).a(i-1)*U(j).gamma(k,i)*U(k).b(i);
        lambdas(j,i) = U(j).a(i)*U(j).b(i);
        end
    end
end
%% Pull out correct sequence
sigmas = sigmas(:,:,2:101);
s = struct;
for i = 1:size(sigmas,3)
    N = sigmas(:,:,i);
    [M,I] = max(N(:));
    s(i).sum = M;
    if I == 1
        s(i).pre = 1;
        s(i).cur = 1;
    elseif I == 2
        s(i).pre = 1;
        s(i).cur = -1;
    elseif I == 3
        s(i).pre = -1;
        s(i).cur = 1;
    elseif I == 4
        s(i).pre = -1;
        s(i).cur = -1;
    end
end

J = [s.pre];