function sentserial = ofdm_mod(qamsignal,N,L_CP,P)
    
    packet = zeros(N,P);
    for i = 1:P                                            % packet construction
        qamsignal(i*N/2-N/2+1:i*(N/2-1),1);
        packet(2:N/2,i) = qamsignal(1+((N/2-1)*(i-1)):i*(N/2-1),1);
        packet(N/2+2:N,i) = conj(flipud(qamsignal(1+((N/2-1)*(i-1)):i*(N/2-1),1)));
    end

    signal = ifft(packet); % IFFT
   
    sentserial = zeros((N+L_CP)*P,1); 
    i=1;
    while i <= P                          %parallel-serial + CP toevoegen
        sentserial(i*(N+L_CP)-(N+L_CP)+1:i*(N+L_CP)-(N+L_CP)+L_CP) = signal(end-L_CP+1:end,i);
        sentserial(i*(N+L_CP)-(N+L_CP)+1+L_CP:i*(N+L_CP))=signal(:,i);
        i = i + 1;
    end
    
end