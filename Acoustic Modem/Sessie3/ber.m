function ber_qam = ber(transmitted, received)
length=size(transmitted,1);
j = 0;
for i= 1:length
    if(transmitted(i) ~= received(i))
        j = j+1;
    end
end
ber_qam = j/length;

end