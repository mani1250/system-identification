sample_rate=1000;
t = 0:1/sample_rate:0.6;
N=size(t,'*'); //number of samples
s=sin(2*%pi*50*t)+sin(2*%pi*70*t+%pi/4)+grand(1,N,'nor',0,1);
y=fft(s);
