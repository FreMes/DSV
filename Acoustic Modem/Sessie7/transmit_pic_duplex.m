    Fs = 16000;
    
    N = 512;
    M = 16;
    Nq = log2(M);
    L_CP = 150;
    SNR = 100;
    BWusage = 100;
    
    Lt = 5;
%---CREATE TRAINBLOCK---%

    trainbits = randint((N/2-1)*Nq,1,[1,0]); 
    trainblock = qam_mod(trainbits, M);
    
%---Estimate channel & select best tones---%
%     estimatechannel;
%  
%     [values,indexes] = sort(abs(estH(2:N/2)),'descend');
     NbOfTones = floor((N/2-1)*BWusage/100);
%     goodFreqs = sort(indexes(1:floor((N/2-1)*BWusage/100)),'ascend') + ones(NbOfTones,1);
%      goodFreqs = [29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62;63;64;65;66;67;68;69;70;71;72;73;74;75;76;77;78;79;80;81;82;83;84;85;86;87;88;89;90;91;92;93;94;95;96;98;105;106;107;108;109;110;111;112;113;114;115;116;117;118;119;120;121;122;123;124;125;126;127;128;129;130;131;132;133;134;135;136;137;138;139;140;141;142;143;144;145;146;147;148;149;150;151;152;153;154;155;156;157;158;159;160;161;162;163;164;165;166;167;168;169;170;171;172;173;174;175;176;177;178;179;180;181;182;183;184;185;186;187;188;189;190;191;192;193;194;195;196;197;198;199;200;201;202;203;204;205;206;207;208;209;210;211;212;213;];    
    goodFreqs = 1:1: N/2-1;
%---CREATE qamStream---%
    % Convert BMP image to bitstream
    [bitStream, imageData, colorMap, imageSize, bitsPerPixel] = imagetobitstream('image.bmp');
    
    rest = rem(size(bitStream,1),NbOfTones*Nq);
    newBitStream = bitStream;
    if ~(rest == 0)
        newBitStream = [bitStream; zeros((NbOfTones*Nq)-rest,1)];
    end  
    
    randBits = randint(length(newBitStream)+length(trainbits)*Lt,1,[1,0]);
    % QAM modulation      
    qamStream1 = qam_mod(randBits,M);
    qamStream2 = qam_mod(newBitStream,M);
%---OFDM modulation: alternation---%
    Ld1 = length(qamStream1)/NbOfTones;
    Ld2 = length(qamStream2)/NbOfTones;
    P=Lt+Ld2;
    Tx1 = ofdm_mod(qamStream1,N,0,Ld1,L_CP,0,goodFreqs);
    Tx2 = ofdm_mod(qamStream2,N,Lt,Ld2,L_CP,trainblock,goodFreqs);

%---Play signal---%

    %PLAY
    tSync = 1000;
    [simin,nbsecs,fs] = initparams_duplex(Tx1,Tx2,Fs,tSync);
    %OUTPUT
    sim('recplay');
    out=simout.signals.values;
    out_aligned = alignIO(out,0.05,tSync);
    Rx = out_aligned(1:(N+L_CP)*(Ld1+Lt));

    
%---OFDM demod---%
     [rxQamStream,W] = ofdm_demod_duplex(Rx, N,M,L_CP,Lt,Ld1,trainblock,goodFreqs);
    
    figure()
    plot(20*log(abs(ifft(conj(1./W(:,1)),N))));
%     figure()
%     plot(20*log(abs(1./W(:,5))));
%     figure()
%     plot(20*log(abs(1./W(:,20))));
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
