function [rxQamStream,W] = ofdm_demod(Rx,N,L_CP,Lt,Ld,trainblock,goodFreqs)  
%           serial-parallel:
    receivedparallel = reshape(Rx,N + L_CP,Lt+Ld);
    receivedparallelnocp = receivedparallel(L_CP+1:N+L_CP,:);


    packet_received = fft(receivedparallelnocp); %FFT
    
  
    packett = packet_received(:,1:Lt);      
    W(1) = mean(packett,2)./[1;trainblock;1;conj(flipud(trainblock))]; 
    
    %NLMS
    
    packet_scaled = zeros(N,Ld);

    packet_scaled = packet_received(:,Lt+1:end)./W;
    
    received = packet_scaled(goodFreqs,:);
    rxQamStream = reshape(received,(N/2-1)*Ld,1);
    
end