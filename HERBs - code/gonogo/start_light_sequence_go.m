function duration = start_light_sequence_go(app,dac_val)
global arduino;

panel = str2double(app.stimulation_type_visual_go.Value);

ncyc = round(app.stimulation_frequency_visual_go.Value*app.stimulus_duration_visual_go.Value/1000);
up_ms = round(1000/app.stimulation_frequency_visual_go.Value/2);
low_ms = up_ms;

duration = ncyc*(up_ms + low_ms)/1000;

ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);
up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256); 
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 

% dac_val = dac_val_table(vl1+1,panel+1);
% send 1 V to dac C
% dac_val = 10;

panel = 5;
if app.stimulus_side_left_go.Value    
%     case 0  % left
        write(arduino,['b'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
%     case 1 % center
%         write(arduino,['&'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
else
%     case 2 % right 
        write(arduino,['+'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
end