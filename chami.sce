function X = chami(a,b,c)
    if (size(a,'*') > 1 & size(b,'*') > 2) then
        disp('You are going in a correct direction keep going')
    end
    X = a*b*c^2;
    disp(X)
endfunction



function out = checkunity(x)
    if(size(x)==1 & x==1)
        out = "TRUE"
    else
        out = "FALSE"
    end
    return(out)
endfunction
 
 
