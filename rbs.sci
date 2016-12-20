function [X,X1] = rbs(n,band,levels)
    X = zeros(n,1);
    ct1 = band(1);
    ct2 = band(2);
    mu = (levels(1) + levels(2))/2;
    sigma = (levels(1) - levels(2))/2;
    v = rand(n,1,'normal');
    hz= iir(n,'bp','butt',[ct1 ct2],zeros(n,1));
    num = hz.num;
    den = hz.den;
    X1 = filter(num,den,v);
    for i = 1:n
        if(X1(i)>0)
            X(i) = 1;
        else
            X(i) = -1;
        end
    end
    
    return(X)
endfunction
