// test case for predict
exec('predict.sci',-1);
exec('idpoli.sci',-1);
exec('typecheck.sci',-1);
exec('oe.sci',-1);
loadmatfile('Oesim.mat')
data = Oesim;
[thetaN_oe,covN_oe,nvar,resid] = oe(data,2,1,2);
F1 = [1 thetaN_oe(1)];
B = [thetaN_oe(2) thetaN_oe(3)];
X = idpoli(1,B,1,1,F1,2,1)
//[thetaN,covt,nvar,res] = arx(data,2,1,1)
ypred = predict(X,data,5)

//A = [1 -0.857978782];
//B = [0.8836296 1.0737896];
//
