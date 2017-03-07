function process_ar = armac1(a,b,c,d,f,sig)
ny = 1; nu =1; 
a1 = convol(convol(a,f),d);
b1 = convol(b,d);
d1 = convol(c,f);
process_ar = armac(a1,b1,d1,ny,nu,sig);

endfunction;
