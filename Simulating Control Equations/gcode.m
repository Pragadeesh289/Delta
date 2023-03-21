% G-Code Generator
gcode = []
for i=1:11
    in = inputdlg('Enter the co-ordinates, space separated');
    in = in{1};
    coords = str2num(in);
    angles = invKineDelta(coords(1),coords(2),coords(3));
    angles = angles*19/360;
    code = "G0 X"+num2str(angles(1))+" Y"+num2str(angles(2))+" Z"+num2str(angles(3))
    gcode = [gcode;code]
    
end

    