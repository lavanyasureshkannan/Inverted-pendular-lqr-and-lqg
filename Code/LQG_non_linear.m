%% Part G(b) - LQG controller Non-Linear Calculations
clc
clear all

state_x = [0;0;30;0;60;0;0;0;0;0;0;0]
time=0:0.1:100;
[t,x] = ode45(@pend_lqg,time,state_x);
plot(t,x)
grid on

function yt = pend_lqg(t,y)
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
R=0.01;
C1 = [1 0 0 0 0 0]; 
D = 0;
k = lqr(A,B,Q,R);
F=-k*y(1:6);

pn=0.3*eye(6);
mn=1;
kk=lqr(A',C1',pn,mn)';

est =(A-kk*C1)*y(7:12);
yt=zeros(12,1);
yt(1) = y(2)
yt(2)=(F-(g/2)*(m1*sind(2*y(3))+m2*sind(2*y(5)))-(m1*l1*(y(4)^2)*sind(y(3)))-(m2*l2*(y(6)^2)*sind(y(5))))/(M+m1*((sind(y(3)))^2)+m2*((sind(y(5)))^2));
yt(3)= y(4);
yt(4)= (yt(2)*cosd(y(3))-g*(sind(y(3))))/l1';
yt(5)= y(6);
yt(6)= (yt(2)*cosd(y(5))-g*(sind(y(5))))/l2;
yt(7)= y(2)-y(10) 
yt(8)= yt(2)-est(2)
yt(9)= y(4)-y(11)
yt(10)= yt(4)-est(4)
yt(11)= y(6)-y(12)
yt(12)= yt(6)-est(6)
end
