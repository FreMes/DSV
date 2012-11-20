function sentserial = ofdm_mod(qamsignal,N,L_CP,goodFreqs)
    nbGoodFreqs = length(goodFreqs);
    P=floor(size(qamsignal,1)/nbGoodFreqs);
    
    packet = zeros(N,P);
    for i = 1:P                                            % 
        packet(goodFreqs,i) = qamsignal(1+(nbGoodFreqs*(i-1)):i*nbGoodFreqs,1);
        packet(N/2+2:N,i) = conj(flipud(packet(2:N/2,i)));
    end

    signal = ifft(packet); % IFFT

    
    signalpluscp = zeros(N + L_CP,P); 
    size(signalpluscp);

    signalpluscp(1:L_CP,:) =  signal(end-L_CP+1:end,:);
    signalpluscp(L_CP+1:N+L_CP,:) =  signal;
    sentserial = reshape(signalpluscp,(N+L_CP)*P,1);

end