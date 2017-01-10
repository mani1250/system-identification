function X = inpulseest(data,M,K,regul,lambda)
    y = data.Output
    u = data.Input
// Data is an idframe object
    N = size(data.Output,'r');
    X = impulsechannel(y,u,N,M,K,regul,lambda)
endfunction
function X = impulsechannel(y,u,N,M,K,regul,lambda)
    T = [];
    for(i = 31:N)
        for(j = 1:size(u,'c'))
            L  = u(i:-1:i-30,j)
            T = [L T]
        end
    end
     T = T';
     Z = T;
     Y = y(31:N,1)
//     Dealing with regularization
if(regul==%T)

    inner = Z'*Z + lambda*eye(size(Z,'c'),size(Z,'c'));
    pinvv = linsolve(inner,zeros(size(inner,'r'),1))*Z';
    pause
    coefficients = pinvv*Y;
    residuals = Y - Z*coefficients;
end

df = size(Z,'r')-size(Z,'c');
sigma2 = sum(residuals^2)/df
vcov = sigma2*solve(Z'*Z);

se = sqrt(diag(vcov,vcov));
X = struct('coefficients',coefficients,'residuals',residuals,'lags',0:30,'se',se)
endfunction
