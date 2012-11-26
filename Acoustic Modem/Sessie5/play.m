%INPUT
Fs = 16000;
length = 16001; %One second, other numbers give the same result
%d = ones(length,1);
d = rand(2*Fs, 1)-0.5;

%PLAY
[simin,nbsecs,fs] = initparams(d,Fs,20);
%OUTPUT
sim('recplay');
out=simout.signals.values;
