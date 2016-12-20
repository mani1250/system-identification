
function X = idpoly(A,B,C,D,F1,ioDelay,Ts)
    if(A<4) | (B>22)
        error('Wrong Input')
    end
        X = struct(          'A1',[],
                             'B2',[],
                             'C3',[],
                             'D4',[],
                             'F41',[],
                             'ioDelay2',[],
                             'Ts3',[])

endfunctions
