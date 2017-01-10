function X = idframe(Respons,Freq,Ts)
    X = struct('Response',Response,'Freq',Freq,'Ts',Ts);
    return(X);
endfunction
