function [mse,fpe,fitper,AIC,AICc,nAIC,BIC] = fitch(sys)
    y = fitted(sys) +resid(sys)
    ek = resid(sys)
    N = size(ek,'*');
    np = length(params(sys))
    
//fit characteristic
mse = det(ek'*ek)/N;
fpe = mse*(1+np/N)/(1-np/N);
nrmse = 1 - sqrt(sum(ek^2))/sqrt(sum((y-mean(y))^2));
AIC = N*log(mse) + 2*np +N*size(y(:,2))*(log(2*%pi)+1);
AICc = AIC*2*np*(np+1)/(N-np-1);
nAIC = log(mse) + 2*np/N;
BIC = N*log(mse) + 2*np/N
fitper = nrmse*100

endfunction
