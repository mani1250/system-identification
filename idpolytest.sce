
exec('idpoli.sci',-1)
exec('typecheck.sci',-1)
 //define output-error model
 B = [0.6,-0.2];
 F1 = [1 -0.5];
 ioDelay = 2;
 Ts = 0.1;
mod_oe = idpoli(1,B,1,1,F1,ioDelay,Ts)
// define box-jenkins model
B1 =  [0.6,-0.2];
C = [1,-0.3];
D =  [1,1.5,0.7];
F2 = [1,-0.5]
ioDelay = 1;
mod_bj =  idpoli(1,B1,C,D,F2,ioDelay)

