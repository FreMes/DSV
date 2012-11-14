function totalber = ofdm_experiment(N, M, Nl, L, SNR)
if( mod(N,2) ~= 0 )
    error('N must be even');
end

    input_bits = randi([0 1], (N/2-1)*log2(M), Nl);
    
    packet = zeros(N,Nl);
    for i = 1:Nl                                            % QAM modulation
        qam = qam_mod(input_bits(:,i),M);

        packet(2:N/2,i) = qam;
        packet(N/2+2:N,i) = conj(flipud(qam));
    end

    sentserial = ofdm_mod(packet,N,Nl,L);   %OFDM mod

    sentserial_withnoise = awgn(sentserial,SNR,'measured');    %adding noise (part 5)
    
    packet_received = ofdm_demod(sentserial_withnoise,N,Nl,L);    %OFDM demod
    
    packet_received_bits = zeros((N/2-1)*log2(M),Nl);
    ber_ofdm = zeros(1,Nl);
    for i = 1:Nl                                            % QAM demodulation
        frame = qam_demod(packet_received(2:N/2,i),M);
        packet_received_bits(:,i) = frame;
        ber_ofdm(i) = ber(input_bits(:,i),frame);
    end
    packet_received_bits;
    totalber = sum(ber_ofdm) / Nl
    
end