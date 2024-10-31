function to_punishment_nogo(app)
global statetimer state;
global arduino;
global lick_detected;
global dac_val_audio;

stop(statetimer);
% statetimer.StartDelay  = (app.punishment_timeout.Value);
statetimer.StartDelay  = (app.punishment_duration.Value);
% fprintf('%4.3f starting punishment   \n',toc);
state = 'punishment';
app.statetext.Text = state; 
start(statetimer);


duration =  app.punishment_duration.Value;
ncyc = 1;
up_ms = duration*1000;  %from ms
low_ms = 1;  % only one up cycle
ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);
up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256); 
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 

lick_detected = 0;
switch  app.punishment_signal.Value
    case 'none'
%         do nothing
    case    'visual'
        fprintf('%4.3f starting punishment  \n',toc);

          dac_val = 1;
          panel = 4;
          write(arduino,['&'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");
        
    case 'tone' 
        fprintf('%4.3f starting punishment  \n',toc);
        %         start tone signal here
        write(arduino,'a',"uint8");
        audio_volume = app.punishment_volume.Value;
        write(arduino,audio_volume,"uint8");

        tf = round(str2double(app.punishment_tone_frequency.Value));

        mbank = 1;
        write(arduino,['=' tf],"uint8");  % skip (for frequency)

        write(arduino,['m'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  dac_val_audio.punish],"uint8");
        write(arduino,['n'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  dac_val_audio.punish],"uint8");
        
    case 'noise'
        fprintf('%4.3f starting punishment    \n',toc);
%          start noise  signal here
        
        write(arduino,'a',"uint8");
        audio_volume = app.punishment_volume.Value;
        write(arduino,audio_volume,"uint8");

%         tf = round(str2double(app.punishment_tone.Value));
        tf = 1;

        mbank = 2;
        write(arduino,['=' tf],"uint8");  % skip (for frequency)

        write(arduino,['m'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  dac_val_audio.punish],"uint8");
        write(arduino,['n'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  dac_val_audio.punish],"uint8");
end
        
