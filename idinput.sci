function K = idinput(n,Type,band,levels)
    
    select Type
    case 'rbs' then
        K = rbs(n,band,levels)
    case 'rgs' then
        K = rgs(n,band,levels)
    end
    
endfunction

