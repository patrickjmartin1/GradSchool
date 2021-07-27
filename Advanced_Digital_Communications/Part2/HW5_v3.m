%% HW 5 Header 
clear all
close all
format long
format compact
clc
%% Blank Mean Matrices
SNR = [];
BLER_awgn_mean = [];
SER_awgn_mean = [];
BLER_Vit_mean = [];
SER_Vit_mean = [];
BLER_L_mean = [];
SER_L_mean = [];
SER_M_mean = [];
BLER_M_mean = [];
SER_BCJR_mean = [];
BLER_BCJR_mean = [];
SER_F_mean = [];
BLER_F_mean = [];
SER_DFE_ZF_mean = [];
BLER_DFE_ZF_mean = [];
SER_DFE_MMSE_mean = [];
BLER_DFE_MMSE_mean = [];
LZF_SNR_mean = [];
LMMSE_SNR_mean = [];
%% Constants
sample_snr_points = 50;
num_sims_at_each_snr = 200;
N = 100;
T = 1e-3;
% a = 1;
beta = 2/3*(1-1i);
g = [1, beta]; % This results in the value of the channel @ every instant in time having the value 1+\Beta. \Beta represents our ISI after applying a whitening filter
%% Main Code
    %% Range of SNR values
for a = logspace(-2,3,sample_snr_points) %Range of SNR Values
    N0 = 1/a;
    disp(N0);
    %% Matrices for Statistics
    BLERawgnTOT = [];
    SERawgnTOT = [];
    BLERVitTOT = [];
    SERVitTOT = [];
    BLER_L_TOT = [];
    SER_L_TOT = [];
    BLER_M_TOT = [];
    SER_M_TOT = [];
    BLER_BCJR_TOT = [];
    SER_BCJR_TOT = [];
    BLER_F_TOT = [];
    SER_F_TOT = [];
    BLER_DFE_ZF_TOT = [];
    SER_DFE_ZF_TOT = [];
    BLER_DFE_MMSE_TOT = [];
    SER_DFE_MMSE_TOT = [];
    LZF_SNR = [];
    LMMSE_SNR = [];
    %% Simulations @ Each SNR
    b = 0;
    while b < num_sims_at_each_snr; %Number of simulations at each SNR to run
        
        %% Apply Filters & Decoders
        inputbits = (rand(1,N) > 1/2); %A stream of random bits we wish to transmit (formerly 'infobits')
        X = (2*inputbits)-1; % converting bits to 2PAM modulation
        noise = sqrt(N0/2)*(randn(1,N+length(g)-1)+1i*randn(1,N+length(g)-1));
        Y = conv(X,g)+noise;
        Y_matched = matched2(Y,g);
        awgndec = MAP(Y);% Simple MAP decoder  
        V = vit5(Y,g);% Viterbi decoder
        B = BCJR4(Y,g);% BCJR decoder 
        LZSNR = LZFEq2(Y,g);
        L = MAP(LZSNR); %MAP of Linear Zero Forcing Equalizer
        M = MAP(Y_matched); % Map of matched filter  
        fmmsesnr = fmmse6(Y,a,g);
        F = MAP(fmmsesnr); % MAP of MMSE filter
        DFEZF = DFE_ZF(Y,g);
        DFEMMSE = DFE_MMSE(Y,a,g);
        %% Measure Filter & Decoder Performance
        BLERVit = (sum(V(1:N)~=X) >0);
        SERVit = sum(V(1:N)~=X)/N;
        
        BLERawgn = (sum(awgndec(1:N)~=X) >0);
        SERawgn = sum(awgndec(1:N)~=X)/N;
        
        BLER_L = (sum(L(1:N)~=X) >0);
        SER_L = sum(L(1:N)~=X)/N;
        
        BLER_M = (sum(M(1:N)~=X) >0);
        SER_M = sum(M(1:N)~=X)/N;
        
        BLER_BCJR = (sum(B(1:N)~=X) >0);
        SER_BCJR = sum(B(1:N)~=X)/N;
        
        BLER_F = (sum(F(1:N)~=X) >0);
        SER_F = sum(F(1:N)~=X)/N;
        
        BLER_DFE_ZF = (sum(DFEZF(1:N)~=X) >0);
        SER_DFE_ZF = sum(DFEZF(1:N)~=X)/N;
        
        BLER_DFE_MMSE = (sum(DFEMMSE(1:N)~=X) >0);
        SER_DFE_MMSE = sum(DFEMMSE(1:N)~=X)/N;
             
        BLERawgnTOT = [BLERawgnTOT BLERawgn];
        SERawgnTOT = [SERawgnTOT SERawgn];
        
        BLERVitTOT = [BLERVitTOT BLERVit];
        SERVitTOT = [SERVitTOT SERVit]; 
        
        BLER_L_TOT = [BLER_L_TOT BLER_L];
        SER_L_TOT = [SER_L_TOT SER_L];
        
        BLER_M_TOT = [BLER_M_TOT BLER_M];
        SER_M_TOT = [SER_M_TOT SER_M];
        
        BLER_BCJR_TOT = [BLER_BCJR_TOT BLER_BCJR];
        SER_BCJR_TOT = [SER_BCJR_TOT SER_BCJR];
        
        BLER_F_TOT = [BLER_F_TOT BLER_F];
        SER_F_TOT = [SER_F_TOT SER_F];
        
        BLER_DFE_ZF_TOT = [BLER_DFE_ZF_TOT BLER_DFE_ZF];
        SER_DFE_ZF_TOT = [SER_DFE_ZF_TOT SER_DFE_ZF];
        
        BLER_DFE_MMSE_TOT = [BLER_DFE_MMSE_TOT BLER_DFE_MMSE];
        SER_DFE_MMSE_TOT = [SER_DFE_MMSE_TOT SER_DFE_MMSE];
        %% SNR Calculations
        R = (abs((LZSNR(2:100))).^2)./abs(Y(2:100)-LZSNR(2:100)).^2;
        LZF_SNR = [LZF_SNR mean(R) ];
        LMMSE_SNR = [LMMSE_SNR mean((abs((fmmsesnr(2:100))).^2)./abs(Y(2:100)-fmmsesnr(2:100)).^2) ];
    %% 
        b = b+1; % End of Simulation Iteration
        
        
    end
