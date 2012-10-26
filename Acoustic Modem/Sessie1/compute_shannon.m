Fs = 16000;
B = Fs/2;
N = B/2; % ??

Noise = randn(Fs, 1);


Ps
Pn

C = Fs/(2*N) * symsum(log2(1+(Ps/Pn)),k,1,N)