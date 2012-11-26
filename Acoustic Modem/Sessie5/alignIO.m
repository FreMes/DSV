function [out_aligned] = alignIO(out,threshold)
    ind_pulse = find(out>threshold,10000)
    index = find(ind_pulse>45000,1)
    out_index = ind_pulse(index,1)
    
    out_aligned = out(out_index-20:end);
end

 