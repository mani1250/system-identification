function X = predict(x,data,nahead)
    y = data(:,1);
    u = data = (:,2);
    G = [x.B x.A*x.F1]
    det_sys = filt(G(1),G(2),data)
    exec('typecc',-1)
    
    if(typecc(x)=="oe" | nahead = %inf)
        ypred = det_sys;
    else
        Hden = x.A*x.D;
        Hinv = [x.B x.C]
        filtered = filt(Hinv(1),Hinv(2),(y-det_sys))
        
        if(nahead~=1)
            H = x.C*polyinv(Hden,nahead)
            filtered = filt(H(1),H(2),filtered)
        end
        ypred = y - filtered;
    end
    X = repmat(ypred,)

endfunction
