function packet_received = ofdm_demod(input,N,Nl,L)

    receivedparallel = zeros(N,Nl);
    i=1;
    while i <= Nl                           %serial-parallel + CP verwijderen
        receivedparallel(:,i) = input(i*(N+L)-(N+L)+1+L:i*(N+L));
        i = i + 1;
    end
    
    packet_received = fft(receivedparallel); %FFT
    
end