function qamber = qam_experiment(M,SNR) 
    length = 2*3*4*5*6*10;
    randseq = randint(length,1,[1,0]);

    qam = qam_mod(randseq,M);
    qamnoise = awgn(qam,SNR,'measured'); %ruis toevoegen

    qamdemod = qam_demod(qamnoise,M);

    qamber = ber(randseq,qamdemod);
    
end