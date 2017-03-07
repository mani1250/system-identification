function plot_idframe(data)
    
    // data is an idframe object
    // This is for SISO System only
    
    time = [0:size(data.Output,'r')];
    subplot(211)
    plot(time,[data.Output]);
    xlabel("Time");
    ylabel("Output ")
    subplot(212)
    plot(time,[data.Input]);
    xlabel("Time");
    ylabel("Input")
    xtitle("Data versus Time")
endfunction
