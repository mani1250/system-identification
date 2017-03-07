function out = typecheck(A,B,C,D,F1)
    if(A==1)
        if(C==1 | F1==1)
            out = "oe"
        else
            out = "bj"
        end
    elseif(D==1 & F1==1)
        if(C==1)'
            out = "arx"
        else
            out = "armax"
        end
    else
        out = "idpoly"
    end
endfunction
