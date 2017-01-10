function [y, x] = sim(A,B,C,D,u,x0)
//Response of a discrete-time LTI system.
//
// Calling Sequence
// [y, x] = lsim(A,B,C,D,u) //x0 = 0
// [y, x] = lsim(A,B,C,D,u,x0)
// [y, x] = lsim(ssSystem,u) //x0 specified inside ssSystem
// [y, x] = lsim(A(d),B(d),u)
//
// Parameters
//   Inputs:
//     A,B,C,D: system matrices
//     u: input data
//     x0: initial state 
//     A(d), B(d): coefficients of polynomial matrices describing an ARX (or partially ARMAX) system .
//   Outputs:
//      y: output of the system
//      x: state sequence of the system (including x0)
//
// Description
// Computes the response of a discrete-time LTI system given the input of the system u. x0 = 0 is assumed if no initial state is provided. For state-space description, the function accepts directly state-space matrices or ss structure created, for instance, by syslin() function.
//
//The polynomial matrices A(d), B(d) are p x p x (na+1), p x m x (nb+nk) for MIMO systems or row vectors for SISO.
//
// Examples
//A = [0.8 1;0 0.6]; B = [0;1]; C = [1 0]; D = 0; x0 = [0;0];
//sys = syslin('d',A,B,C,D,x0); // discrete-time LTI
//u = ones(1,40);
//y = lsim(sys,u); //step response
//plot(y);
//g = gcf();
//g.children.children.children.polyline_style = 2; //stairs-like plot
//
// See also
// subid
// subspaceIdent
// estimatex0

[LHS RHS] = argn(0);
if (RHS < 2 | RHS > 6)
   error('Wrong number of input arguments. Use lsim(A,B,C,D,u [,x0]) or lsim(A(d),B(d),u) or lsim(ssSystem,u).');
end
//------------------------//polynomial description-----------------------
if (RHS  == 3) 
  uv = C;
  if (size(uv,1) < size(uv,2))
    uv = uv';
  end
//if (size(size(A),2) == 2) // SISO
//  na = size(A,2)-1; nb = size(B,2);
//  ys = zeros(max(na+1,nb),1); // edit na ~~ na +1
//  uv = [zeros(max(na,nb),1); uv];
//  a = A; b = B;
//  for i = 1+max(na,nb) : size(uv,1)
//    ys = [ys; [-a(2:$)*ys(i-1: -1: i-na) + b*uv(i:-1:i-nb+1)]];
//  end
if (size(size(A),2) == 2) // SISO
    na = size(A,1)*size(A,2) - 1;
    nb = size(B,1)*size(B,2);
    ys = zeros(max(na+1,nb),:);
    a = A; b = B;
    for i = max(na+1,nb)+1 : size(uv,1)
      ys = [ys; -ys(i-na:i-1)'*a($:-1:2)' + uv(i-nb+1:i)'*b($:-1:1)'];
    end

  y = ys;//(max(na,nb)+1:$,:);
  
else //MIMO
  p = size(A,1); m = size(uv,2); 
  na = size(A,3)-1; nb = size(B,3);
  ys = zeros(max(na,nb),p);
  uv = [zeros(max(na,nb),m); uv];
  for i = 1+max(na,nb) : size(uv,1)
    yi= zeros(p,1);
    for j=1:na
      yi = yi - A(:,:,j+1) * ys(i-j,:)'; 
    end
    for j=1:nb
      yi = yi + B(:,:,j) * uv(i-j+1,:)'; 
    end
    ys = [ys;yi'];
  end
  y = ys(max(na,nb)+1:$,:);
end
//-----------------state-space description---------------
else
  if (RHS == 2)
    ssSystem = A;
    u = B;
    try
      [A B C D] = abcd(ssSystem);
      x0 = ssSystem.x0;
    catch
      error('ssSystem incorectly specified.')
    end
  end
  try
    S = [A B; C D];
  catch
    error('Incompatible dimensions of A,B,C,D')
  end 
  if (RHS == 5) //x0 = 0
    x0 = zeros(size(A,1),1);
  else
    if (size(x0,1) < size(x0,2))
      x0 = x0';
    end
    if (size(A,1) ~= size(x0,1)*size(x0,2))
      error('Incompatible size of x0.');
    end
  end

  if (size(u,2) < size(u,1))
    u = u';
  end
  n = size(A,1);
  N = size(u,2);
  x = zeros(n,N+1);
  y = zeros(size(C,1),N);
  x(:,1) = x0;
  for k=1:N
    y(:,k) = C*x(:,k) + D*u(:,k);
    x(:,k+1) = A*x(:,k) + B*u(:,k)
  end
  y = y';
end  
  
endfunction
