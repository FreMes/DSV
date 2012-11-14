function sentserial = ofdm_mod(qamsignal,L_CP)
    [n,Nl] = size(qamsignal);
    N = (n + 1) *2;
        
    packet = zeros(N,Nl);
    for i = 1:Nl                                            % packet construction
        packet(2:N/2,i) = qamsignal(:,i);
        packet(N/2+2:N,i) = conj(flipud(qamsignal(:,i)));
    end

    signal = ifft(packet); % IFFT
   
    sentserial = zeros((N+L_CP)*Nl,1); 
    i=1;
    while i <= Nl                          %parallel-serial + CP toevoegen
        sentserial(i*(N+L_CP)-(N+L_CP)+1:i*(N+L_CP)-(N+L_CP)+L_CP) = signal(end-L_CP+1:end,i);
        sentserial(i*(N+L_CP)-(N+L_CP)+1+L_CP:i*(N+L_CP))=signal(:,i);
        i = i + 1;
    end
    
end