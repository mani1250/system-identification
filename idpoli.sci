function [Type,Class] = idpoli(A,B,C,D,F1,ioDelay,Ts)


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
    // Printing standard error sequence
    j = 1;
    function print_se(se)
        if(se~=0)
            printf("(+/-",se(j),")")
            j = j + 1;
        end
    endfunction
    
    if(size(A,'*')>1)
        printf("A(q^{-1}) = ")
        for(i=1:size(A,'*'))
            if(i-1==0)
                disp(A(i))
            else
                if(A(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(A(i)~=1)
                    disp(abs(A(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    disp(temp)
                end
            end
        end
    end



printf("B(q^-1) = ")
for(i=1:size(B,'*'))
    if(i+ioDelay-1==0)
        printf("B(i)")
    elseif((ioDelay==0) & (i~=1))
        if(B(i)>0)
            printf("+")
        else
            printf("-")
        end
        if(B(i)<0)
            printf("-")
        end
        if(abs(B(i)==1))
            printf(B(i))
            print_se(se)
            printf("q^{-",i+ioDelay-1,"}")
        end
        
    end
end
    if(size(C,'*')>1)
        printf("C(q^{-1}) = ")
        for(i=1:size(C,'*'))
            if(i-1==0)
                disp(C(i))
            else
                if(C(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(C(i)~=1)
                    disp(abs(C(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    disp(temp)
                end
            end
        end
    end
    if(size(D,'*')>1)
        printf("D(q^{-1}) = ")
        for(i=1:size(D,'*'))
            if(i-1==0)
                disp(D(i))
            else
                if(D(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(D(i)~=1)
                    disp(abs(D(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    disp(temp)
                end
            end
        end
    end

    if(size(F1,'*')>1)
        printf("F(q^{-1}) = ")
        for(i=1:size(F1,'*'))
            if(i-1==0)
                disp(F1(i))
            else
                if(F1(i)>0)
                    printf("+")
                else
                    printf("-")
                end
                if(F1(i)~=1)
                    disp(abs(F1(i)))
                    temp = 'q^{'+string(-(i-1))+'}'
                    disp(temp)
                end
            end
        end
    end
endfunction





