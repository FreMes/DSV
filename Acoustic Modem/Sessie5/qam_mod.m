function qamsymbols = qam_mod(x, M)

modulator = modem.qammod('M', M, 'InputType', 'Bit');
qamsymbols = modulate (modulator,x);

end