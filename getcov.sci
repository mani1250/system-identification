function X = getcov(sys)
    // sys is an idpoly object
    X = zeros(n,n);
    n = length(params(sys))
    for(i = 1:n)
        for(j = 1:n)
            X(i,j) =  
endfunction


function M = params(sys)
    if(sys.Type == 'arx' | sys.Type == 'armax')
        coefs = [sys.A sys.B];
        na = length(sys.A) - 1; nk = sys.ioDelay;
        nb = length(sys.B);
        if(sys.Type == 'armax')
            coefs = [coefs sys.C(2:$)]
            nc = length(sys.C) - 1;
        end
    elseif(sys.Type == 'oe')
        coefs = [sys.B sys.F1(2:$)]
        nf = length(sys.F1) - 1;
        nk = sys.ioDelay;
        nb = length(sys.B);
    end
    M = coefs;
endfunction
