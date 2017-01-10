function ypred = predict(x,data,nahead)
//    x is an idpoly object
    [lhs,rhs] = argn(0);
    if(rhs<3)
        nahead = 1;
    end
    y = data(:,1); // make sure that data has output signal in its first coloumn 
    u = data(:,2); //  make sure that data has input signal in its second colou
    k = x.ioDelay;
    b = [zeros(1,k) x.B];
    a = x.F1;
    G = struct('b',b,'a',a)
    [det_sys,zf] = filter(b,a,u);
    if(x.Type=="oe" | nahead == %inf)
        ypred = det_sys;
    else
        Hden = x.A*x.D;
        Hinv = [Hden x.C]
        [filtered,zf] = filter(Hden,x.C,(y-det_sys));
        if(nahead~=1)
            H = coeff(poly(x.C,'m')*polyinv(Hden,nahead));
            h1 = H(1:nahead);
            [filtered,zf] = filter(h1(1),h1(2),filtered);
        end
        ypred = y - filtered;
    end
endfunction

function X = polyinv(x,k)
    p1 = poly(x,'m','coeff');
    p2 = roots(p1);
    p3 = real(p2)
    p4 = 1./p3;
    z = inverse(p4,k);
    z1 = [];
    for(i = 1 : size(z,'r'))
        z1 = [z1;poly(z(i,:),'x','coeff')];
    end
    temp = z1(1)
    if(length(z1)>1) then
        for(i = 2:length(z1))
            temp = temp*z(i)
        end
    end
    X = temp;
endfunction
function X = inverse(y,k)
    X = [];
    for(i=1:k-1)
        X = [X y.^(i-1)]
    end
endfunction
