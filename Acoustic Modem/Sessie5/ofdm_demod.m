function [rxQamStream, estH] = ofdm_demod(Rx,N,L_CP,P,Tx,trainblock)  
%           serial-parallel:
    receivedparallel = reshape(Rx,N + L_CP,P);
    receivedparallelnocp = receivedparallel(L_CP+1:N+L_CP,:);


    packet_received = fft(receivedparallelnocp); %FFT

    packetsserial = reshape(packet_received,N*P,1);
    
    diagonaltrain = diag([0;trainblock;0;conj(flipud(trainblock))]);
    X = zeros(100*N,N);
    for i = 1:100
        X(i*N-N+1:i*N,1:N) = diagonaltrain;
    end
    estH = X\packetsserial; 

%   Channel Estimation in time domain:
%    x = toeplitz(Tx,zeros(100,1));  
%    esth = x\Rx;
%    estH = fft(esth,N);
    
    packet_scaled = zeros(N,P);
    i=1;
    while i<= P
        packet_scaled(:,i) = packet_received(:,i)./estH;
        i=i+1;
    end
    received = packet_scaled(2:N/2,:);
    rxQamStream = reshape(received,(N/2-1)*P,1);
    
end