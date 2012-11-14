BER_SNR = zeros(10,1);
i=1;
for i=1:10
    BER_SNR(i) = ofdm_experiment(10000,16,5,5,i*2);
end

figure(1);
plot(1:2:20,BER_SNR)
xlabel('SNR');
ylabel('BER');



BER_QAM = zeros(5,1);
i=1;
for i=1:5
    BER_QAM(i) = ofdm_experiment(10000,2*2^i,5,5,8);
end

figure(2);
stem([4 8 16 32 64]',BER_QAM)
xlabel('QAM-..');
ylabel('BER');