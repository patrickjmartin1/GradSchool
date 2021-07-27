%% Input states must have already been influenced by ISI before they're put in here
function g = Gamma(state_r, state_t,snr) %state_r is the received state, state_t is the state we are testing against
    g = (1/2)*prob2(state_r, state_t,snr);
    