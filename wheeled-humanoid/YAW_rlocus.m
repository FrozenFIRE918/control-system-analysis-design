KP = 200;
KI = 0;
KD = 40;
M = 4;%云台质量
L=0.02;%云台重心与YAW轴转动中心的距离

G=tf([KD,KP,KI],[M*L^2,KD, KP, KI]);%云台YAW轴3阶系统传递函数
rlocus(G);