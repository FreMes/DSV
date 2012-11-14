function received_qam = ofdm_demod(input,N,Nl,L_CP)
    
    receivedparallel = zeros(N,Nl);
    i=1;
    while i <= Nl                           %serial-parallel + CP verwijderen
        receivedparallel(:,i) = input(i*(N+L_CP)-(N+L_CP)+1+L_CP:i*(N+L_CP));
        i = i + 1;
    end
    
    packet_received = fft(receivedparallel); %FFT
    
    received_qam = zeros(N/2-1,Nl);
    for i = 1:Nl                                            % QAM demodulation
        received_qam(:,i) = packet_received(2:N/2,i);
    end
    
end