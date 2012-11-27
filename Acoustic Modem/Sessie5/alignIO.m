function [out_aligned] = alignIO(out,threshold,tSync)
    ind_pulse = find(out>threshold,100);
    index = find(ind_pulse>30000,1);
    out_index = ind_pulse(index,1);
    
    out_aligned = out(out_index-20+tSync:end);
end

 