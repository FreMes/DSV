
BER_SNR = zeros(10,5)
for k = 2:6
    M = 2^k;
    i=1;
        for i=1:10
            SNR = i;
            BER_SNR(i,k-1) = qam_experiment(M,SNR);
        end

end
figure('Name','BER for different SNR');
plot(1:1:10,BER_SNR(:,1),1:1:10,BER_SNR(:,2),1:1:10,BER_SNR(:,3),1:1:10,BER_SNR(:,4),1:1:10,BER_SNR(:,5));
legend('QAM 4','QAM 8','QAM 16','QAM 32','QAM 64');
xlabel('SNR');
ylabel('BER');