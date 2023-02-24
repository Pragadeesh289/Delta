function angles = invKineDelta(x,y,z)
    b = 60;
    l1 = 200;
    l2 = 400;
    e = 30;
    c = (b+x)-e;
    alpha = atand(-z/(c));
    a = sqrt((c)^2 + (-z)^2);
    ab1 = sqrt(l2^2 - y^2);
    beta = acosd((a^2 + l1^2 - ab1^2)/(2*a*l1));
    theta1 = 180-(alpha + beta);
    x2 = x*cosd(120) + y*sind(120);
    y2 = -x*sind(120) + y*cosd(120);
    c = (b+x2)-e;
    alpha = atand(-z/(c));
    a = sqrt((c)^2 + (-z)^2);
    ab1 = sqrt(l2^2 - y2^2);
    beta = acosd((a^2 + l1^2 - ab1^2)/(2*a*l1));
    theta2 = 180-(alpha + beta);
    x3 = x*cosd(240) + y*sind(240);
    y3 = -x*sind(240) + y*cosd(240);
    c = (b+x3)-e;
    alpha = atand(-z/(c));
    a = sqrt((c)^2 + (-z)^2);
    ab1 = sqrt(l2^2 - y3^2);
    beta = acosd((a^2 + l1^2 - ab1^2)/(2*a*l1));
    theta3 = 180-(alpha + beta);
    if theta1>120
        theta1 = theta1 - 180;
    end
    if theta2>120
        theta2 = theta2 - 180;
    end
    if theta3>120
        theta3 = theta3 - 180;
    end
    angles = [theta1 theta2 theta3];
    