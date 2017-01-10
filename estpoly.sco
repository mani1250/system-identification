function X = estpoly(sys,fitted,residuals)
    class = 'estpoly';
    X = struct('sys',sys,'fitted',fitted,'resid',residuals,'Class',class)
endfunction
