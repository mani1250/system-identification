function X = etfe(data)
    exec('idfrd.sci',-1);
    tempfft = fft(data)/size(data,'r');
    a = [1:ceil(size(tempfft,'r')/2)]';
    b = ceil(size(tempfft,'r')/2)*%pi;
    Freq = a/b;
    resp = comdiv(tempfft(:,1),tempfft(:,2));
    X = idfrd(response = resp(1:ceil(length(resp)/2)),Freq = Freq,Ts = data.Ts);
endfunction

function comdiv(z1,z2)
    mag1 = abs(z1); mag2 = abs(z2);
    phil = Arg(z1); phi2 = Arg(z2);
endfunction

function L = Arg(z)
    mm = [];
    for(i=1:size(z,'r')
        mm = [atan(imag(z(i)),real(z(i))) ; mm];
    end
    L = mm;
endfunction
