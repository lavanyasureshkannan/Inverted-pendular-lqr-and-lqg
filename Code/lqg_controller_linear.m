
clc
clear all
m1 = 100; 
m2 = 100;
M = 1000; 
l1 = 20; 
l2 = 10; 
g = 9.8; 

A=[0 1 0 0 0 0; 
    0 0 -(m1*g)/M 0 -(m2*g)/M 0;
    0 0 0 1 0 0;
    0 0 -((M+m1)*g)/(M*l1) 0 -(m2*g)/(M*l1) 0;
    0 0 0 0 0 1;
    0 0 -(m1*g)/(M*l2) 0 -(g*(M+m2))/(M*l2) 0];
B=[0; 1/M; 0; 1/(M*l1); 0; 1/(M*l2)];

Q=[100 0 0 0 0 0;
   0 100 0 0 0 0;
   0 0 1000 0 0 0;
   0 0 0 1000 0 0;
   0 0 0 0 1000 0;
   0 0 0 0 0 1000];
R=0.01; 
C1 = [1 0 0 0 0 0]; 
C3 = [1 0 0 0 0 0; 0 0 0 0 1 0]; 
C4 = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0]; 
D = 0; 

state_x = [4;0;30;0;60;0;0;0;0;0;0;0];

K =lqr(A,B,Q,R);
pn=0.5*eye(6); 
mn=1; 


%case1
kk1=lqr(A',C1',pn,mn)';
system1 = ss([(A-B*K) B*K; zeros(size(A)) (A-kk1*C1)], [B;zeros(size(B))],[C1 zeros(size(C1))], D);
figure
initial(system1,state_x)
figure
step(system1)

%case 3
kk3=lqr(A',C3',pn,mn)'; 
system3 = ss([(A-B*K) B*K; zeros(size(A)) (A-kk3*C3)], [B;zeros(size(B))],[C3 zeros(size(C3))], D);
figure
initial(system3,state_x)
figure
step(system3)

%case4
kk4=lqr(A',C4',pn,mn)'; 
system4 = ss([(A-B*K) B*K; zeros(size(A)) (A-kk4*C4)], [B;zeros(size(B))],[C4 zeros(size(C4))], D);
figure
initial(system4,state_x)
figure
step(system4)

grid on

disp(kk1)
disp(kk3)
disp(kk4)