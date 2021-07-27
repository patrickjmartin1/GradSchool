%% This function calculates only the raw probabilities of input states. i.e. states must be influenced by ISI before they go in here

function p = prob(state_r,state_t,snr) %b is the received signal, x is the signal we wish to compare to b 
 p = (1/(pi*snr))*exp((-1/snr)*abs(state_r - state_t(1)  - state_t(2))^2);
 