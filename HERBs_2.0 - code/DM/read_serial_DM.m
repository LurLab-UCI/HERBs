function read_serial_DM(obj,~,app)
global sdata lick_detected ack;

sdata = readline(obj);    
fprintf('%4.3f  %s \n',toc,sdata);   %GL edit added \n to string

 if contains(char(sdata),'lcC')
     lick_detected = 1;
  end
 if contains(char(sdata),'ack')
     ack = 1;
  end
