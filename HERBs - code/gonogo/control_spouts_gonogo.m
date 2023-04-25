function control_spouts_gonogo(s1,fl,app)
global arduino;

if app.disable_center_spout.Value % if  center disabled the return
    return;
end


if fl == 0  % 0 means center
        %center
       if app.servo.Value
            s1 = s1*6;
            s1 = 180 - s1;
           write(arduino,['i' char(s1) 1],"uint8"); % center
       else    % linear
           write(arduino,['i' char(s1) 0],"uint8"); % center
       end
        fprintf('%4.3f spout_C   %3.1f      \n',toc, (s1));
else  % 
    %sides
    if app.servo.Value
%         s1 = s1*6;
%         s1 = 180 - s1;
       s1 = s1*6;
       write(arduino,['j' char(s1) 1],"uint8"); % sides
   else  % linear
       write(arduino,['j' char(s1) 0],"uint8"); % sides
   end
   fprintf('%4.3f spouts_LR   %3.1f      \n',toc, (s1));
end



