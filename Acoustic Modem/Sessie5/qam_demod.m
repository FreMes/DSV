function y = qam_demod(x, M)

demodulator = modem.qamdemod('M', M, 'OutputType', 'Bit');
y = demodulate (demodulator,x);

end