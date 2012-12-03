transmit_pic_pilots;

figure(4)  
for i = 1:P
    bits = rxBitStream(1:i*floor((N/2-1)/2)*Nq);
    
        % Construct image from bitstream
    imageRx = bitstreamtoimage(bits, imageSize, bitsPerPixel);
    % Plot images
    pause(0.0079);       %send time
    
    hold on;
    subplot(2,2,1); plot(real(ifft(channel_est(:,i),N)),'DisplayName','h','YDataSource','h'); xlim([0 100]); xlabel('Time (samples)'); ylabel('IR response');
    subplot(2,2,3); plot(20*log(abs(channel_est(:,i)))); ylim([-150 0]); xlim([0 256]); xlabel('Relative Frequency'); ylabel('dB');
    subplot(2,2,2); colormap(colorMap); image(imageData); axis image; title('Original image'); drawnow;
    subplot(2,2,4); colormap(colorMap); image(imageRx); axis image; title(['Received image']); drawnow;
    hold off;
end