function duration = start_audio_sequence_nogo(app)
global arduino ;
global dac_val_audio;

write(arduino,'a',"uint8");
audio_volume = app.audio_volume_nogo.Value;
write(arduino,audio_volume,"uint8");

tf = round(str2double(app.audio_tone_pitch_nogo.Value));

if strfind(app.audio_stimulus_type_nogo.Value,'noise');
     mbank = 2;
else
    mbank = 1;
end
write(arduino,['=' tf],"uint8");  % skip (for frequency)

ncyc = app.audio_stimulation_number_of_pulses_nogo.Value;
up_ms = round(app.audio_stimulation_pulse_width_nogo.Value);
low_ms = up_ms;

duration = (ncyc*(up_ms + low_ms) - low_ms)/1000;

ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);

up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256); 
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 


if app.stimulus_side_left_nogo.Value    
%     case 0  % left + dac val
        write(arduino,['m'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  dac_val_audio.nogo_L],"uint8");
else
%     case 1 % right  + dac val
        write(arduino,['n'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  dac_val_audio.nogo_R],"uint8");
end


