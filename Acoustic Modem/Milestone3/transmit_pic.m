    Fs = 16000;

    N = 512;
    M = 16;
    Nq = log2(M);
    L_CP = 150;
    SNR = 100;
    
    Lt = 5;
    Ld = 50;
%---CREATE TRAINBLOCK---%

    bitStream = randint((N/2-1)*Nq,1,[1,0]); 

    trainblock = qam_mod(bitStream, M);

%---CREATE qamStream---%
    % Convert BMP image to bitstream
    [bitStream, imageData, colorMap, imageSize, bitsPerPixel] = imagetobitstream('image.bmp');
    
    rest = rem(size(bitStream,1),Ld*(N/2-1)*Nq);
    newBitStream = bitStream;
    if ~(rest == 0)
        newBitStream = [bitStream; zeros((Ld*(N/2-1)*Nq)-rest,1)];
    end  

    % QAM modulation                                    
    qamStream = qam_mod(newBitStream,M);
%---OFDM modulation: alternation---%
P=floor(length(qamStream)/(N/2-1));
Tx = ofdm_mod(qamStream,trainblock,N,Ld,Lt,L_CP,P,[2:1:N/2]');

%---Play signal---%

    %PLAY
    tSync = 1000;
    [simin,nbsecs,fs] = initparams(Tx,Fs,tSync);
    %OUTPUT
    sim('recplay');
    out=simout.signals.values;
    out_aligned = alignIO(out,0.05,tSync);
    Rx = out_aligned(1:(N+L_CP)*(P+(P/Ld)*Lt));
    
    wxOfdmStream = awgn(Rx,SNR,'measured');
%---OFDM demod---%
    [rxQamStream,channel_est] = ofdm_demod(Rx, N,L_CP,Ld,Lt, Tx,trainblock,P,[2:1:N/2]');
    
%---QAM demod---%
    rxBitStream = qam_demod(rxQamStream,M);

%---BER---%
    berTransmission = ber(newBitStream(1:length(rxBitStream)),rxBitStream);

 
%---Image---%
    % Construct image from bitstream
    imageRx = bitstreamtoimage(rxBitStream, imageSize, bitsPerPixel);

    % Plot images
    figure()
    subplot(2,1,1); colormap(colorMap); image(imageData); axis image; title('Original image'); drawnow;
    subplot(2,1,2); colormap(colorMap); image(imageRx); axis image; title(['Received image']); drawnow;
