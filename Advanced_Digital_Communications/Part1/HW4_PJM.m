clear all
close all
clc
%% Constants
SNR = [];
BLER_mean = [];
SER_mean = [];
BLERV_mean = [];
SERV_mean = [];
N = 100;
for a = logspace(-2,3,125) %pick out SNR values
    N0 = 1/a;
    disp(1/N0)
    BLER = [];
    SER = [];
    BLERVit = [];
    SERVit = [];
    b = 0;
    while b < 250 %Number of simulations at each SNR to run

        beta = 2/3*(1-1i); %Part of the baseband impulse response (See HW desc.)
    %     N0 = 0.04;  % constant to select SNR 


        inputbits = (rand(1,N) > 1/2); %A stream of random bits we wish to transmit (formerly 'infobits')

        X = (2*inputbits)-1; % converting bits to 2PAM modulation
        f = [1, beta]; % This results in the value of the channel @ every instant in time having the value 1+\Beta. It appears that \Beta represents our ISI
        noise = sqrt(N0/2)*(randn(1,N+length(f)-1)+1i*randn(1,N+length(f)-1));
        Z = conv(X,f)+noise;
        %
        awgndec = sign(real(conj(f(1))*Z));% matched filter + 2PAM `slicer' - This is the Decoder0 
        V = vit3((conj(f(1))*Z),f);
        BLERV = (sum(V(1:N)~=X) >0);
        SERV = sum(V(1:N)~=X)/N;
        BLERawgn = (sum(awgndec(1:N)~=X) >0);
        SERawgn = sum(awgndec(1:N)~=X)/N;
        BLER = [BLER BLERawgn];
        SER = [SER SERawgn];
        BLERVit = [BLERVit BLERV];
        SERVit = [SERVit SERV]; 
        b = b+1;
    end
   SNR = [SNR (1/N0)];
   BLER_mean = [BLER_mean mean(BLER)];
   SER_mean = [SER_mean mean(SER)];
   BLERV_mean = [BLERV_mean mean(BLERVit)];
   SERV_mean = [SERV_mean mean(SERVit)];
   clear BLER SER VLERVit SERVit
end
figure
subplot(1,2,1)
loglog(SNR, SER_mean, SNR, SERV_mean);
xlabel('Signal-to-Noise Ratio')
ylabel('Symbol Error Rate')
legend('Matched Filter + 2PAM Slicer','Matched Filter + Viterbi Algorithm','Location','southwest')
title('Symbol Error Rate vs. SNR') 
subplot(1,2,2)
loglog(SNR, BLER_mean, SNR, BLERV_mean)
xlabel('Signal-to-Noise Ratio')
ylabel('Block Error Rate')
legend('Matched Filter + 2PAM Slicer','Matched Filter + Viterbi Algorithm','Location','southwest')
title('Block Error Rate vs. SNR')
% %
% vitdec = ViterbiDecoder(rxsyms);
% BLERvit = ...
% SERvit = ...
% %
% bcjrdec = BCJRDecoder(rxsyms);
% BLERbcjr = ...
% SERbcjr = ...