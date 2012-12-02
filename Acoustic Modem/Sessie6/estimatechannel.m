Fs = 16000;

N = 512;
P = 100;
L_CP = 150;
bitStream = randint((N/2-1)*log2(M),1,[1,0]); 

trainblock = qam_mod(bitStream, M);

Tx = ofdm_modt(trainblock,N,P,L_CP);

%PLAY
tSync = 1000;
[simin,nbsecs,fs] = initparams(Tx,Fs,tSync);
%OUTPUT
sim('recplay');
out=simout.signals.values;
out_aligned = alignIO(out,0.05,tSync);
Rx = out_aligned(1:(N+L_CP)*P);


[rxQamStream,estH] = ofdm_demodt(Rx, N,L_CP, P, Tx,trainblock);

figure('Name','estimated h and estimated H');
subplot(2,1,1);
plot(real(ifft(estH,N)),'DisplayName','h','YDataSource','h');
xlim([0 100])
xlabel('Time (samples)');
ylabel('IR response');
subplot(2,1,2);
plot(20*log(abs(estH)));
ylim([-150 0]); xlim([0 256]);
xlabel('Relative Frequency');
ylabel('Frequency response');

rxBitStream = qam_demod(rxQamStream,M);
biterrors = ber(bitStream,rxBitStream(1:(N/2-1)*log2(M)))