function X = idinput(n,Type,band,levels)
    
    select Type
    case 'rbs' then
        X = rbs(n,band,levels)
    case 'rgs' then
        X = rgs(n,band,levels)
    end
endfunction
