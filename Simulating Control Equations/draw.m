
% This script plots the angular position w.r.t time and cartesain position
% w.r.t time
% The Home position is assumed when the arms parallel to the floor i.e the
% angles are 0 degs. This comes out to be [0,0,-327.24]
% Change the values of x,y and z to plot 
% 'a' is the maximum desired angular acceleration.
a = 0.25;
x = 20; y = 0; z = -327;
angles = invKineDelta(x,y,z); % user-defined function - Find logic below
J = matrix(x,y,z); % user-defined function - Find logic below
tf = sqrt(6*max(angles)/a);
cubic1 = calc(0,angles(1),tf);
cubic2 = calc(0,angles(2),tf);
cubic3 = calc(0,angles(3),tf);
syms t;
dcubic1 = diff(cubic1,t);dcubic2 = diff(cubic2,t);dcubic3 = diff(cubic3,t);
ddcubic1 = diff(dcubic1,t);ddcubic2 = diff(dcubic2,t);ddcubic3 = diff(dcubic3,t);
angpos = [];
angvelo = [];
angacc = [];
time = [0:0.1:tf];
for i=1:length(time)
    angpos = [angpos; subs(cubic1,time(i)), subs(cubic2,time(i)), subs(cubic3,time(i))];
    angvelo = [angvelo;subs(dcubic1,time(i)), subs(dcubic2,time(i)), subs(dcubic3,time(i))];
    angacc = [angacc;subs(ddcubic1,time(i)), subs(ddcubic2,time(i)), subs(ddcubic3,time(i))];
end
angpos = double(angpos);
angvelo = double(angvelo);
angvel = pi*angvelo/180;
angacc = double(angacc);
cartesian = [];
cartesianvel = [];
cartesianacc = [];
H2 = [cosd(120) -sind(120) 0; sind(120) cosd(120) 0;0 0 1];
H3 = [cosd(240) -sind(240) 0; sind(240) cosd(240) 0;0 0 1];
for i=1:length(angvelo)
    v = J*transpose([angvel(i,1),angvel(i,2),angvel(i,3)]);
    cartesianvel = [cartesianvel; transpose(v)];
end

%--------------------------------------------------------------------------
% Do not change beyond this
%--------------------------------------------------------------------------
syms x y z;
for i =1:length(angpos)
    C1 = [60+200*cosd(angpos(i,1))-30, 0, 200*sind(angpos(i,1))];
    C2 = [60+200*cosd(angpos(i,2))-30, 0, 200*sind(angpos(i,2))];
    C3 = [60+200*cosd(angpos(i,3))-30, 0, 200*sind(angpos(i,3))];
    C2 = C2*H2;
    C3 = C3*H3;
    eqn1 = (x-C1(1))^2 + (y-C1(2))^2 + (z-C1(3))^2 == 400^2;
    eqn2 = (x-C2(1))^2 + (y-C2(2))^2 + (z-C2(3))^2 == 400^2;
    eqn3 = (x-C3(1))^2 + (y-C3(2))^2 + (z-C3(3))^2 == 400^2;
    S = solve(eqn1, eqn2, eqn3);
    cartesian = [cartesian; double(-S.x(2)), double(S.y(2)), double(-S.z(2))];
end
p1 = tiledlayout(3,1);
nexttile;

plot(time,angpos(:,1));
nexttile;
plot(time,angpos(:,2));
nexttile
plot(time,angpos(:,3));
figure
p2 = tiledlayout(3,1);
nexttile;
plot(time,angvelo(:,1));
nexttile;
plot(time,angvelo(:,2));
nexttile
plot(time,angvelo(:,3));
figure
p3 = tiledlayout(3,1);
nexttile;
plot(time,angacc(:,1));
nexttile;
plot(time,angacc(:,2));
nexttile
plot(time,angacc(:,3));
figure;
p4 = tiledlayout(3,1);
nexttile;
plot(time,cartesian(:,1));
nexttile;
plot(time,cartesian(:,2));
nexttile
plot(time,cartesian(:,3));
figure;
p5 = tiledlayout(3,1);
nexttile;
plot(time,cartesianvel(:,1));
nexttile;
plot(time,cartesianvel(:,2));
nexttile
plot(time,cartesianvel(:,3));


% User defined functions

% matrix
%--------------------------------------------------------------------------
% function J = matrix(x,y,z)
% l1 = 60; l2 = 200; r = 30;
% % t1 = ikdelta(x,y,z);
% % t2 = ikdelta((x*cosd(120)+y*sind(120)),(-x*sind(120)+y*cosd(120)),z);
% % t3 = ikdelta((x*cosd(240)+y*sind(240)),(-x*sind(240)+y*cosd(240)),z);
% angles = invKineDelta(x,y,z);
% t1 = pi*angles(1)/180;
% t2 = pi*angles(2)/180;
% t3 = pi*angles(3)/180;
% % row 1 of the Jacobian Matrix
% M = x - (l1+l2*cos(t1)-r);
% N = y;
% O = z - l2*sind(t1);
% alpha = -(M*l2*sin(t1)-O*l2*cos(t1));
% 
% % row 2 of the Jacobian Matrix 2
% 
% P = x + 0.5*(l1+l2*cos(t2)-r);
% Q = y + 0.866*(l1+l2*cos(t2)-r);
% R = z - l2*sin(t2);
% beta = 0.5*P*l2*sin(t2) + 0.866*Q*l2*sin(t2) + R*l2*cos(t2);
% 
% % row 3 of the Jacobian Matrix 
% 
% S = x + 0.5*(l1+l2*cos(t3)-r);
% T = y - 0.866*(l1+l2*cos(t3)-r);
% U = z - l2*sin(t3);
% gamma = 0.5*S*l2*sin(t3) - 0.866*T*l2*sin(t3) + U*l2*cos(t3);
% 
% Jc = [M N O; P Q R; S T U];
% Jt = [alpha 0 0; 0 beta 0;0 0 gamma];
% J = Jc\Jt;


%invKineDelta
%--------------------------------------------------------------------------
% function angles = invKineDelta(x,y,z)
%     b = 60;
%     l1 = 200;
%     l2 = 400;
%     e = 30;
%     c = (b+x)-e;
%     alpha = atand(-z/(c));
%     a = sqrt((c)^2 + (-z)^2);
%     ab1 = sqrt(l2^2 - y^2);
%     beta = acosd((a^2 + l1^2 - ab1^2)/(2*a*l1));
%     theta1 = 180-(alpha + beta);
%     x2 = x*cosd(120) + y*sind(120);
%     y2 = -x*sind(120) + y*cosd(120);
%     c = (b+x2)-e;
%     alpha = atand(-z/(c));
%     a = sqrt((c)^2 + (-z)^2);
%     ab1 = sqrt(l2^2 - y2^2);
%     beta = acosd((a^2 + l1^2 - ab1^2)/(2*a*l1));
%     theta2 = 180-(alpha + beta);
%     x3 = x*cosd(240) + y*sind(240);
%     y3 = -x*sind(240) + y*cosd(240);
%     c = (b+x3)-e;
%     alpha = atand(-z/(c));
%     a = sqrt((c)^2 + (-z)^2);
%     ab1 = sqrt(l2^2 - y3^2);
%     beta = acosd((a^2 + l1^2 - ab1^2)/(2*a*l1));
%     theta3 = 180-(alpha + beta);
%     if theta1>120
%         theta1 = theta1 - 180;
%     end
%     if theta2>120
%         theta2 = theta2 - 180;
%     end
%     if theta3>120
%         theta3 = theta3 - 180;
%     end
%     angles = [theta1 theta2 theta3];
    




