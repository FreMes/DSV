function sentserial = ofdm_mod_pilots(qamStream,trainblock,N,L_CP,P)
    packet = zeros(N,P);
    
    for i = 1:P  
        packet(2:2:N/2,i) = trainblock;
        packet(3:2:N/2-1,i) = qamStream(1+floor((N/2-1)/2)*(i-1):i*floor((N/2-1)/2),1);
        packet(N/2+2:N,i) = conj(flipud(packet(2:N/2,i)));
    end

        
    signal = ifft(packet,N); % IFFT  

    signalpluscp = zeros(N + L_CP,P); 

    signalpluscp(1:L_CP,:) =  signal(end-L_CP+1:end,:);
    signalpluscp(L_CP+1:N+L_CP,:) =  signal;
    sentserial = reshape(signalpluscp,(N+L_CP)*P,1);
end