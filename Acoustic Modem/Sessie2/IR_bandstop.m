Fs = 16000;

%u = randn(2*Fs, 1);
u = rand(2*Fs, 1)-0.5;

% figure()
% plot(20*log(abs(fft(u)))); %is niet de psd, psd is van een verwachte waarde en dus een tijdsgemiddelde (zie sessie 1)

Wn = [700/8000 3000/8000];
stopfilter = fir1(100,Wn,'stop');
% figure()
% plot(20*log(abs(fft(stopfilter))))

u_ = conv(u,stopfilter);
 figure(1)
 plot(20*log(abs(fft(u_))))

x = toeplitz(u_(1:10000),zeros(100,1));
    
[simin,nbsecs,fs] = initparams(u_(1:10000),Fs);


sim('recplay');
out=simout.signals.values;    

blub = find(out>0.035,1000)
ind = find(blub>32000,1)
index = blub(ind,1)
y = out(index-20:index+9979);
h = x\y;

figure()
subplot(2,1,1);
plot(h,'DisplayName','h','YDataSource','h');

subplot(2,1,2);

plot(20*log(abs(fft(h))));