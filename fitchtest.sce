exec('arx.sci',-1)
exec('armax.sci',-1)
exec('oe.sci',-1)
exec('fitch.sci',-1)

loadmatfile('Arxsim.mat')
loadmatfile('Armaxsim.mat')
loadmatfile('Oesim.mat')


y = Arxsim(:,1);
u = Arxsim(:,2);
data = [y u ];
na = 1;
nb = 2; 
nk = 1;
[thetaN,covt,nvar,res] = arx(data,na,nb,nk)
y1 = Armaxsim(:,1);
y2 = Oesim(:,1);
Fitch = fitch(y,res)
