Fs = 16000;

length = 3001;

%u = randn(2*Fs, 1);
u = rand(2*Fs, 1)-0.5;

x = toeplitz(u(1:20000),zeros(100,1));
    
[simin,nbsecs,fs] = initparams(u(1:10000),Fs);

sim('recplay');
out=simout.signals.values;    
y = out(30001:50000);
h = x\y;
figure(1)
subplot(2,1,1);
plot(simin(26000:56000,2),'DisplayName','simin','YDataSource','simin');
subplot(2,1,2);
plot(h,'DisplayName','h','YDataSource','h');
