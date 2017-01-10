function X = z_reg
a = rand(200,5,'normal');
u = a(:,1:2);
    for(i=31:200)
        X = u(i:i-30,:);
    end
endfunction
