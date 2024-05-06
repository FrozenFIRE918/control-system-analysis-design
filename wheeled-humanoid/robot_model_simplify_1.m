syms theta(t) x(t) phi(t) T(t) Tp(t) N(t) P(t) Nm(t) Pm(t) 
syms Nf g R L Lm l mw mp M Iw Ip Im
%这些参数需要自己测量，惯量可以在SolidWorks里测量
R= 0.075;    %驱动轮半径
L=3;         %摆杆质心到驱动轮轴的距离
Lm = 4;      %摆杆质心到机体转轴的距离
l = 0.009;   %机体质心到其转轴的距离
mw = (0.257 + 0.880) *2 ;    %驱动轮转子质量
mp = 2;      %摆杆质量
M = 10;      %机体质量
Iw = 0.00118;%驱动轮转子转动惯量
Ip = 0.003;  %摆杆绕质心转动惯量
Im = 0.007;  %机体绕质心转动惯量

x_dot2 = diff(x,t,t);

theta_dot2 = diff(theta,t,t);
theta_sin = sin(theta);
theta_cos = cos(theta);
theta_S_dot2 = diff(theta_sin,t,t);
theta_C_dot2 = diff(theta_cos,t,t);

phi_dot2 = diff(phi,t,2);
phi_sin = sin(phi);
phi_cos = cos(phi);
phi_S_dot2 = diff(phi_sin,t,2);
phi_C_dot2 = diff(phi_cos,t,2);

%驱动轮力学方程：
equa1 = x_dot2 == (Nf - N)/mw;
equa2 = x_dot2 == (T-Nf*R)*R/Iw;

%摆杆力学方程：
equa3 = N(t) - Nm(t) == mp*(x_dot2 + L*theta_S_dot2);
equa4 = P(t) - Pm(t) - mp*g == mp*L*theta_C_dot2;
equa5 = Ip*theta_dot2 == (P*L+Pm*Lm)*theta_sin - (N*L+Nm*Lm)*theta_cos-T+Tp;

%机体力学方程：
equa6 = Nm == M*(x_dot2+(L+Lm)*theta_S_dot2-phi_S_dot2);
equa7 = Pm-M*g == M*((L+Lm)*theta_C_dot2+l*phi_C_dot2);
equa8 = Im*phi_dot2 == Tp+Nm*l*phi_cos+Pm*l*phi_sin;

%计算：
equa11 = eliminate([equa1;equa2],Nf);
equa11 = simplify(equa11);

equa12 = eliminate([equa3,equa6],Nm);
equa12 = simplify(equa12);

equa13 = eliminate([equa4;equa7],Pm);
equa13 = simplify(equa13);

equa14 = eliminate([equa11;equa12],N);
EQUA1 = simplify(equa14);%结果1
EQUA1 = collect(EQUA1);
%[A,b]=equationsToMatrix(EQUA1);

equa15 = eliminate([equa13;equa5],P);
equa15 = eliminate([equa15;equa12],N);
equa15 = eliminate([equa15;equa6],Nm);
equa15 = eliminate([equa15;equa7],Pm);
EQUA2 = simplify(equa15);%结果2

EQUA3 = eliminate([equa8;equa6],Nm);
EQUA3 = eliminate([EQUA3;equa7],Pm);
EQUA3 = simplify(EQUA3);%结果3

% EQUA1 = eliminate([])
