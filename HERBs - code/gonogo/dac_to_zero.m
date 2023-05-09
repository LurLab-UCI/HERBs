function dac_to_zero(a,~,app)

% catch trial dac to zero
global arduino

stop(a);
delete(a);
clear a;

if app.visual_active_go.Value
%                 write 000 to  quad dac ch C
      write(arduino,['c' 2  0 0],"uint8");
else
%                 write 0 to single dac
      write(arduino,['g' 0],"uint8");
end

fprintf('%3.3f  dac to zero\n',toc);

