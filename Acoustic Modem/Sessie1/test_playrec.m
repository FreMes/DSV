fs = 16000;

t = zeros(2*fs,1);
for i=1:2*fs
   t(i,1)= (1/fs)*i;
end

sinewave = sin(2*pi*440*t);

[simin,nbsecs,fs] = initparams(sinewave,fs);

sim('recplay');

out=simout.signals.values;

soundsc(out, fs); %scaleert de dynamische range (ipv sound)