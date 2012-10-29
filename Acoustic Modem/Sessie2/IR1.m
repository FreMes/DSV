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
stem(-halflength: 1 : +halflength,out);

subplot(2,1,2);
