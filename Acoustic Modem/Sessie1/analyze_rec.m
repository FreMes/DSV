
Fs = 16000;
freq = 400;
DFTsize = 512;

t = zeros(2*Fs,1);
for i=1:2*Fs
   t(i,1)= (1/Fs)*i;
end

% sig = sin(2*pi*freq*t)+0.1;
% sig = sin(2*pi*50*t) + sin(2*pi*100*t) + sin(2*pi*200*t) + sin(2*pi*500*t) + sin(2*pi*1000*t) + sin(2*pi*2000*t) + sin(2*pi*4000*t) + sin(2*pi*6000*t);
 sig = randn(2*Fs, 1); %Gaussisch verdeelde ruis
% sig = rand(2*Fs, 1)-0.5; %normaal verdeelde ruis
% sound(sig, Fs);

[simin,nbsecs,fs] = initparams(sig,Fs);

sim('recplay');
out=simout.signals.values;

sound(out);

figure(1);

subplot(2,1,1);
[S1,F1,T1,P1] = spectrogram(simin(:,2),DFTsize,DFTsize/2,DFTsize,Fs,'yaxis'); %vensterlengte, overlap, DFT size(gelijk aan vensterlengte)
imagesc(T1,F1,20*log(abs(S1)));

subplot(2,1,2);
[S2,F2,T2,P2] = spectrogram(out,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
imagesc(T2,F2,20*log(abs(S2)));

figure(2);
subplot(2,1,1);
semilogy(F1,mean(P1,2)); %gemiddelde genomen => 1 curve
subplot(2,1,2);
semilogy(F2,mean(P2,2));

