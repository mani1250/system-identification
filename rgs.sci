function X = rgs(n,band,levels)
    ct1 = band(1);
    ct2 = band(2);
    mu = (levels(1) + levels(2))/2;
    sigma = (levels(1) - levels(2))/2;
    v = rand(n,1,'normal');
    hz= iir(n,'bp','butt',[ct1 ct2],zeros(n,1));
    num = hz.num;
    den = hz.den;
    X = filter(num,den,v);
    return(X)
endfunction
