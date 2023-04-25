function read_serial(obj,~)
global sdata;

bav = get(obj,'BytesAvailable');
if bav > 0
    sdata = read(obj,bav,"uint8");    
    fprintf('%4.3f  %s \n',toc,sdata);   %GL edit added \n to string
end