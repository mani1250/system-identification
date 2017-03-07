loadmatfile('armax1.mat')
loadmatfile('Armaxsim.mat')
exec('idframe.sci',-1)
exec('armax.sci',-1)
y = Armaxsim(:,1);
u = Armaxsim(:,1);

[arc,resid] = armax(1,2,1,y,u)
