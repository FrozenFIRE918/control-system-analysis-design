m= 1.3;
l = 0.001;

A = [0 1;
    0 0];

B = [0 ; 1/(m*l^2)];

C = [1 0 ;0 1];

D = [0; 0];

Q = [1 0; 0 1];
R =1;

states = {'phi' 'phi_dot'};
inputs = {'T'};
outputs = {'phi'; 'phi_dot'};

sys_ss = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);


[K,S,P] = lqr(sys_ss,Q,R);