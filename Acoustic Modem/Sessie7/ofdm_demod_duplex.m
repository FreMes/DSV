function [rxQamStream,W] = ofdm_demod_duplex(Rx,N,M,L_CP,Lt,Ld,trainblock,goodFreqs)  
%           serial-parallel:
    receivedparallel = reshape(Rx,N + L_CP,Lt+Ld);
    receivedparallelnocp = receivedparallel(L_CP+1:N+L_CP,:);


    packet_received = fft(receivedparallelnocp,N); %FFT
    
    % First channel est:
    packett = packet_received(:,1:Lt);      
    estH = mean(packett,2)./[1;trainblock;1;conj(flipud(trainblock))]; 
    W2(:,1) = 1./conj(estH); 
    W1(:,1) = 1./conj(estH);

%     figure()
%     plot(20*log(abs(estH)));
%     figure()
%     plot(20*log(abs(1./W(:,1))));

     Y = packet_received(:,Lt+1:end);
     Tx1_freq = fft(Tx1,N);
    
     %ECHO CANCELLATION:
    mu = 0.6;
    a=10^-4;
    
    Tx1_filt = zeros(N,Ld);
    Tx1_filt(:,1) = conj(W1(:,1)).*Tx1_freq(:,1);
    Y2 = zeros(N,Ld);
    Y2(:,1) = Y(:,1) - Tx1_filt(:,1);
    for j=2:Ld
        Tx1_filt(:,j) = conj(W1(:,j-1)).*Tx1_freq(:,j);
        diff = Y(:,j) - Tx1_filt(:,j);
        W1(:,j) = W1(:,j-1) + mu/(a+(Y(:,j))'*Y(:,j)) * Y(:,j) .* conj(diff);
        Y2(:,j) = diff;
    end
    
    % NLMS:
    mu = 0.6;
    a=10^-4;
    
    X_filt = zeros(N,Ld);
    X_filt(:,1) = conj(W2(:,1)).*Y2(:,1);
    X_est = zeros(N,Ld);
    for j=2:Ld
        X_filt(:,j) = conj(W2(:,j-1)).*Y2(:,j);
        X_est(:,j) = qammod(qamdemod(X_filt(:,j),M),M)

        W2(:,j) = W2(:,j-1) + mu/(a+(Y2(:,j))'*Y2(:,j)) * Y2(:,j) .* conj(X_est(:,j) - X_filt(:,j));

    end

    packet_scaled = X_filt;
    
    received = packet_scaled(goodFreqs,:);
    rxQamStream = reshape(received,length(goodFreqs)*Ld,1);
    
end