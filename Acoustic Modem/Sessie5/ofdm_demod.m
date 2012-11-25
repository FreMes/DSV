function [rxQamStream, estH] = ofdm_demod(Rx,N,h,P,Tx)  
%           serial-parallel:
    receivedparallel = reshape(Rx,N,P);
    packet_received = fft(receivedparallel); %FFT

%     %Channel Estimation
%     for i = 0 : N/2-1
%        %kkw 
%     end    
%     estH = H;
    x = toeplitz(Tx,zeros(length(h),1));  %Tx volgt uit trainblock dus het is "based on trainblock"
    esth = x\Rx;
    estH = fft(esth,N);
    
    packet_received(1:N,1)
    packet_scaled = zeros(N,P);
    i=1;
    while i<= P
        packet_scaled(:,i) = packet_received(1:N,i)./estH;
        i=i+1;
    end
    size(packet_scaled)
    received = packet_scaled(2:N/2,:);
    rxQamStream = reshape(received,(N/2-1)*P,1);
    
end