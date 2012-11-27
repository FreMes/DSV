function qamsymbols_norm = qam_mod(x, M)
modulator = modem.qammod('M', M, 'InputType', 'Bit');
qamsymbols = modulate (modulator,x);
qamsymbols_norm = qamsymbols/sqrt(2/3*(M-1));
end