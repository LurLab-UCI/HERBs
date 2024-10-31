function duration = start_light_sequence_nogo(app,dac_val)
global arduino;

ncyc = app.visual_stimulation_number_of_pulses_nogo.Value;
up_ms = round(app.visual_stimulation_pulse_width_nogo.Value);
low_ms = up_ms;

duration = (ncyc*(up_ms + low_ms) - low_ms)/1000;

ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);
up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256);     
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 

% dac_val = dac_val_table(vl1+1,panel+1);
% sen d2 V to dac C
% dac_val = 20;

panel = 6;
if app.stimulus_side_left_nogo.Value    
%     case 0  % left
        write(arduino,['b'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
%     case 1 % center
%         write(arduino,['&'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
else
%     case 2 % right 
        write(arduino,['+'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
end