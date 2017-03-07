clear;
clc;
Fs = 1000; // Sampling frequency
Fc = 400; // cut-off frequency

w = Fc/(Fs/2); // Normalized frequency
// Design a low pass filter with above mentioned specifications

[b,a] = iir(5,'lp','butt',0.8); // 5th order butterworth LPF
[h,w] = frmag();

figure;
plot(w/%pi*Fs/2,abs(h));
title('frquency response of a 5th order Butterworth LPF');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid;

// Finding the Actual Impulse response of the LPF by applying 

N = 128;
impulse = [1 zeros(1,N)] //  applying an impulse
h = filter();

figure;
subplot(2,1,1)
plot(h/max(h)); // plot the normalized response
title('Acyual impulse Response');

// Using the correlation to find the impulse of the lpf 

for(i=1:128)
    x = rand(1,N,'normal');
    y = filter();   rxy = xcorr(x,y);
    Rxy = fliplr();
    
    PA(:,1) = Rxy;
end
clear Ryx
Ryx = sum(PA')/128;
subplot(2,1,2)
plot(Rxy/max(Ryx));
title('Estimated Impulse Response');
grid;