function [thetaN_arx,covt_arx,nvar,res] = arxc(data,na,nb,nk)
az = max(na,nb+nk-1);
zer = zeros(az,1);
zd = data;
// Zeros appended
zd1(:,1) = [zer; zd(:,1)];
zd1(:,2) = [zer; zd(:,2)];
[r,c] = size(zd1);
t = az+1:r; 
yt = zd1(:,1); ut = zd1(:,2);
yt1 = yt'; ut1 = ut'; // row vector
len1 = length(yt1); 
yt2 = zeros(1,len1-az); ut2 = zeros(1,len1-az); 

// arx(Data,[na nb nk]) 
  for i=1:na
    yt2 = [yt2; -yt1(t-i)];
  end;
  for i=nk:nb+nk-1
    ut2 = [ut2; ut1(t-i)]; 
  end;
[r1,c1] = size(yt2); [r2,c2] = size(ut2);
phit = [yt2(2:r1,:); ut2(2:r2,:)]; 
m1 = phit*phit';
[qm,rm] = qr(m1);
m2 = phit*zd(:,1);
thetaN_arx = inv(rm)*qm'*m2;
// thetaN_arx = inv(m1)*m2;
// thetaN_arx = m1\m2;

[r11,c11] = size(thetaN_arx);
a = thetaN_arx(1:na); b = thetaN_arx(na+1:r11);

// Sum of squared residuals

yhat = phit'*thetaN_arx;
res = zd(:,1) - yhat;
N = length(res);
q = rank(phit);
ssr = res'*res;
sig2 = ssr/(N-q);
nvar = sqrt(sig2);
cov_arx = inv(m1);
covt_arx = diag(cov_arx);
endfunction;
