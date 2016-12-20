loadmatfile('Arxsim.mat');
data = Arxsim;
model =  arx(data,2,1,1);
model
