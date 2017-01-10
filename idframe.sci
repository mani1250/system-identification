function X = idframe(Output,Input,Ts,Unit,Start,End)
    [lhs,rhs] = argn(0)
    n = size(Output,'r');
    if(rhs<4)
        Unit = 'Seconds'
        Start = 0
        End = [];
    end
    if(rhs==6)
        if(End~=null)
            Start = End - Ts*(n-1)
        end
    end

X = struct('Output',Output,'Input',Input,'Ts',Ts,'Unit',Unit,'Start',Start,'End',End)

endfunction



