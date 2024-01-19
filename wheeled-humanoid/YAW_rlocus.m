KP = 800;
KI = 1;
KD = 8;
M = 1.5;%云台质量
L=0.02;%云台重心与YAW轴转动中心的距离

G=tf([KD,KP,KI],[M*L^2,KD, KP, KI]);%云台YAW轴3阶系统传递函数
rlocus(G);