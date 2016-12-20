function out = checkunity(x)
    if(size(x)==1 & x==1)
        out = "TRUE"
    else
        out = "FALSE"
    end
    return(out)



function X = typecheck(x)
    for x = x(1):x(5)
        y = checkunity(x)
        if(y=="TRUE")
            X = 
    end
endfunction