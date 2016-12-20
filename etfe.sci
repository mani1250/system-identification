function X = etfe(data)
    output = data(:,1);
    inn = data(:,2);
    temp = [output inn];
    tempfft = fft(temp);
    freqq = linspace(1,round(size(tempfft,'r')/2),1)/round(size(tempfft,'r')/2)*%pi;
    resp = comdiv(tempfft(:,1),tempfft(:,2))
    X = idfrd(resp(1:round(length(resp)/2)),freq,Ts)
    return(X)
endfunction
