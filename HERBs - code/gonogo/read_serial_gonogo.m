function read_serial_gonogo(obj,~)
global sdata lick_detected;

bav = get(obj,'BytesAvailable');
if bav > 0
    sdata = read(obj,bav,"uint8");    
    fprintf('%4.3f  %s \n',toc,sdata);   %GL edit added \n to string
    if contains(char(sdata),'lcC')
         lick_detected = 1;
     end

end