%% This function calculates only the raw probabilities of input states. i.e. states must be influenced by ISI before they go in here
%Note at this point that we're only calculating the log probability to keep
%our numbers easier to handle
function p = prob2(state_r,state_t) %b is the received signal, x is the signal we wish to compare to b 
 p = exp(-abs(state_r - state_t(1) - state_t(2))^2);
 