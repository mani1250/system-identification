function disp_mod(N1,covN1)
len = length(covN1);
B1 = pol2str(N1); 
ind = strindex(B1,['+','-']);  
ind = ind - 1;
if ind~=-1 then B2 = strsplit(B1,ind); 
else B2 = B1;  end;
covB = string(covN1);
  
  if ascii(B2(1)) == 32
  B2 = B2(2:len+1); 
  end; 
  
  B3(1) = ' ';
  for i=1:len
    B3(i) = strsubst(B2(i),'*x','(+-' + covB(i) + ')*x');
  end;

  B4 = B3(1); //disp(15); pause
  
  for i=2:len
  B4 = B4 + ' ' + B3(i);
  end;

disp(B4);
endfunction;
