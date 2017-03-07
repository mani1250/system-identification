function u = rbs(n,band,levels)
    delta = [0.03 0.05];
    P = n;
    u = rand(5*P,1,'rormal');
    if(band(1)~=0 | band(2) ~= 1)
        u1 = iir(8,'bp','butt',[band(1) band(2)],[delta(1) delta(2)])
        u = filter(u1.num,u1.den,u);
    end
    u = sign(u(2*P+1:$-2*P)); // to take out transients
    u = (levels(2) - levels(1))*(u+1)/2 + levels(1);
endfunction
