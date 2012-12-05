    Fs = 16000;

    N = 512;
    M = 16;
    Nq = log2(M);
    L_CP = 120;
    SNR = 100;
    
    Lt = 5;
    Ld = 50;
    
%---QAM SYMBOL SEQ---%

    bitStream = randint(1000*Nq,1,[1,0]); 

    Xk = qam_mod(bitStream, M);
    
%---Yk---%

    Hk = 0.5 + 0.05*i;
    Nk = 0.001+0.0005i;
    Yk = Hk*Xk+repmat(Nk,1000,1);
    
%---Yk---%
    
    W = zeros(1000,1);
    W(1) = 1/Hk + 0.1;
    mu = 0.01;
    a=1;
    for i=2:1000
        W(i) = W(i-1) + mu/(a+conj(Yk(i))*Yk(i)) * Yk(i) * conj(Xk(i) - conj(W(i-1))*Yk(i));
    end
    
    figure()
    plot(20*log(abs(W)));
    figure()
    plot(20*log(abs(W-repmat(Hk,1000,1))));
   
    
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