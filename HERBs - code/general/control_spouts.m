function control_spouts(s1,s2,app)
global arduino;
global current_servo_position;


switch s1
    case app.sp1rest.Value
        temp1 = 20;
    case app.sp1ext.Value
        temp1 = 40;
    otherwise
        temp1 = 0;
end
switch s2
    case app.sp2rest.Value
        temp2 = 20;
    case app.sp2ext.Value
        temp2 = 40;
    otherwise
        temp2 = 0;
end


if app.servo.Value
    s1 = s1*6;
    s1 = 180 - s1;
    s2 = s2*6;
    temp = 1;
else
    temp = 0;
end


fprintf('%4.3f spouts_%d_%d   \n',toc, (s1),(s2));

write(arduino,['i' char(s1) char(temp1),temp],"uint8"'); % center
write(arduino,['j' char(s2) char(temp2),temp],"uint8"); % sides
current_servo_position = [s1,s2];




