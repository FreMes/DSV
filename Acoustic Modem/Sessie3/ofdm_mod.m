function sentserial = ofdm_mod(input,N,Nl,L)
    signal = ifft(input); % IFFT
   
    sentserial = zeros((N+L)*Nl,1); 
    i=1;
    while i <= Nl                          %parallel-serial + CP toevoegen
        sentserial(i*(N+L)-(N+L)+1:i*(N+L)-(N+L)+L) = signal(end-L+1:end,i);
        sentserial(i*(N+L)-(N+L)+1+L:i*(N+L))=signal(:,i);
        i = i + 1;
    end
    
end