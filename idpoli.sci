function [X]=idpoli(A, B, C, D, F1, ioDelay, Ts)
    [lhs,rhs] = argn(0)
    if(rhs<6)
        ioDelay = 0;
        Ts = 1;
    end
    

    Class = "Idpoly"
    Type = typecheck(A,B,C,D,F1)
    if(Type=="arx")
        printf("Discrete time ARX mod A(z)y(k) = B(z)u(k) + e(k)") // check whether the print os correcty used and also check whether /n is correctly used or not
    elseif(Type=="armax")
        printf("Discrete time ARMAX model: A(z)y(k) = B(z)u(k) + C(z)e(k)") //Again check for the same
    elseif(Type=="oe")
        printf("DIscrete time OE model:r A(k) = B(z)/F(z) u(k) + e(k)")
    elseif(Type=="bj")
        printf("Discrete time Bj model : y(k) = B(z)/F(z) u(k) + C(z)/D(z) e(k)")
    else
        printf("Discrete-time Polynomial mod: A(z) y[k] = B(z)/F(z) u[k] + C(z)/D(z) e[k]")
    end
    mprintf('\n\n')
    // Printing standard error sequence
    if(size(A,'*')>1)
        mprintf("A(q^{-1}) = ")
        for(i=1:size(A,'*'))
            if(i-1==0)
                mprintf('%f',A(i))//disp(F1(i))
            else
                if(A(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(A(i)~=1)
                    mprintf(' %f',abs(A(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    mprintf(' %s',temp)//disp(temp)
                end
            end
        end
    end
    mprintf('\n')

printf("B(q^-1) = ")

for i = 1:size(B,'*')
    if(B(i)>0)
        printf("+")
    else
        printf("-")
    end
    printf(' %f ',B(i))
    printf("q^{-"+string(i+ioDelay-1)+"}")
end
//for(i=1:size(B,'*'))
//    //pause
//    if(i+ioDelay-1==0)
//        mprintf('%f',round(B(i)));
//    else
//        if((ioDelay~=0) & (i==1))
//            if(B(i)>0)
//                printf("+")
//            else
//                printf("-")
//            end
//        else
//            if(B(i)<0) then
//                printf("-")
//            end
//            end
//
//        if abs(B(i))~=1 then
//            printf('%f',B(i))
//            printf("q^{-",i+ioDelay-1,"}")
//        end
//        
//    //end
//end
mprintf('\n')
    if(size(C,'*')>1)
        mprintf("C(q^{-1}) = ")
        for(i=1:size(C,'*'))
            if(i-1==0)
                mprintf('%f',C(i))//disp(F1(i))
            else
                if(C(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(C(i)~=1)
                    mprintf(' %f',abs(C(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    mprintf(' %s',temp)//disp(temp)
                end
            end
        end
    end
    mprintf('\n')
    if(size(D,'*')>1)
        mprintf("D(q^{-1}) = ")
        for(i=1:size(D,'*'))
            if(i-1==0)
                mprintf('%f',D(i))//disp(F1(i))
            else
                if(D(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(D(i)~=1)
                    mprintf(' %f',abs(D(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    mprintf(' %s',temp)//disp(temp)
                end
            end
        end
    end
    mprintf('\n')
    if(size(F1,'*')>1)
        mprintf("F(q^{-1}) = ")
        for(i=1:size(F1,'*'))
            if(i-1==0)
                mprintf('%f',F1(i))//disp(F1(i))
            else
                if(F1(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(F1(i)~=1)
                    mprintf(' %f',abs(F1(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    mprintf(' %s',temp)//disp(temp)
                end
            end
        end
    end
    mprintf('\n')
    X = struct('Type',Type,'Class',Class,'A',A,'B',B,'C',C,'D',D,'F1',F1,'ioDelay',ioDelay,'Ts',Ts)
endfunction
