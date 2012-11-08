Fs = 16000;
B = Fs/2;
DFTsize = 512;
N = DFTsize/2;

t = zeros(2*Fs,1);
for i=1:2*Fs
   t(i,1)= (1/Fs)*i;
end


sig = zeros(2*Fs,1);
[simin,nbsecs,fs] = initparams2(sig,Fs);
sim('recplay');
out1=simout.signals.values;
[Sr,Fr,Tr,Pr] = spectrogram(out1(16000:end),DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
spectrogram(out1,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis')
Pn = zeros(1:N,1);
for i=1:N
    Pn(i,1) = mean(Pr(i,:));
end

sig = randn(2*Fs, 1); % ruis want willen alle freqs testen
[simin,nbsecs,fs] = initparams2(sig,Fs);
sim('recplay');
out2=simout.signals.values;
[S0,F0,T0,P0] = spectrogram(out2(16000:end),DFTsize,DFTsize/2,DFTsize,Fs,'yaxis');
spectrogram(out2,DFTsize,DFTsize/2,DFTsize,Fs,'yaxis')

Ps0 = zeros(1:N,1);
for i=1:N
    Ps0(i,1) = mean(P0(i,:));
end
Ps = Ps0-Pn;
for i=1:size(Ps) %negatieve waarden op 0 zetten
    if(Ps(i,1) < 0)
        Ps(i,1) = 0;
    end
end
        

Cv = log2(1+(Ps./Pn));
C = Fs/(2*N) * sum(Cv);

