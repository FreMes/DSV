function received_qam = ofdm_demod(input,N,L_CP,H,P,goodFreqs)   

%           serial-parallel + CP verwijderen
    receivedparallel = reshape(input,N + L_CP,P);
    receivedparallelnocp = receivedparallel(L_CP+1:N+L_CP,:);

    packet_received = fft(receivedparallelnocp); %FFT
    
    packet_scaled = zeros(N,P);
    i=1;

    while i<= P
        packet_scaled(:,i) = packet_received(1:N,i)./H;
        i=i+1;
    end
    
    received = packet_scaled(goodFreqs,:);
    received_qam = reshape(received,length(goodFreqs)*P,1);
end