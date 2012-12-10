function [rxQamStream,W] = ofdm_demod(Rx,N,M,L_CP,Lt,Ld,trainblock,goodFreqs)  
%           serial-parallel:
    receivedparallel = reshape(Rx,N + L_CP,Lt+Ld);
    receivedparallelnocp = receivedparallel(L_CP+1:N+L_CP,:);


    packet_received = fft(receivedparallelnocp); %FFT
    
    % First channel est:
    packett = packet_received(:,1:Lt);      
    estH = mean(packett,2)./[1;trainblock;1;conj(flipud(trainblock))]; 
    W(:,1) = 1./conj(estH); 

%     figure()
%     plot(20*log(abs(estH)));
%     figure()
%     plot(20*log(abs(1./W(:,1))));

     Y = packet_received(:,Lt+1:end);

    % NLMS:
    mu = 0.01;
    a=10^-4;
    
    X_filt = zeros(N,Ld);
    X_est = zeros(N,Ld);
    for j=2:Ld
        X_filt(:,j) = conj(W(:,j-1)).*Y(:,j);
        X_est(:,j) = qammod(qamdemod(X_filt(:,j),M),M)

        W(:,j) = W(:,j-1) + mu/(a+(Y(:,j))'*Y(:,j)) * Y(:,j) .* conj(X_est(:,j) - X_filt(:,j));
%         W(:,j) = W(:,j-1) + mu/(a+(Y(:,j))'*Y(:,j)) * Y(:,j) .* conj(X_est(:,j) - (W(:,j-1))'*Y(:,j));
    end

    packet_scaled = packet_received(:,Lt+1:end).*conj(W);
    
    received = packet_scaled(goodFreqs,:);
    rxQamStream = reshape(received,length(goodFreqs)*Ld,1);
    
end