%% Full SNR range Statistics
SNR = [SNR (1/N0)];
BLER_awgn_mean = [BLER_awgn_mean mean(BLERawgnTOT)];
SER_awgn_mean = [SER_awgn_mean mean(SERawgnTOT)];

BLER_Vit_mean = [BLER_Vit_mean mean(BLERVitTOT)];
SER_Vit_mean = [SER_Vit_mean mean(SERVitTOT)];

BLER_L_mean = [BLER_L_mean mean(BLER_L_TOT)];
SER_L_mean = [SER_L_mean mean(SER_L_TOT)];

BLER_M_mean = [BLER_M_mean mean(BLER_M_TOT)];
SER_M_mean = [SER_M_mean mean(SER_M_TOT)];

BLER_BCJR_mean = [BLER_BCJR_mean mean(BLER_BCJR_TOT)];
SER_BCJR_mean = [SER_BCJR_mean mean(SER_BCJR_TOT)];

BLER_F_mean = [BLER_F_mean mean(BLER_F_TOT)];
SER_F_mean = [SER_F_mean mean(SER_F_TOT)];

BLER_DFE_ZF_mean = [BLER_DFE_ZF_mean mean(BLER_DFE_ZF_TOT)];
SER_DFE_ZF_mean = [SER_DFE_ZF_mean mean(SER_DFE_ZF_TOT)];

BLER_DFE_MMSE_mean = [BLER_DFE_MMSE_mean mean(BLER_DFE_MMSE_TOT)];
SER_DFE_MMSE_mean = [SER_DFE_MMSE_mean mean(SER_DFE_MMSE_TOT)];

%% SNR Plotting Calculations
LZF_SNR_mean = [LZF_SNR_mean mean(LZF_SNR)];
LMMSE_SNR_mean = [LMMSE_SNR_mean mean(LMMSE_SNR)];

end
%% SNR calculations

% L_ZF_SNR = SNR.*(1-abs(g(2))^2);


%% Plotting
FIG1 = figure;
% subplot(1,3,1)
set(FIG1,'Units','normalized','Position',[.1 .1 .8 .7])
p = loglog(SNR, SER_awgn_mean,SNR, SER_Vit_mean,SNR, SER_BCJR_mean, SNR,SER_M_mean,SNR,SER_L_mean,SNR,SER_F_mean, SNR,SER_DFE_ZF_mean, SNR, SER_DFE_MMSE_mean);
xlabel('Signal-to-Noise Ratio')
ylabel('Symbol Error Rate')
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = '*';
p(4).Marker = '.';
p(5).Marker = 'x';
p(6).Marker = 's';
p(7).LineStyle = '--';
p(8).LineStyle = ':';
p(8).Color = 'k';
p(8).LineWidth = 2;
    
legend('Simple MAP','Viterbi','BCJR','Matched Filter + MAP','Linear-Zero-Forcing + MAP','L-MMSE + MAP','DFE-ZF','DFE -MMSE','Location','northeast')
title('Symbol Error Rate vs. SNR') 

FIG2 = figure;
% subplot(1,3,1)
set(FIG2,'Units','normalized','Position',[.1 .1 .8 .7])
p = loglog(SNR, BLER_awgn_mean,SNR, BLER_Vit_mean,SNR, BLER_BCJR_mean, SNR,BLER_M_mean,SNR,BLER_L_mean,SNR,BLER_F_mean, SNR,BLER_DFE_ZF_mean, SNR, BLER_DFE_MMSE_mean);
xlabel('Signal-to-Noise Ratio')
ylabel('Symbol Error Rate')
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = '*';
p(4).Marker = '.';
p(5).Marker = 'x';
p(6).Marker = 's';
p(7).LineStyle = '--';
p(8).LineStyle = ':';
p(8).Color = 'k';
p(8).LineWidth = 2;
    
legend('Simple MAP','Viterbi','BCJR','Matched Filter + MAP','Linear-Zero-Forcing + MAP','L-MMSE + MAP','DFE-ZF','DFE -MMSE','Location','northeast')
title('Block Error Rate vs. SNR') 

% subplot(1,3,3)
FIG3 = figure;
set(FIG3,'Units','normalized','Position',[.1 .1 .8 .7])
loglog(SNR,LZF_SNR_mean,SNR,LMMSE_SNR_mean)
legend('LZF SNR', 'LMMSE SNR')
xlabel('Nominal System SNR')
ylabel('Filter SNR')
title('Filter SNR vs. System SNR')
%legend('Matched Filter+MAP','Viterbi','L-ZF+MAP','L-MMSE+MAP','Location','southwest')
% %
% vitdec = ViterbiDecoder(rxsyms);
% BLERvit = ...
% SERvit = ...
% %
% bcjrdec = BCJRDecoder(rxsyms);
% BLERbcjr = ...
% SERbcjr = ...