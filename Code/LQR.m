clc
clear
%syms M m1 m2 l1 l2 g;
M = 1000;
m1 = 100;
m2 = 100;
l1 = 20;
l2 = 10;
g = 9.8;
A=[0 1 0 0 0 0; 
    0 0 -(m1*g)/M 0 -(m2*g)/M 0;
    0 0 0 1 0 0;
    0 0 -((M+m1)*g)/(M*l1) 0 -(m2*g)/(M*l1) 0;
    0 0 0 0 0 1;
    0 0 -(m1*g)/(M*l2) 0 -(g*(M+m2))/(M*l2) 0];
B=[0;
    1/M;
    0;
    1/(M*l1);
    0;
    1/(M*l2)];
C = eye(6);
D = 0;
%sys = ss(A,B,C,D)
%t = 0:0.1:0.2
%step(sys,t)
state_X = [0;0;30;0;60;0];
Q = [1000 0 0 0 0 0 ;
       0 1000 0 0 0 0;
       0 0 100 0 0 0;
       0 0 0 100 0 0;
       0 0 0 0 100 0;
       0 0 0 0 0 100];
R = 0.001;
sys = ss(A,B,C,D);
initial(sys, state_X)
[k, p, poles] = lqr(A,B,Q,R);
disp(k);
disp(p);
disp(poles);
Ac = A - (B *k);
disp(eig(Ac))
sys1 = ss(A, B, C, D);
initial(sys1, state_X )



