function X = etfee(data)
    // data is an idframe object 
    dat = [data.Output data.Input];
    tempfft = [fft(dat(:,1)) fft(dat(:,2))]./size(dat,'r');
    a = [1:ceil(size(tempfft,'r')/2)]';
    b = ceil(size(tempfft,'r')/2)*%pi/10;
    Freq = a/b;
    resp = comdiv(tempfft(:,1),tempfft(:,2));
    X = idfrd(Response = resp(1:ceil(length(resp)/2)),Freq = Freq,Ts = data.Ts);
endfunction

function M1 = comdiv(z1,z2)
    mag1 = abs(z1); mag2 = abs(z2);
    phi1 = Arg(z1); phi2 = Arg(z2);
    mag3 = mag1./mag2;
    phi3 = unwep(phi1-phi2);
    M1 = [];
    for(i = 1:size(phi3,'r'))
        [l1,l2] = pol2rect(mag3(i),phi3(i))
        M1 = [M1 ; complex(l1,l2)]
    end
    
endfunction

function mm = Arg(z)
    mm = [];
    for(i=1:size(z,'r'))
        mm = [mm ; atan(imag(z(i)),real(z(i)))];
    end
endfunction

function X1 = unwep(p)
    X1 = p;
    for(i = 2:length(p))
        diffe = p(i) - p(i-1);
        if(diffe > %pi)
            X1(i:$) = X1(i:$) - 2*%pi;
        elseif(diffe < -%pi)
            X1(i:$) = X1(i:$) + 2*%pi;
        end
    end
endfunction
function [m1,m2] = pol2rect(r,th)
    m1 = r*cos(th)
    m2 = m1*tan(th);
endfunction

