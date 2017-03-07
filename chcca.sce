function X = chcca(A,P,C)
    if(A==%F)
        disp('This is rediculous')
    elseif(P==%F)
        disp('This can be considered')
    elseif(C==%F)
        disp('This has to be stopped immediately')
    end
    M = [];
    u = rand(200,2,'normal');
    for i = 31:200
        A = [u(i:-1:i-30,1);u(i:-1:i-30,2)]
        M = [M A];
    end
    M = M';
    X = M
    return(X)

endfunction

