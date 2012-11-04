Fs = 16000;
freq = 400;
DFTsize = 512;

t = zeros(2*Fs,1);
for i=1:2*Fs
   t(i,1)= (1/Fs)*i;
end

 sig = randn(2*Fs, 1); %Gaussisch verdeelde ruis
% sig = rand(2*Fs, 1)-0.5; %normaal verdeelde ruis

[simin,nbsecs,fs] = initparams(sig,Fs);

sim('recplay');
out=simout.signals.values;

sound(out);

scrsz = get(0,'ScreenSize');
figure('Name','White Noise - Spectrogram','OuterPosition',[1 scrsz(4)/2 scrsz(3)/2  scrsz(4)/2]);

subplot(2,1,1);
[S1,F1,T1,P1] = spectrogram(simin(:,2),DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
imagesc(T1,F1,20*log(abs(S1)));
set(gca,'YDir','normal');
xlabel('Time (seconds)');
ylabel('Frequency');


subplot(2,1,2);
[S2,F2,T2,P2] = spectrogram(out,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
imagesc(T2,F2,20*log(abs(S2)));
set(gca,'YDir','normal');
xlabel('Time (seconds)');
ylabel('Frequency');

figure('Name','White Noise - PSD','OuterPosition',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2  scrsz(4)/2])
subplot(2,1,1);
semilogy(F1,mean(P1,2)); 
xlabel('Frequency');
ylabel('PSD');
subplot(2,1,2);
semilogy(F2,mean(P2,2));
xlabel('Frequency');
ylabel('PSD');


%-----------------------------------------------------------------------------------%
%   IR2:
x = toeplitz(sig,zeros(100,1));

overthreshold = find(out>0.1,1000)  %good threshold value despends on the amount of noise in the room
ind = find(overthreshold>32000,1)
index = overthreshold(ind,1)
y = out(index-20:index+31979);
h = x\y;

figure('Name','IR2 - Time&Freq Response','OuterPosition',[1 1 scrsz(3)/2  scrsz(4)/2])
 %vraag 2
subplot(2,1,1);
plot(h,'DisplayName','h','YDataSource','h');
xlabel('Time (samples)');
ylabel('IR response');
subplot(2,1,2);
plot(20*log(abs(fft(h))));
xlabel('Frequency (relative to 100*Fs)');
ylabel('Frequency response');

save('IRest.mat', 'h');

%-----------------------------------------------------------------------------------%
%   IR1:

length = 16001 %One second, other numbers give the same result
halflength = floor(Fs/2);
d = zeros(length,1);
d(halflength+1,1) = 1;
    
[simin,nbsecs,fs] = initparams(d,Fs);

sim('recplay');
out=simout.signals.values;    

figure('Name','IR1 - Time&Freq Response','OuterPosition',[scrsz(3)/2 1 scrsz(3)/2  scrsz(4)/2])

subplot(2,1,1);
index = find(out==(max(max(out))))

out(index-20:index+80)
plot(out(index-20:index+80),'DisplayName','h','YDataSource','h');
xlabel('Time (samples)');
ylabel('IR response');
subplot(2,1,2);
range = out(index-20:index+80);
plot(20*log(abs(fft(range))));
xlabel('Frequency (relative to 100*Fs)');
ylabel('Frequency response');

