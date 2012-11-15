function received_qam = ofdm_demod(input,N,P,L_CP,H)
    
    receivedparallel = zeros(N,P);
    i=1;
    while i <= P                           %serial-parallel + CP verwijderen
        receivedparallel(:,i) = input(i*(N+L_CP)-(N+L_CP)+1+L_CP:i*(N+L_CP));
        i = i + 1;
    end
    
    packet_received = fft(receivedparallel); %FFT
    
    receivedqams = zeros(N/2,P);
    i=1;
    
    while i<= P
        receivedqams(:,i) = packet_received(1:N/2,i)./H;
        i=i+1;
    end

    received_qam = zeros((N/2-1) * P,1);
    for i = 1:P                                            % QAM demodulation
        received_qam(1+((N/2-1)*(i-1)):i*(N/2-1),1) = receivedqams(2:N/2,i);
    end

end