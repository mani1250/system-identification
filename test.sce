function test(A)
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
endfunction
