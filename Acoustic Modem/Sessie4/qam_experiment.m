length = 32;
M = 16;
randseq = randint(length,1,[1,0]);

qam = qam_mod(randseq,M);
% qam_norm = qam/sqrt(10);
qamnoise = awgn(qam,5,'measured'); %ruis toevoegen

% Create modulator
hMod = modem.qammod(M);
% Create a scatter plot
scatterPlot = commscope.ScatterPlot('SamplesPerSymbol',1,'Constellation',hMod.Constellation);
% Show constellation:
scatterPlot.PlotSettings.Constellation = 'on';
scatterPlot.PlotSettings.ConstellationStyle = 'rx';

scatterPlot.PlotSettings.SignalTrajectory = 'on';

hold on;
% for i=1:M/2
%     x = qammatrix(:,i);
%     scatter(real(x),imag(x),'filled');
% end

x = qamnoise;
scatter(real(x),imag(x),'filled');
hold off;

qamdemod = qam_demod(qamnoise,M);

qamber = ber(randseq,qamdemod)