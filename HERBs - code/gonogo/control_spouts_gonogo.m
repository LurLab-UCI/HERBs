function control_spouts_gonogo(s1,fl,app)
global arduino;

if app.disable_center_spout.Value % if  center disabled the return
    return;
end


if fl == 0  % 0 means center
        %center
            switch s1
            case app.sp1rest.Value
                temp1 = 20;
            case app.sp1ext.Value
                temp1 = 40;
            otherwise
                temp1 = 0;
            end
            
       if app.servo.Value
            s1 = s1*6;
            s1 = 180 - s1;
            temp = 1;
       else    % linear
           temp = 0;
       end
    
        write(arduino,['i' char(s1) char(temp1),temp],"uint8"'); % center
        fprintf('%4.3f spout_C   %3.1f      \n',toc, (s1));

else  % 

       %sides
       switch s1
            case app.sp2rest.Value
                temp1 = 20;
            case app.sp2ext.Value
                temp1 = 40;
            otherwise
                temp1 = 0;
       end
        
       if app.servo.Value
    %         s1 = s1*6;
    %         s1 = 180 - s1;
           s1 = s1*6;
           temp = 1;
       else  % linear
           temp =0;
       end
    
        write(arduino,['j' char(s1) char(temp1),temp],"uint8"'); % center
       
       fprintf('%4.3f spouts_LR   %3.1f      \n',toc, (s1));
end



