% Exercise session 4: DMT-OFDM transmission scheme
L_CP=1000;

% Convert BMP image to bitstream
[bitStream, imageData, colorMap, imageSize, bitsPerPixel] = imagetobitstream('bitmapmarv.bmp');

% QAM modulation                                    
qamStream = qam_mod(bitStream,4);

% OFDM modulation
ofdmStream = ofdm_mod(qamStream,L_CP);
% ofdmStream = qamStream;

% Channel
rxOfdmStream = ofdmStream;

% OFDM demodulation
rxQamStream = ofdm_demod(rxOfdmStream,length(ofdmStream) - L_CP,1,L_CP);
% rxQamStream = rxOfdmStream;

% QAM demodulation
rxBitStream = qam_demod(rxQamStream,4);

% Compute BER
% berTransmission = ber(bitStream,rxBitStream);

% Construct image from bitstream
imageRx = bitstreamtoimage(rxBitStream, imageSize, bitsPerPixel);

% Plot images
subplot(2,1,1); colormap(colorMap); image(imageData); axis image; title('Original image'); drawnow;
subplot(2,1,2); colormap(colorMap); image(imageRx); axis image; title(['Received image']); drawnow;
