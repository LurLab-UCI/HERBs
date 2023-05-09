function to_state_3_5(app,flag)
global state rtimer;
global spout1pos spout2pos;
global arduino;
global stimtimer;
global punishment_given;

punishment_given = flag;
state  = '3_5';
app.statenumber.Text = state;
stop(rtimer);
% spouts to rest
control_spouts(spout1pos.rest,spout2pos.rest,app);
rtimer.StartDelay = app.punishment_tone_time.Value ;
start(rtimer);
fprintf('%4.3f to_state_3_5\n',toc);
% stop(stimtimer);
stop_all_stims();
% light_off(0,0,app); 

% only give punishment if punishment_active is true
if flag
%     start noise
% first initialize the audio volume
        vol = app.punishment_volume.Value;
        write(arduino,['a' vol],"uint8");

% 3 for both ch,    2 for noise
        write(arduino,['=' 1 'e' 3 2 40],"uint8");
        fprintf('%4.3f noise_start \n',toc);

%    also give airpuff if value > 0
    if (app.airpuff_duration.Value) > 0
        write(arduino,'d',"uint8");  %r
        fprintf('%4.3f air_puff \n',toc);
    end
end
