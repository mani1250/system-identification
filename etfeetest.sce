clear,clc
loadmatfile('frfdata.mat');
exec('etfee.sci',-1);
exec('idframe.sci',-1);
exec('idfrd.sci',-1);
data = idframe(frfdata(:,1),frfdata(:,2),1);
X = etfee(data)
