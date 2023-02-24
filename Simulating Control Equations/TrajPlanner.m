function w = TrajPlanner(x,y,z)
ti = [0,0,0];
t1 = ikdelta(x,y,z);
t2 = ikdelta((x*cosd(120)+y*sind(120)),(-x*sind(120)+y*cosd(120)),z);
t3 = ikdelta((x*cosd(240)+y*sind(240)),(-x*sind(240)+y*cosd(240)),z);
tf = [t1, t2, t3];
eqn1 = cubic(ti(1),tf(1));
eqn2= cubic(ti(2),tf(2));
eqn3 = cubic(ti(3),tf(3));
syms t;
w = transpose([diff(eqn1,t),diff(eqn2,t),diff(eqn3,t)]);

