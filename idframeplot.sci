function idframeplot(X)
    data = [X.Output X.Input];
    t = 1:size(X.Output,'r');
    for(i=1:size(X.Output,'c'))
        figure(i)
        plot(t,X.Output(:,i))
        a = gca();
        xtitle("Output Vs Time")
    end
    for(j = 1:size(X.Input,'c'))
        figure(size(X.Output,'c')+j)
        plot(t,X.Input(:,j))
        a = gca();
        xtitle("Input Vs Time")
    end
endfunction
