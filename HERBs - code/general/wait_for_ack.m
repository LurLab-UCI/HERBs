function wait_for_ack()
global arduino sdata;
tic;
while 1
    pause(0.005);
    bav = arduino.BytesAvailable;
%      fprintf('waiting for ack  % 4.3f     bav = %d\n',toc,bav);
     if bav > 0
%           fprintf('waiting for ack  % 4.3f   ---   bav = %d\n',toc,bav);
         sdata = read(arduino,bav,"uint8");    
%          fprintf('%4.3f init  %s \n',toc,sdata);   %GL edit added \n to string
     end
    if ~isempty(sdata)
        if contains(char(sdata),'ack')
            break;
        end
    end
end

