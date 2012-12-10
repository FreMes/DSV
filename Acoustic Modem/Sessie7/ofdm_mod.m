function [sentserial,packet] = ofdm_mod(input,N,Lt,Ld,L_CP,trainblock,goodFreqs)
    NbOfTones = length(goodFreqs);
    packet = zeros(N,Lt+Ld); 
    if(Lt ~= 0)
        packet(2:N/2,1:Lt) = repmat(trainblock,1,Lt);
        packet(N/2+2:N,1:Lt) = conj(flipud(packet(2:N/2,1:Lt)));
    end
    for i = 1:Ld   
        i*NbOfTones
        packet(goodFreqs,Lt+i) = input(1+(NbOfTones*(i-1)):i*NbOfTones,1);
        packet(N/2+2:N,Lt+i) = conj(flipud(packet(2:N/2,Lt+i)));
    end
    
    signal = ifft(packet); % IFFT
    
    signalpluscp = zeros(N + L_CP,Ld+Lt); 
    signalpluscp(1:L_CP,:) =  signal(end-L_CP+1:end,:);
    signalpluscp(L_CP+1:N+L_CP,:) =  signal;
    sentserial = reshape(signalpluscp,(N+L_CP)*(Ld+Lt),1);
end