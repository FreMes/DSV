function y = qam_mod(x, M)
length = size(x,1);
wordlength = log2(M);
% % if( length/(M/2) ~= floor(length/(M/2)) )
% %     error('Vectore must be of a good size');
% % end
% qam = zeros(length/(M/2),M/2);
% 
% k=1;
% i=1;
% j=1;
% 
% % while(i<=length/(M/2))
% %     qam(i,:) = x(((i-1)*M/2)+1:((i-1)*M/2+M/2),1)';
% %     i =i+1;
% % end
% 
% while(i<length)
%     qam(j:j+wordlength-1,k) = x(i:i+wordlength-1,1)';
%     i =i+wordlength;
%     k=k+1;
%     if(mod(k,M/2) == 1)
%         j=j+wordlength;
%         k=1;
%     end
% end
% qam

modulator = modem.qammod('M', M, 'InputType', 'Bit');
y = modulate (modulator,x)

end

