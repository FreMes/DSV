function y = ofdm_mod(N,Nl)

    frame = zeros(N,1);
    frame(1,1) = 0;
    frame(N/2+1,1) = 0;
    
    randseq = randint(N/2-1,1,[1,0]);
    qam = qam_mod(randseq,16);
    
    frame(2:N/2) = qam;
    frame(N/2+2:N) = fliplr(qam);
end