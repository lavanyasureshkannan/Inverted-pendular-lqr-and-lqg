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
    1/(M*l2)]
Cr= ctrb(A,B)
rank(Cr);
if (rank(Cr) == 6)
    disp("system is controllable")
else
    disp("system is uncontrollable")
end
    %disp("Controllability matrix is");
%Qc= [B A*B A*A*B A*A*A*B A*A*A*A*B A*A*A*A*A*B]
%disp("Determinant of the controllability matrix is");
%disp(simplify(det(Qc)));

