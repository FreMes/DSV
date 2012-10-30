Fs = 16000;

length = 16001
halflength = floor(Fs/2);
d = zeros(length,1);
d(halflength+1,1) = 1;
    
[simin,nbsecs,fs] = initparams(d,Fs);

sim('recplay');
out=simout.signals.values;    

figure(1);

subplot(2,1,1);
%stem(-halflength-63: 1 : +halflength+64,out);
index = find(out==(max(max(out))))

out(index-20:index+80)
plot(out(index-20:index+80));

subplot(2,1,2);
plot(20*log(abs(fft(out(index-20:index+80)))));