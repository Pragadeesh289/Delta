function eqn = calc(t1,t2,tf)
syms t;
eqn = t1 + (3*(t2 - t1)/tf^2)*t^2 - (2*(t2-t1)/tf^3)*t^3;

