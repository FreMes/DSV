function y = qam_demod(x, M)
length = size(x,1);
wordlength = log2(M);

demodulator = modem.qamdemod('M', M, 'OutputType', 'Bit');
y = demodulate (demodulator,x)

end

