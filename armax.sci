function [m, vare, P, nu] = armax(y, u, na, nb, nc, nk, method, phi, theta0, P0, nu0, vare0, eps0)
//  ARMAX model estimation.
//
// Calling Sequence
//   [a, b, c, vare] = armax(y,u,na,nb,nc) //nk = 0, phi = 1
//   [a, b, c, vare] = armax(y,u,na,nb,nc,nk) //phi = 1
//   [a, b, c, vare] = armax(y, u, na, nb, nc, nk, phi)
//   [a, b, c, vare, P, nu, eps] = armax(y, u, na, nb, nc, nk, phi, theta0, P0)
//   [a, b, c, vare, P, nu, eps] = armax(y, u, na, nb, nc, nk, phi, theta0, P0, nu0, vare0, eps0)
//
// Parameters
//   Inputs:
//   y: vector of outputs
//   u: vector of inputs
//   na: number of poles = [number of coefficients of a(d)] - 1
//   nb: number of zeros + 1 = [number of coefficients of b(d)] - nk
//   nc: number of coefficients of the noise filter numerator - 1
//   nk: input-output time delay
//   method: 'RLS' Recursive Least squares estimate
//           'TLS' LS + Total least squares estimate (suitable for Errors-In-Variables systems identification)
//           'RTLS' LS + Regularized Total-Least Squares estimate (suitable for Errors-In-Variables systems identification)f
//           'SID' Prediction error method initialized by subspace (SID) method by utilizing a structure information in subspace identification (it can be used a substruc.sci function too - there it can be specified prediction horizon of ARMAX model - here is 10 steps fixedly).
//           theta0: initial estimate of the polynomials a(q), b(q): theta0 = [a0 b0 c0]
//           P0: The covarience matrix of the initial estimate of [-a0($:-1:2), b0($:-1:1), c0($:-1:1)]
//           nu0: initial index in the recursion - acts as a weight of the vare0 estimate
//           vare0: Initial estimate of the noise varience
//           phi: exponential forgetting factor: 1 -> no forgetting, common choice: phi in [0.9, 1]
//           eps0: estimates of the prediction error 
//   Outputs:
//           m: Uniform Identification Toolbox model structure (see help idmodel)
//            a: coeficients of a(d)
//            b: coeficients of b(d)
//            c: coeficients of c(d)
//            vare: the varience of e
//            P: normed covarience matrix of the estimate, i.e. P_true / vare.
//            nu: index in the recursion
//            eps: the last prediction error
//
// Description
//   Computes recursively an armax model of a given order, and the input noise varience. An initial estimate theta0, P0 and the forgetting factor phi are optinal parameters. The optional parameters nu0, vare0, eps0 can be used for recursive identification.
//
//Standard armax model structure is used:
//
//      a(d)y(t) = b(d)u(t) + c(d)e(t), where
//
//      a(d) = 1 + a_1*d + ... + a_na*d^na  
//
//      b(d) = b_0*d^nk + ... + b_nb * d^(nk+nb)
//
//      c(d) = 1 + c_1*d + ... + c_nc * d^nc,
//
//      with d being the unit delay operator: dx(t) = x(t-1).
//
//The length of the input data vectors u, y must be at least max(na+1, nb+nk).
//
// Examples
//data = read('../demos/dryer.dat',-1,2); //data = [u y]
//y = data(1:400,2); u = data(1:400,1); //identification data
//yv = data(401:$,2); uv = data(401:$,1); //validation data
//[m] = armax(y,u,3,3,2,2);
//[fit, yp] = valPred(m.a, m.b, m.c, yv, uv);
//plot(yv);
//plot(yp,'-r');
//
// See also
//  arx
//  rarx
//  arIdent
//  validate
//  valPred
//  valSim
//  subid
//  subspaceIdent
//  substruc


  [LHS RHS] = argn(0);
  if (RHS < 5)
    error('Not enough input arguments, at least five arguments are needed: y, u, na, nb, nc');
  end
  if (RHS == 5)
    nk = 0;
  end
  if (RHS == 9)
    error('The covariance matrix P0 of theta0 must be specified.')
  end
  if (RHS <= 8)
    th = zeros(na+nb+nc,1);
    P = 100*eye(size(th,1), size(th,1));
  end
  if (RHS >= 10)
    th = [mtlb_fliplr(-theta0(2:na+1))'; mtlb_fliplr(theta0(na+nk+2:na+nk+nb+1))';...
     mtlb_fliplr(theta0(na+nk+nb+2:$))'];
    P = P0;
  end 
  if (RHS == 11)
    error('An initial estimate of the noise varience vare0 and prediction errors eps0 must be provideed with nu0.')
  end
  if (RHS >= 12)
    nu = nu0;
    nus2 = nu*vare0;
  end
  if (RHS <= 10)
    nu = 0;
    nus2 = nu*4; //vare0 = 4
  end
  if(RHS < 8)
    phi = 1;
  end
  if (RHS < 13)
    eps = zeros(nc,1); 
  else
    eps = eps0;
  end
  
  if (RHS < 7)
    method = 'RLS';
  end

if (RHS == 7) then
      if method ~= 'RLS' & method ~='TLS' & method ~='RTLS' & method ~='SID'
          error('Wrong method name. Use LS, TLS, RTLS or SID...');
          error('Type help armax for more information.');
      end
end
  
  if (size(y,1) ~= size(u,1) | size(y,2) ~= size(u,2))
    error('y and u must be of the same size.')
  end
  if (size(y,1) < size(y,2))
    y = y';
    u = u';
  end
  p = size(y,2);
  m = size(u,2);
  
//-----------------Compute the estimate------------------------

for t = max(na+1, nb+nk) : size(y,1)
    z = [-y(t-na:t-1,1)' u(t-nb-nk+1:t-nk,1)' eps($-nc+1:$,1)']';
    nus2 = nus2 + (y(t) - z'*th)^2/(1 + z'*P*z);
    P = (1/phi) * (P - P*z*z'*P/(1 + z'*P*z));
    th = th + P*z*(y(t)-z'*th);
    nu = nu + 1;
    eps = [eps(2:$);(y(t)-z'*th)];
end
a = [1 mtlb_fliplr(th(1:na)')];
b = [zeros(1,nk) mtlb_fliplr(th(na+1:na+nb)')];
c = [1 mtlb_fliplr(th(na+nb+1:$)')];
thetaInit = [mtlb_fliplr(th(1:na)') mtlb_fliplr(th(na+1:na+nb)') mtlb_fliplr(th(na+nb+1:$)')]';

if (p*m > 1) //MIMO
    A = zeros(p,p,na+1);
    for i = 1:na+1
        A(:,:,i) = a(:,(i-1)*p+1:i*p);
    end
    B = zeros(p,m,nb+nk);
    for i=1:nb+nk
        B(:,:,i) = b(:,(i-1)*m+1:i*m);
    end
    a = A;
    b = B;
end
vare = nus2 / nu;

select method    
    case 'RLS' then
        break;
    case 'TLS' then
        // Experiment
        [fit, yp] = valPred(a, b, c, y, u);
        e = y - yp;
        N = size(y,1);
        FI = zeros(N-max(na+1,nb+nk)+1, na+nb);
        for q = 1:na
            i = na-q+1;
            FI(:, (i-1)+1 : i) = -y(max([na,nb+nk-1,nc])-i+1 : N-i,:);
        end
        for q = 1:nb
            i = nb-q+1;
            FI(:, (i-1)+1+na : i+na) = u(max([na,nb+nk-1,nc])-i-nk+2 : N-i-nk+1,:);
        end
        for q = 1:nc
            i = nc-q+1;
            FI(:, (i-1)+1+na+nb : i+na+nb) = e(max([na,nb+nk-1,nc])-i-nk+2 : N-i-nk+1,:);
        end
        theta = tls(FI, y(max(na+1,nb+nk,nc+1):$,:));   
        a = [eye(p,p) theta(1:p*na,:)'];
        b = [zeros(p,nk*m) theta(p*na+1:na+nb,:)'];
        c = [eye(p,p) theta(p*na+nb+1:$,:)'];
        if (p*m > 1) // MIMO
            A = zeros(p,p,na+1);
            for i = 1:na+1
                A(:,:,i) = a(:,(i-1)*p+1:i*p);
            end
            B = zeros(p,m,nb+nk);
            for i=1:nb+nk
                B(:,:,i) = b(:,(i-1)*m+1:i*m);
            end
            a = A;
            b = B;
        end
    case 'RTLS' then
        // Experiment
        [fit, yp] = valPred(a, b, c, y, u);
        e = y - yp;
        N = size(y,1);
        FI = zeros(N-max(na+1,nb+nk)+1, na+nb);
        for q = 1:na
            i = na-q+1;
            FI(:, (i-1)+1 : i) = -y(max([na,nb+nk-1,nc])-i+1 : N-i,:);
        end
        for q = 1:nb
            i = nb-q+1;
            FI(:, (i-1)+1+na : i+na) = u(max([na,nb+nk-1,nc])-i-nk+2 : N-i-nk+1,:);
        end
        for q = 1:nc
            i = nc-q+1;
            FI(:, (i-1)+1+na+nb : i+na+nb) = e(max([na,nb+nk-1,nc])-i-nk+2 : N-i-nk+1,:);
        end
        
        L = 1*eye(size(FI,2),size(FI,2));
        delta = 0.8;
        tau = 1;
        theta = rtls(FI, y(max(na+1,nb+nk,nc+1):$,:),thetaInit,delta,tau,L);   
        
        a = [eye(p,p) theta(1:p*na,:)'];
        b = [zeros(p,nk*m) theta(p*na+1:na+nb,:)'];
        c = [eye(p,p) theta(p*na+nb+1:$,:)'];
        if (p*m > 1) // MIMO
            A = zeros(p,p,na+1);
            for i = 1:na+1
                A(:,:,i) = a(:,(i-1)*p+1:i*p);
            end
            B = zeros(p,m,nb+nk);
            for i=1:nb+nk
                B(:,:,i) = b(:,(i-1)*m+1:i*m);
            end
            a = A;
            b = B;
        end
    case 'SID' then
        m = substruc(y,u,10,na,nb,nc,nk); // prediciton horizon i=10
        a = m.a;
        b = m.b;
        c = m.c;
end

m = idmodel();
m.a = a;
m.b = b;
m.c = c;
m.vare = vare;
m.P = P;
m.algorithm = method;
m.na = na;
m.nb = nb;
m.nc = nc;
m.nk = nk;

endfunction
 


 
