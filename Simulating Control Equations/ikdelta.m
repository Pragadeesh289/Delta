function t = ikdelta(x,y,z)
b = 60;
l1 = 200;
l2 = 400;
e = 30;
c = (b+x)-e;
alpha = atand(-z/(c));
a = sqrt((c)^2 + (-z)^2);
ab1 = sqrt(l2^2 - y^2);
beta = acosd((a^2 + l1^2 - ab1^2)/(2*a*l1));
t = 180-(alpha + beta);
if (t>120)
    t = t-180;
end