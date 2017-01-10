function X = residplot(y,u,newdata)
    //new data is an idframe object
    [lhs,rhs] = argn(0)
    if(rhs<2) then
        newdata = null;
        ek = resid;
    elseif(rhs==2)
        if(newdata.class~='idframe') then
             error('Only Idframe objects allowed')
         end
         e = newdata.Output - predict(model,newdata)
endfunction
