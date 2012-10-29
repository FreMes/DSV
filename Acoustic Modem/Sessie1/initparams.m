function [ simin, nbsecs, fs ] = initparams( toplay, fs )
maxvalue = max(abs(toplay));
if(maxvalue > 0)
    toplay = toplay/maxvalue; %herschaling naar [-1,1]
end

simin = zeros(size(toplay,1)+3*fs,2);
simin(:,1)=0:1/fs:((size(simin,1)-1)/fs); % eerste kol
simin(2*fs+1:end-fs,2) = toplay; % tweede kol

nbsecs = size(simin,1)/fs; 


end

