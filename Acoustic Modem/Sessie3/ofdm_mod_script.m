% function y = ofdm_mod(N,M,Nl,L)
N = 10; M = 16; Nl = 3; L = 2;
if( mod(N,2) ~= 0 )
    error('N must be even');
end
    packet = zeros(N,Nl);
    packet_sent_bits = zeros((N/2-1)*log2(M),Nl);
    
    for i = 1:Nl                                            % QAM modulation
        randseq = randint((N/2-1)*log2(M),1,[1,0]);
        packet_sent_bits(:,i) = randseq;
        qam = qam_mod(randseq,M);

        packet(2:N/2,i) = qam;
        packet(N/2+2:N,i) = conj(flipud(qam));
    end
    
    signal = ifft(packet); % IFFT
   
    sentserial = zeros((N+L)*Nl,1); 
    i=1;
    while i <= Nl                          %parallel-serial + CP toevoegen
        sentserial(i*(N+L)-(N+L)+1:i*(N+L)-(N+L)+L) = signal(end-L+1:end,i);
        sentserial(i*(N+L)-(N+L)+1+L:i*(N+L))=signal(:,i);
        i = i + 1;
    end
    
     sentserial_withnoise = awgn(sentserial,5,'measured');    %adding noise (part 5)
    
    receivedparallel = zeros(N,Nl);
    i=1;
    while i <= Nl                           %serial-parallel + CP verwijderen
        receivedparallel(:,i) = sentserial_withnoise(i*(N+L)-(N+L)+1+L:i*(N+L));
        i = i + 1;
    end
    
    packet_received = fft(receivedparallel); %FFT
    
    packet_received_bits = zeros((N/2-1)*log2(M),Nl);
    ber_ofdm = zeros(1,Nl);
    for i = 1:Nl                                            % QAM demodulation
        frame = qam_demod(packet_received(2:N/2,i),M);
        packet_received_bits(:,i) = frame;
        ber_ofdm(i) = ber(packet_sent_bits(:,i),frame);
    end
    totalber = sum(ber_ofdm)
    
% end