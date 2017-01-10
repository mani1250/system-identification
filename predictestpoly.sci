function X = predictestpoly(x,newdata,nahead)
    exec('idframe.sci',-1);
    exec('predict.sci',-1);
    [lhs,rhs] = argn(0)
    if(rhs==1)
        newdata = null;
        nahead = 1;
    end
    if(newdata==0 & nahead==1)
        return(x.fitted)
    else
        model = x.sys;
        if(newdata == null)
            y = x.fitted + x.resid;
            u  = x.Input;
            z = idframe(y,u);
        else
            z = newdata;
        end
        predict(model,z,nahead)
    end
endfunction
