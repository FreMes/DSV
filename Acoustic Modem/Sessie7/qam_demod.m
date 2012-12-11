function y = qam_demod(x, M)
% x_denorm = x*sqrt(2/3*(M-1));
demodulator = modem.qamdemod('M', M, 'OutputType', 'Bit');
y = demodulate (demodulator,x/50);
figure()
    plot(abs(x/50));
end