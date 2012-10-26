function [] = oef3( length )
if((mod(length,2)) == 0)
    error('Must be an odd number');
end
    halflength = (length-1)/2;
    d = zeros(length,1)
    d(halflength+1,1) = 1

    mu = zeros(length,1)
    mu((halflength+1):length,1) = 1
    
    nmu = zeros(length,1)
    nmu((halflength+1):length,1) = 0 : 1 : halflength

    figure(1);
    subplot(3,1,1);
    stem(-halflength: 1 : +halflength,d);
    title('sample');
    subplot(3,1,2);
    stem(-halflength: 1 : +halflength,mu);
    title('step');
    subplot(3,1,3);
    stem(-halflength: 1 : +halflength,nmu);
    title('ramp');
    
%     zonder oneven samples:

    
end

