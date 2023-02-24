angles = [];
position = [];
for x=-150:10:150
    for y=-150:10:150
    z = -320;
    position = [position;x y z];
    angles= [angles;invKineDelta(x,y,z)];
    end
end

