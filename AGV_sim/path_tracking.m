% clear all;close all;clc;

kp = 3;
ki = 0.01;
kd = 30;

v = 10;
dt = 0.01;
L= 3;
curp=[19.339232377031507 52.288246120023786 1.641603752406094];
e = zeros(size(x_ref));
t = 0:0.01:size(x_ref);
% x = 0:0.1:50;
% y = sin(x/5);
x = x_ref;
y = y_ref;
path = [x y];
plot(path(:,1),path(:,2),'r.');
hold on;

intergral = 0;
pre_err =0;
for i=1:length(path)
    
    d = path(:,1:2) - curp(1:2);
    dis = d(:,1).^2 + d(:,2).^2;
    [~,ind] = min(dis);                                     %找路径最近点索引
    
    dx = curp(1) - path(ind,1);
    dy = curp(2) - path(ind,2);
    
    e(i) = (sin(curp(3) - atan2(dy,dx)))*sqrt(dx*dx+dy*dy);    %横向偏差作为测量
     
    intergral = intergral + e(i);
    u = kp*e(i) + ki*intergral + kd*(e(i) - pre_err);             %pid生成控制量，前轮转角
    pre_err = e(i);

    curp(1) = curp(1) + dt*v*cos(curp(3));
    curp(2) = curp(2) + dt*v*sin(curp(3));  
    curp(3) = curp(3) + dt*v*tan(u)/L;
  
    plot(curp(1),curp(2),'g.');
end

%axis equal;