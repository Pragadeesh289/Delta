% G-Code Generator
pos = [0 0 0];
gcode = "G91";
plane = -300;
for i=1:4
    in = inputdlg('Enter the co-ordinates, space separated');
    in = in{1};
    coords = str2num(in);
    newpos = invKineDelta(coords(1),coords(2),plane);
    updatepos = newpos - pos;
    code = "G0 X"+num2str(updatepos(1))+" Y"+num2str(updatepos(2))+" Z"+num2str(updatepos(3));
    gcode = [gcode;code];
    pos = newpos;
end
code = "G0 X"+num2str(-pos(1))+" Y"+num2str(-pos(2))+" Z"+num2str(-pos(3));
gcode = [gcode;code];
writematrix(gcode,'gcode.txt');

    