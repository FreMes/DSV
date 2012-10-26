function out = median( length, in )

    if((mod(length,2)) == 0)
        error('Must be an odd number');
    end

    halflength = (length-1)/2;
    
    [m,s]=size(in)
    
    window = zeros(1,length)
    out = zeros(1, s)
    out(1,1) = in (1,1);
    for i=halflength+1:(s-halflength)
        window(1,1:length) = in(1,(i-(halflength)):(i+halflength));
        window = sort(window);
        out(1,i) = window(1,halflength+1);
    end
    out(1,s) = in(1,s);   

end

