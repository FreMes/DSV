
transmit_pic_bitload;
  
for i = 1:P/Ld
    bits = rxBitStream(1:i*Ld*NbOfTones*Nq);
    
    estH_goodfreqs = zeros(N/2-1,1);
    estH_goodfreqs(bestTones) = channel_est(bestTones,i);
    
        % Construct image from bitstream
    imageRx = bitstreamtoimage(bits, imageSize, bitsPerPixel);
    % Plot images
    pause(1);       %send time
    figure()
    hold on;
    subplot(2,2,1); plot(real(ifft(channel_est(:,i),N)),'DisplayName','h','YDataSource','h'); xlim([0 100]); xlabel('Time (samples)'); ylabel('IR response');
    subplot(2,2,3); plot(20*log(abs(estH_goodfreqs))); ylim([-150 0]); xlim([0 256]); xlabel('Relative Frequency'); ylabel('dB');
    subplot(2,2,2); colormap(colorMap); image(imageData); axis image; title('Original image'); drawnow;
    subplot(2,2,4); colormap(colorMap); image(imageRx); axis image; title(['Received image']); drawnow;
    hold off;
end
