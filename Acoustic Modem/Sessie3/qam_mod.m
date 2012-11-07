function y = qam_mod(x, M)
length = size(x,1);
% if( length/(M/2) ~= floor(length/(M/2)) )
%     error('Vectore must be of a good size');
% end
qam = zeros(size(x,1)/(M/2),M/2);

k=1;
i=1;
while(i<=length/(M/2))
    qam(i,:) = x(((i-1)*M/2)+1:((i-1)*M/2+M/2),1)';
    i =i+1;
end
qam

modulator = modem.qammod('M', M, 'InputType', 'Bit');
y = modulate (modulator,qam)

test = qammod(qam,M)
end

