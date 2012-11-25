function sentserial = ofdm_mod(input,N,P,L_CP)
    packet = zeros(N,P);
    for i = 1:P   
        packet(2:N/2,i) = input;
        packet(N/2+2:N,i) = conj(flipud(input));
    end
    length(packet)
    signal = ifft(packet); % IFFT
    length(signal)

    sentserial = zeros(N*P,1); 
    i=1;
    while i <= P                         %parallel-serial + CP toevoegen
        sentserial((i-1)*N+1:i*N,1)=signal(:,i);
        i = i + 1;
    end
    
end