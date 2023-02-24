function eqn = cubic(ti,tf)
    syms O(t);
    alpha = 0.5;
    tg = sqrt(6*abs(tf-ti)/alpha);
    if (tg==0)
        O(t) = 0;
    else
        O(t) = ti + 3*(tf-ti)*t^2/tg^2 - 2*(tf-ti)*t^3/tg^3;
    end
    eqn = O(t);
