function sentserial = ofdm_mod2(qamsignal,N,L_CP,P)
    
    packet = zeros(N,P);
    for i = 1:P                                            % 
        qamsignal(i*N/2-N/2+1:i*(N/2-1),1);
        packet(2:N/2,i) = qamsignal(1+((N/2-1)*(i-1)):i*(N/2-1),1);
        packet(N/2+2:N,i) = conj(flipud(qamsignal(1+((N/2-1)*(i-1)):i*(N/2-1),1)));
    end
    
    signal = ifft(packet); % IFFT

    
    signalpluscp = zeros(N + L_CP,P); 
%     i=1;
%     while i <= P                          %parallel-serial + CP toevoegen
%         sentserial(i*(N+L_CP)-(N+L_CP)+1:i*(N+L_CP)-(N+L_CP)+L_CP) = signal(end-L_CP+1:end,i);
%         sentserial(i*(N+L_CP)-(N+L_CP)+1+L_CP:i*(N+L_CP))=signal(:,i);
%         i = i + 1;
%     end
    signalpluscp(1:L_CP,:) =  signal(end-L_CP+1:end,:);
    signalpluscp(L_CP+1:N+L_CP,:) =  signal;
    sentserial = reshape(signalpluscp,(N+L_CP)*P,1);

end