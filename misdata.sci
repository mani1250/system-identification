function  [y] = nanhandle(d , method)
// Handles missing values.
//
// Calling Sequence
//   [y] = nanhandle(d,method) 
//



// input parameter check
  [LHS RHS] = argn(0);
  if (RHS ~= 2)
    error('Wrong number of input arguments. Use [y] = nanhandle(d,method).')
  end

  if(~exists('d') | ~exists('method'))
  error('Input vector or method undefined!'); end; 
   
  if((size(method))~=[1,1])
  error('Incorect method select. 1 - ZOH, 2 - linear interpolation');end;
   
  if(method < 1 | method > 2)
  error('Incorect method select. 1 - ZOH, 2 - linear interpolation');end;
 
// input data dimensions
 m = size(d,1);
 N = size(d,2); 
 
// check first and last indexes in a row for NaN    
for i=1:m
// first NaN in a row replaced by first available value  
  if(isnan(d(i,1)))
    uNan = find(~isnan(d(i,:)));
    d(i,1) = d(i,uNan(1));
  end
// last NaN in a row replaced by last available value
  if(isnan(d(i,$)))
    uNan = find(~isnan(d(i,:)));
    d(i,N) = d(i,uNan($));
  end
end

select method,
  
   
// ZOH (Zero Order Hold) interpolation     
case 1,
  for j = 1:m  // for all rows
    for i = 2:N
      if(isnan(d(j,i)))
        d(j,i)=d(j,i-1);
      end
    end
  end,
  y = d;  
    
// linear interpolation 
case 2,
  
  for j=1:m   // for all rows
    u = isnan(d(j,:))*1;
    v = diff(u);
    pos= find(v~=0)+1;
    
    for i = 1:length(pos)/2
      umin = pos(1); umax=pos(2)-1;
      dmin = d(j,umin-1);
      dmax = d(j,umax+1);
      p = pos(2)-pos(1)+1;
      inc = (dmax - dmin)/p;
      d(j,pos(1):(pos(2)-1)) = linspace(dmin+inc,dmax-inc,p-1);
      
      pos = pos(3:length(pos));
    end
  end
  
  y = d;
end // select end


endfunction
