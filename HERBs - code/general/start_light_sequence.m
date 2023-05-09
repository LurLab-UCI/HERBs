function start_light_sequence(app,vl1,vl2)
global arduino;
global dac_val_table;

ncyc = app.number_of_stim_cycles.Value;
up_ms = round(1000*app.stim_duration.Value);
low_ms =round(1000*(app.stim_cycle_duration.Value - app.stim_duration.Value));

ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);
up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256); 
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 

panel = vl2;
dac_val = dac_val_table(vl1+1,panel+1);

switch vl1
    
    case 0  % left
        write(arduino,['b'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
    case 1 % center
        write(arduino,['&'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
    case 2 % right 
        write(arduino,['+'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
end