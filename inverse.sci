function X = inverse(y,k)
    X = [];
    for(i=1:k-1)
        X = [X y.^(i-1)]
    end
endfunction
