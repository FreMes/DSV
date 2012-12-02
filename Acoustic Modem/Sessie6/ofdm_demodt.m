function [rxQamStream, estH] = ofdm_demodt(Rx,N,L_CP,P,Tx,trainblock)  
%           serial-parallel:
    receivedparallel = reshape(Rx,N + L_CP,P);
    receivedparallelnocp = receivedparallel(L_CP+1:N+L_CP,:);


    packet_received = fft(receivedparallelnocp); %FFT


%     Y = mean(packet_received,2);
%     trainframe = [1;trainblock;1;conj(flipud(trainblock))];
%     estH = Y./trainframe;

    trainframe = [1;trainblock;1;conj(flipud(trainblock))];
    trainframes = repmat(trainframe,1,P);
    estHs = packet_received./trainframes;
    estH = mean(estHs,2);
    
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