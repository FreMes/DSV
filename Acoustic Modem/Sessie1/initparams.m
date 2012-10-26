function [ simin, nbsecs, fs ] = initparams( toplay, fs )

toplay_scaled = toplay/max(abs(toplay)) %herschaling naar [-1,1]

simin = zeros(size(toplay_scaled,1)+3*fs,2);
simin(:,1)=0:1/fs:((size(simin,1)-1)/fs); % eerste kol
simin(2*fs+1:end-fs,2) = toplay_scaled; % tweede kol

nbsecs = size(simin,1)/fs; 


end

