function v = covf(z,n)
[r c] = size(z);
y1 = z(:,1);
u1 = z(:,2);
  if n>r  
  //  disp('Incorrect number of lags');
    n = r;
  else 
    r = n;
  end;
ryu = corr(y1,u1,r);
ruy = corr(u1,y1,r);;
ryy = corr(y1,r);
ruu = corr(u1,r);
v = [ryy; ruy; ryu; ruu]
endfunction;
