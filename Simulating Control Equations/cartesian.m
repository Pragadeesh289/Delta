function pos = cartesian(Seqn1,Seqn2,Seqn3)
H2 = [cosd(120) -sind(120) 0 ; sind(120) cosd(120) 0 ; 0 0 1];
H3 = [cosd(240) -sind(240) 0 ; sind(240) cosd(240) 0 ; 0 0 1];
syms x y z;
pos = [];
for i = 1:20:length(Seqn1)
    C1 = [60+200*cosd(Seqn1(i))-30,0,200*sind(Seqn1(i))];
    C2 = [60+200*cosd(Seqn2(i))-30,0,200*sind(Seqn2(i))];
    C3 = [60+200*cosd(Seqn3(i))-30,0,200*sind(Seqn3(i))];
    C2 = C2*H2;
    C3 = C3*H3;
    eqn1 = (x-C1(1))^2 + (y-C1(2))^2 + (z-C1(3))^2 == 400^2;
    eqn2 = (x-C2(1))^2 + (y-C2(2))^2 + (z-C2(3))^2 == 400^2;
    eqn3 = (x-C3(1))^2 + (y-C3(2))^2 + (z-C3(3))^2 == 400^2;
    S = solve(eqn1,eqn2,eqn3);
    
    angles = [Seqn1(i),Seqn2(i),Seqn3(i)]
    pos = [S.x(2),S.y(2),S.z(2)]
end