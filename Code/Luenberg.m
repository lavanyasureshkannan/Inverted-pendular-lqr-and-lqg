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
poles = [-1;-2;-3; -4; -5; -6];
Q = [1000 0 0 0 0 0 ;
       0 1000 0 0 0 0;
       0 0 100 0 0 0;
       0 0 0 100 0 0;
       0 0 0 0 100 0;
       0 0 0 0 0 100];
R = 0.001;
state_x = [0,0,30,0,60,0,0,0,0,0,0,0]
K= lqr(A,B,Q,R)
C1 = [1 0 0 0 0 0]; 
C3 = [1 0 0 0 0 0; 0 0 0 0 1 0]; 
C4 = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0];
D = 0;
%case 1
L1 = place(A',C1',poles)'
A11 = [(A-B*K) B*K;
        zeros(size(A)) (A-L1*C1)];
B11 = [B;zeros(size(B))];
C11 = [C1 zeros(size(C1))];
sys1 = ss(A11, B11, C11,D);
figure
initial(sys1,state_x)
figure
step(sys1)

%case2
L3 = place(A',C3',poles)'
A33 = [(A-B*K) B*K;
        zeros(size(A)) (A-L3*C3)];
C33 = [C3 zeros(size(C3))];
sys3 = ss(A33, B11, C33,D);
figure 
initial(sys3,state_x)
figure 
step(sys3)

%case3
L4 = place(A',C4',poles)'
A44 = [(A-B*K) B*K;
        zeros(size(A)) (A-L4*C4)];
C44 = [C4 zeros(size(C4))];
sys4 = ss(A44, B11, C44, D);
figure 
initial(sys4,state_x)
figure 
step(sys4)

grid on

