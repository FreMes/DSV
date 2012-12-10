    Fs = 16000;

    N = 512;
    M = 16;
    Nq = log2(M);
    L_CP = 120;
    SNR = 100;
    
    
    l=1000
%---QAM SYMBOL SEQ---%

    bitStream = randint(l*Nq,1,[1,0]); 

    Xk = qam_mod(bitStream, M);
%---Yk---%

    Hk_1 = 0.5 + 0.05*i;
%     freq = 1;
%     t = zeros(l,1);
%     for j=1:l
%        t(j,1)= (1/l)*j;
%     end
%     sig = sin(2*pi*freq*t);
%     Hk = repmat(Hk_1,l,1) + 0.01*sig;
    Hk = repmat(Hk_1,l,1);
    Nk = 0.001+0.0005i;
    Yk = Hk.*Xk;
    
%---Yk---%
    
    W = zeros(1000,1);
    W(1) = 1/conj(Hk(1))+0.01;
%     W(1) = conj(1/Hk(1));
    mu = 0.01;
    a=10^-4;
    
    Xk_filt = zeros(l,1);
    Xk_est = zeros(l,1);
    for j=2:1000
        Xk_filt(j) = conj(W(j-1))*Yk(j);
        Xk_est(j) = qammod(qamdemod(Xk_filt(j),M),M);
        W(j) = W(j-1) + mu/(a+conj(Yk(j))*Yk(j)) * Yk(j) * conj(Xk_est(j) - conj(W(j-1))*Yk(j));
    end
    
    figure()
    plot(20*log(abs(W)));
    figure()
    plot(abs(W-ones(l,1)./conj(Hk)));
   
    
%     
%     P=1000;
%     goodFreqs = 100;
%     Tx = ofdm_mod(trainblock,N,P,L_CP,goodFreqs);
% 
% %---Play signal---%
% 
%     %PLAY
%     tSync = 1000;
%     [simin,nbsecs,fs] = initparams(Tx,Fs,tSync);
%     %OUTPUT
%     sim('recplay');
%     out=simout.signals.values;
%     out_aligned = alignIO(out,0.05,tSync);
%     Rx = out_aligned(1:(N+L_CP)*(P+(P/Ld)*Lt));
%     
%     wxOfdmStream = awgn(Rx,SNR,'measured');
% %---OFDM demod---%
%     [rxQamStream,channel_est] = ofdm_demod(Rx, N,L_CP,P,trainblock);
%     