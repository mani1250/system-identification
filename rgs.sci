function u = rgs(n,band,levels)
    delta = [0.03 0.05]
    P = n;
    u = [
    1.0347 
    0.7269
   -0.3034
    0.2939
   -0.7873
    0.8884
   -1.1471
   -1.0689
   -0.8095
   -2.9443
    1.4384
    0.3252
   -0.7549
    1.3703
   -1.7115
   -0.1022
   -0.2414
    0.3192
    0.3129
   -0.8649
   -0.0301
   -0.1649
    0.6277
    1.0933
    1.1093];
    if(band(1)~=0 | band(2) ~= 1)
        u1 = iir(8,'bp','butt',[band(1) band(2)],[delta(1) delta(2)])
        u = filter(u1.num,u1.den,u);
    end


    u = u(2*P+1:$-2*P); // to take out the transients
    u = u - mean(u);
    u = (levels(2) + levels(1))/2 + u*(levels(2)-levels(1))/2/sqrt(u'*u/length(u))
endfunction
