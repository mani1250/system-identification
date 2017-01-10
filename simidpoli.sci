function yk = simidpoli(model,Input,sigma)
    [lhs,rhs] = argn(0)
    if(rhs<3)
        sigma = 0;
    end
    
    if(model.Type == 'arx')
        X = simarx(model,Input,sigma)
    else
        n = size(Input,'r');
        ek = sigma*rand(n,1,'normal')
        den1 = coeff(poly(model.A,'x','coeff')*poly(model.D,'x','coeff'));
        vk = filter(model.C,den1,Input);
        
        L = [zeros(model.ioDelay,1)' model.B];
        den2 = coeff(poly(model.A,'x','coeff')*poly(model.F1,'x','coeff'))
        ufk = filter(L,den2,Input);
        yk = ufk + vk;
    end
    
endfunction

function X = simarx(model,Input,sigma)
    na = length(model.A) - 1;
    nb = length(model.B) - 1;
    nk = model.ioDelay;
    nb1 = nb + nk;
    N = max(na,nb1);
    kk = [model.A(2:length(A)) model.B]
    nrow = na + (nb+1);
    ncol = nrow/length(kk);
    coef = matrix(kk,nrow,ncol);
    
    y = zeros((length(Input)+N),1);
    u = [zeros(N,1);Input];
    ek = sigma.*rand(length(Input),1,'normal');
    for(i = N+1:length(Input))
        for(j = -1:-1:-((length(Input)-N)))
            if(nk==0) then
                v = u(i-0:-1:nb+j)
            else
                v = u(i-nk:-1:nb1+j)
            end
        end
        pause
        ncol = na + (nb+1);
        nrow = length([y(i:-1:na); v])/ncol;
        reg = matrix([-1*y(i:-1:na); v],nrow,ncol);
        y(i) = reg*coef + ek(i-N);
    end
    return(y(N+1:length(Input)));
endfunction
