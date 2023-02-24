function J = matrix(x,y,z)
l1 = 60; l2 = 200; r = 30;
% t1 = ikdelta(x,y,z);
% t2 = ikdelta((x*cosd(120)+y*sind(120)),(-x*sind(120)+y*cosd(120)),z);
% t3 = ikdelta((x*cosd(240)+y*sind(240)),(-x*sind(240)+y*cosd(240)),z);
angles = invKineDelta(x,y,z);
t1 = pi*angles(1)/180;
t2 = pi*angles(2)/180;
t3 = pi*angles(3)/180;
% row 1 of the Jacobian Matrix
M = x - (l1+l2*cos(t1)-r);
N = y;
O = z - l2*sind(t1);
alpha = -(M*l2*sin(t1)-O*l2*cos(t1));

% row 2 of the Jacobian Matrix 2

P = x + 0.5*(l1+l2*cos(t2)-r);
Q = y + 0.866*(l1+l2*cos(t2)-r);
R = z - l2*sin(t2);
beta = 0.5*P*l2*sin(t2) + 0.866*Q*l2*sin(t2) + R*l2*cos(t2);

% row 3 of the Jacobian Matrix 

S = x + 0.5*(l1+l2*cos(t3)-r);
T = y - 0.866*(l1+l2*cos(t3)-r);
U = z - l2*sin(t3);
gamma = 0.5*S*l2*sin(t3) - 0.866*T*l2*sin(t3) + U*l2*cos(t3);

Jc = [M N O; P Q R; S T U];
Jt = [alpha 0 0; 0 beta 0;0 0 gamma];
J = Jc\Jt;




