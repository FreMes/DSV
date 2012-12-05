% Exercise session 4: DMT-OFDM transmission scheme
L_CP=100;  %length cyclic prefix
SNR =10;     
L = 100;      %Channel order
M = 4;
Nq = log2(M);
DFTsize = 512;
N=DFTsize;

onOffThreshold = -55;

  h = [-0.000117806361009542;-6.35073149979295e-05;0.000148772813085734;-5.09997293123670e-05;-3.73273581652360e-05;0.000109800563485032;2.03623798612299e-05;-2.64896776329267e-05;-7.21984151627543e-05;-0.000109720904614347;9.38092781554181e-05;-0.000191936298490750;-0.000329678650927421;0.000857393471375034;-0.00469296482747279;0.00869315809676425;-0.00754121466280920;-0.00187543742909424;0.0250419305540766;-0.139442581878913;0.0285294248488547;0.153031452622206;-0.109949162711814;0.0423086075887725;0.113719174964889;-0.0782985398643644;0.00508136718914438;0.0270042956599710;-0.0531860228717104;0.0120676180247180;-0.0288843282291479;-0.0253841711856690;0.0143743249270383;-0.0280215497076475;0.00842607267898210;0.0174710523095611;-0.000992320504693603;0.0269193514518572;0.0172861034508791;0.00331642873740753;0.0116476573950360;-0.00715678358556105;-0.0141029888653270;-0.00503180596946365;-0.0111262076546111;-0.00876684927500512;-0.00675570015726142;-0.0108448806415707;-0.00465271973966649;-0.000385444683648259;0.00198505897042121;0.00880670364669409;0.0102292572662437;0.0115663656681205;0.0108959299902284;0.00694839336085255;0.00430164544042320;-0.000396177541003699;-0.00375633508179228;-0.00601445142517570;-0.00761418490732689;-0.00705102647846649;-0.00614010162353057;-0.00651461086138985;-0.000977280059850523;0.00484041908558847;-0.00264779590942283;0.00220920501226362;0.0116743249911572;0.000296322094929267;-3.27216147082476e-05;0.00686796343434006;-0.00223102261874216;-0.00250385316614465;0.00151984902402860;-0.00307146627895252;-0.00107960591512407;-0.000310779180771214;-0.00250391844972797;0.000852371460728626;-0.00109739786729450;-0.00148518965208504;0.00208760565077804;-0.00149172615382126;-0.00137850745927384;0.000898163757592046;-0.00202261982799577;-0.000728277305256777;0.00101624940525626;0.000358901291781296;0.00184439762618447;0.00186746709829024;0.00141252719279210;0.00156917186343500;0.000341168300019457;-0.000540585274386862;-0.000553674848606139;-0.00107075622987391;-0.00226057367545313;-0.00213450692208273;];
  H = fft(h,N);
  H2 = 20*log(abs(fft(h,N)));
  
%   plot(20*log(abs(H)));
  goodFreqs = find(H2(2:N/2)>onOffThreshold);
%   nbBadFreqs = DFTsize/2-1-length(goodFreqs);

  
% Convert BMP image to bitstream
[bitStream, imageData, colorMap, imageSize, bitsPerPixel] = imagetobitstream('image.bmp');

% Make size compatible
rest = rem(length(bitStream),length(goodFreqs*Nq))
newBitStream = bitStream;
if ~(rest == 0)
    newBitStream = [bitStream; zeros(length(goodFreqs)*Nq-rest,1)];
end

rest = rem(length(newBitStream),log2(M))
newBitStream2 = newBitStream;
if ~(rest == 0)
    newBitStream2 = [newBitStream; zeros(log2(M)-rest,1)];
end  

% QAM modulation                                    
qamStream = qam_mod(newBitStream2,M);

% OFDM modulation
% < slechte freqs bepalen => meegeven met ofdm mob en demod
ofdmStream = ofdm_mod(qamStream,N,L_CP,goodFreqs);


rxOfdmStream = filter(h,1,ofdmStream);
wxOfdmStream = awgn(rxOfdmStream,SNR,'measured');

% OFDM demodulation
P=floor(size(qamStream,1)/length(goodFreqs));
rxQamStream = ofdm_demod(wxOfdmStream,N,L_CP,H,P,goodFreqs);
% rxQamStream = rxOfdmStream;

% QAM demodulation
rxBitStream = qam_demod(rxQamStream,M);

% Compute BER
 berTransmission = ber(newBitStream2(1:length(rxBitStream)),rxBitStream);

% Construct image from bitstream
imageRx = bitstreamtoimage(rxBitStream, imageSize, bitsPerPixel);

% Plot images
figure()
subplot(2,1,1); colormap(colorMap); image(imageData); axis image; title('Original image'); drawnow;
subplot(2,1,2); colormap(colorMap); image(imageRx); axis image; title(['Received image']); drawnow;
