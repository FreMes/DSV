function sentserial = ofdm_modt(input,N,P,L_CP)
    packet = zeros(N,P);
    for i = 1:P   
        packet(2:N/2,i) = input;
        packet(N/2+2:N,i) = conj(flipud(input));
    end
    signal = ifft(packet); % IFFT  
    
    signalpluscp = zeros(N + L_CP,P); 

    signalpluscp(1:L_CP,:) =  signal(end-L_CP+1:end,:);
    signalpluscp(L_CP+1:N+L_CP,:) =  signal;
    sentserial = reshape(signalpluscp,(N+L_CP)*P,1);
%     sentserial(310:320,1)
end