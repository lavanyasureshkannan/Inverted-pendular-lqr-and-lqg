
clear all
clc
output_y = [5; 0; 30; 0; 60; 0]
time = 200:0.01:6000;
[t1,y1] = ode45(@pendulum,time,output_y); 
plot(t1,y1)
grid on

%% Defining doublepend function
function yt = pendulum(t,y)
M=1000;
m1=100;
m2=100;
l1=20;
l2=10;
g=9.81;
A=[0 1 0 0 0 0; 
    0 0 -(m1*g)/M 0 -(m2*g)/M 0;
    0 0 0 1 0 0;
    0 0 -((M+m1)*g)/(M*l1) 0 -(m2*g)/(M*l1) 0;
    0 0 0 0 0 1;
    0 0 -(m1*g)/(M*l2) 0 -(g*(M+m2))/(M*l2) 0];
B=[0; 1/M; 0; 1/(M*l1); 0; 1/(M*l2)];
Q=[1000 0 0 0 0 0;
   0 1000 0 0 0 0;
   0 0 100 0 0 0;
   0 0 0 100 0 0;
   0 0 0 0 100 0;
   0 0 0 0 0 100];
R=1.5;
[K, P, Poles] = lqr(A,B,Q,R);
F=-K*y;
yt=zeros(6,1);
yt(1) = y(2);
yt(2)=(F-(g/2)*(m1*sind(2*y(3))+m2*sind(2*y(5)))-(m1*l1*(y(4)^2)*sind(y(3)))-(m2*l2*(y(6)^2)*sind(y(5))))/(M+m1*((sind(y(3)))^2)+m2*((sind(y(5)))^2));%xDD
yt(3)= y(4); 
yt(4)= (yt(2)*cosd(y(3))-g*(sind(y(3))))/l1';
yt(5)= y(6); 
yt(6)= (yt(2)*cosd(y(5))-g*(sind(y(5))))/l2;
end