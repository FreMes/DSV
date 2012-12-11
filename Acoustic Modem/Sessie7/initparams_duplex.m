function [simin,nbsecs, fs ] = initparams_duplex(leftSignal,rightSignal,fs,tsync)
maxvalue = max(abs(leftSignal));
 if(maxvalue > 1)
     leftSignal = leftSignal/maxvalue; %herschaling naar [-1,1]
 end
 
 maxvalue = max(abs(rightSignal));
 if(maxvalue > 1)
     rightSignal = rightSignal/maxvalue; %herschaling naar [-1,1]
 end

simin = zeros(size(leftSignal,1)+3*fs + tsync,4);
simin(:,1)=0:1/fs:((size(simin,1)-1)/fs); % eerste kol
simin(:,3)=0:1/fs:((size(simin,1)-1)/fs); % eerste kol


simin(2*fs+1,2) = 1; 
simin(2*fs+1,4) = 1; 

simin(2*fs+tsync+1:end-fs,2) = leftSignal; % tweede kol
simin(2*fs+tsync+1:end-fs,4) = rightSignal; % derde kol

nbsecs = size(simin,1)/fs;
end