function totalber = ofdm_experiment(N, M, P, L_CP, SNR)
if( mod(N,2) ~= 0 )
    error('N must be even');
end

    input_bits = randi([0 1], (N/2-1)*log2(M) * P,1);
    
    qam = qam_mod(input_bits,M)

    sentserial = ofdm_mod(qam,N,L_CP,P);   %OFDM modulation

    sentserial_withnoise = awgn(sentserial,SNR,'measured');    %adding noise (part 5)
    
    qam_received = ofdm_demod(sentserial_withnoise,N,P,L_CP)    %OFDM demodulation
    
    output_bits = qam_demod(qam_received,M);
        
    ber_ofdm = ber(input_bits,output_bits);
end