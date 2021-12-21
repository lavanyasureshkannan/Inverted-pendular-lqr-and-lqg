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

%case1
C1 = [1 0 0 0 0 0];
OB2 = obsv(A,C1);
disp(rank(obsv_mat1));

%case2
C2 = [0 0 1 0 0 0; 0 0 0 0 1 0];
OB2 = obsv(A,C2);
disp(rank(OB2));

%case3
C3 = [1 0 0 0 0 0; 0 0 0 0 1 0];
OB3 = obsv(A,C3);
disp(rank(OB3));

%case4
C4 = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0];
OB4 = obsv(A,C4);
disp(rank(OB4));
