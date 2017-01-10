function [fith] = fitch(y,resid)
    ek = resid;
    N = length(ek);
    np = 3;
    mse = det(ek'*ek)/N;
    fpe = mse*(1+np/N)/(1-np/N);
    nrmse = 1 - sqrt(sum(ek.^2))/sqrt(sum((y-mean(y,'r')).^2));
    AIC = N*log(mse) + 2*np +N*size(y,'c')*(log(2*%pi)+1);
    AICc = AIC*2*np*(np+1)/(N-np-1);
    nAIC = log(mse) + 2*np/N;
    BIC = N*log(mse) + N*size(y,'c')*(log(2*%pi)+1) + np*log(N)
    fitper = nrmse*100
    fith = struct('mse',mse,'fpe',fpe,'fitper',fitper,'BIC',BIC,'AICc',AICc,'nAIC',nAIC);


endfunction

