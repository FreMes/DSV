% t = zeros(5000,1);
% for i=1:5000
%    t(i,1)= (1/5000)*i;
% end
% 
% c = sin(2*pi*262*t);
% 
% sound(c,1000);
Fs = 1000;      % Samples per second -> Hoog genoeg volgens Nyquist
nSeconds = 1;   % Duration of the sound
toneFreq = 262; % Tone frequency, in Hertz
y = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

toneFreq = 330;  
y(1,1001:2000) = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

toneFreq = 349;  
y(1,2001:3000) = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

toneFreq = 392;  
y(1,3001:4000) = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

toneFreq = 440;  
y(1,4001:5000) = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));
% 
% toneFreq = 494;  
% y(1,10001:12000) = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

% toneFreq = 523;  
% y(1,12001:14000) = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

sound(y, Fs);


spectrogram(y,128,120,128,1E3,'yaxis');
