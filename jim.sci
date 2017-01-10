function plt(varargin)
    X = [];
    for(i=1:size(varargin))
        pause
        X  = [X rand(varargin(i),1,'normal')]
    end
    t = 1:size(varargin(1),'r');
    t= t'
    plot(t,X)
endfunction
