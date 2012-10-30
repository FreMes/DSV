Fs = 16000;
B = Fs/2;
DFTsize = 512;
N = DFTsize/2;

t = zeros(Fs,1);
for i=1:Fs
   t(i,1)= (1/Fs)*i;
end


Noise = randn(Fs, 1);

sig = zeros(Fs,1);
[simin,nbsecs,fs] = initparams(sig,Fs);
sim('recplay');
out=simout.signals.values;
[Sr,Fr,Tr,Pr] = spectrogram(out,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
Pn = zeros(1:N,1);
for i=1:N
    Pn(i,1) = mean(Pr(i,:));
end

sig = ; % ruis want willen alle freqs testen
[simin,nbsecs,fs] = initparams(sig,Fs);
sim('recplay');
out=simout.signals.values;
[S0,F0,T0,P0] = spectrogram(out,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
spectrogram(out,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis')
Ps0 = zeros(1:N,1);
for i=1:N
    Ps0(i,1) = mean(P0(i,:));
end
Ps = Ps0-Pn;
for i=1:size(Ps) %negatieve waarden op 0 zetten
    




Cv = log2(1+(Ps./Pn));
C = Fs/(2*N) * sum(Cv);