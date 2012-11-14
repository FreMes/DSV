function totalber = ofdm_experiment(N, M, Nl, L_CP, SNR)
if( mod(N,2) ~= 0 )
    error('N must be even');
end

    input_bits = randi([0 1], (N/2-1)*log2(M), Nl);
    
    qam = zeros(N/2-1,Nl);
    for i = 1:Nl                                            % QAM modulation
        qam(:,i) = qam_mod(input_bits(:,i),M);
    end

    sentserial = ofdm_mod(qam,L_CP);   %OFDM modulation

    sentserial_withnoise = awgn(sentserial,SNR,'measured');    %adding noise (part 5)
    
    qam_received = ofdm_demod(sentserial_withnoise,N,Nl,L_CP);    %OFDM demodulation
    
    output_bits = zeros((N/2-1)*log2(M),Nl);
    ber_ofdm = zeros(1,Nl);
    for i = 1:Nl                                            % QAM demodulation
        qam_received(:,i)
        output_bits(:,i) = qam_demod(qam_received(:,i),M);
        ber_ofdm(i) = ber(input_bits(:,i),output_bits(:,i));
    end

    totalber = sum(ber_ofdm) / Nl;
end