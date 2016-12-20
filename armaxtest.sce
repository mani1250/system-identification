loadmatfile('Armaxsim.mat')
z1 =  Armaxsim(1:1533,1) //training set
z2 = Armaxsim(1:1533,2) // Training set
z = [z1 z2];
mod_armax <- armax1(z,1,2,1,2)
mod_armax
