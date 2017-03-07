exec('armac1.sci',-1);
process_arx = armac1([1 -0.5],[0 0 0.6 -0.2],1,1,1,0.05);
loadmatfile('Arxsim.mat');
data = [Arxsim(:,1) Arxsim(:,2)];
u = prbs_a(5000,250);
xi = rand(1,5000,'normal');
y = arsimul(process_arx,[u xi]);
z = [y(1:length(u))' u'];
zd = detrend(z,'constant');

// Compute IR for time-delay estimation
exec('cra.sci',-1);
[ir,r,cl_s] = cra(detrend(z,'constant'));

// Time-delay = 2 samples
// Estimate ARX model (assume known orders)
exec('arx.sci',-1);
na = 1; nb = 2; nk = 1;

[theta_arx,cov_arx,nvar,resid] = arx(data,na,nb,nk); 

