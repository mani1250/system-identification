function compare(data,nahead,varargin)
    y = data(:,1);
    [lhs,rhs] = argn(0);
    if(rhs==1) then 
        nahead = 1;
    end
    if(varargin==null)
        error('NO Model Supplied')
    end
    m = size(varargin);
    Y = [];
    for(i=1:m)
        k = predict(varargin(i),data,nahead)
        Y = [Y k];
    end
    t = size(data,'r');
    for(i=1:size(varargin))
        figure(1)
        plot(t,Y(:,i))
    end  
endfunction
