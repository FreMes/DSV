Fs = 16000;

%u = randn(2*Fs, 1);
u = rand(2*Fs, 1)-0.5;

x = toeplitz(u(1:10000),zeros(100,1));
    
[simin,nbsecs,fs] = initparams(u(1:10000),Fs);

sim('recplay');
out=simout.signals.values;    

blub = find(out>0.02,1000)
ind = find(blub>32000,1)
index = blub(ind,1)
y = out(index-20:index+9979);
h = x\y;

figure() %vraag 2
subplot(2,1,1);
plot(h,'DisplayName','h','YDataSource','h');

subplot(2,1,2);

plot(20*log(abs(fft(h))));

save('IRest.mat', 'h');


% figure(3) %vraag 4
% subplot(2,1,1);
% plot(20*log(abs(fft(h))));
% subplot(2,1,2);
% DFTsize = 200;
% % spectrogram(y,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis')
%  [S2,F2,T2,P2] = spectrogram(y,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
%  semilogy(F2,20*log(mean(P2,2)));




% figure(1)
% subplot(2,2,1);
% plot(x*h,'DisplayName','simin','YDataSource','simin');
% subplot(2,2,2);
% plot(h,'DisplayName','h','YDataSource','h');
% subplot(2,2,3);
% plot(y,'DisplayName','y','YDataSource','y');
