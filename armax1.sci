function [arc,resid]=armax1(r,s,q,y,u,b0f)
//[arc,resid>=armax1(r,s,q,y,u,[b0f])
//
// Calcule les coefficients d'un ARMAX monodimensionnel
//   A(z^-1)y= B(z^-1)u + D(z^-1)sig*e(t)
//           e(t) est un bruit blanc de variance 1
//           A(z)= 1+a1*z+...+a_r*z^r; ( r=0 => A(z)=1)
//           B(z)= b0+b1*z+...+b_s z^s ( s=-1 => B(z)=0)
//           D(z)= 1+d1*z+...+d_q*z^q  ( q=0 => D(z)=1)

  [lhs,rhs]=argn(0)
  if rhs<=5,b0f=0;end
  if s==-1,b0f=0;end // Seems not natural, but makes things work 
  u=matrix(u,1,-1);y=matrix(y,1,-1); //make u and y row vectors
  [n1,n2]=size(y)
  if size(y,'*')<>size(u,'*') then
    error(msprintf(gettext("%s: Incompatible input arguments #%d and #%d: Same numbers of elements expected.\n"),"armax1",4,5));
  end 
  //
  t0=max(max(r,s+1),1)+1;
  if r<>0;XTM1=y((t0-1):-1:(t0-r));else XTM1=[];end
  if s<>-1;UTM1=u(t0-b0f:-1:(t0-s));else UTM1=[];end
  if q<>0;ETM1=0*ones(1,q);else ETM1=[];end
  npar=r+s+1-b0f+q
  CTM1=0*ones(npar,1);
  ZTM1=[XTM1,UTM1,ETM1]';
  PTM1=10.0*eye(npar,npar);

  for t=t0+1:n2,
    if r<>0;XT=[ y(t-1), XTM1(1:(r-1))];else XT=[];end
    if s<>-1;UT=[ u(t-b0f), UTM1(1:(s-b0f))];else UT=[];end
    eeTM1=y(t-1)- CTM1'*ZTM1;
    if q<>0;ET=[ eeTM1, ETM1(1:(q-1))];else ET=[];end
    ZT=[XT,UT,ET]';
    //
    KT=PTM1*ZT*(1/(1+ ZT'*PTM1*ZT))
    CT=CTM1+KT*(y(t)-ZT'*CTM1)
    PT=PTM1-KT*ZT'*PTM1
    XTM1=XT;UTM1=UT;CTM1=CT;ETM1=ET;ZTM1=ZT;PTM1=PT;
  end
  // On extrait les coefficients a,b,d
  //
  if r<>0;a=[1;-CT(1:r)]';else a=1;end
  if s<>-1;
    if b0f==1,b=[0;CT(r+1:(r+s+1-b0f))]';else
      b=[CT(r+1:(r+s+1-b0f))]';end
      if q<>0;d=[1;CT(r+s+2-b0f:(r+s+q+1-b0f))]';else d=[1];end
  else
    b=0;
    if q<>0;d=[1;CT(r+s+1-b0f:(r+s+q-b0f))]';else d=[1];end
  end
  //On simule pour avoir l'erreur de prediction
  //
  [sig,resid]=epred(r,s,q,CTM1,y,u,b0f);
  arc=armac(a,b,d,1,1,sig);
endfunction



