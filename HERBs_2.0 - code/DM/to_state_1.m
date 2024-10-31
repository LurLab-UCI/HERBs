function to_state_1(app)
global state rtimer;
global spout1pos spout2pos;
global lick_countc;
global lick_time_startc;
global rest_pause;
global state3_count;
global scount;
global reward_denied;
global stim_timer_start_delay_active;
global arduino;


stim_timer_start_delay_active = 0;
reward_denied = 0;
state3_count = 0;
% fprintf('%4.3f start_of_new_trial\n',toc);

%                 write 0 to dac C 
write(arduino,['c'   2  0  0 ],"uint8");
state = '1';
app.statenumber.Text = state;
% fprintf('%4.3f spout_C \n',toc);
% control_spouts(spout1pos.rest,spout2pos.rest);
% pause(rest_pause);

fprintf('%4.3f spout_C \n',toc);
control_spouts(spout1pos.ext,spout2pos.rest,app);
stop(rtimer);
pause(0.75);            %added 2/20/2019

% if free reward then give reward to center spout
if app.free_reward.Value
        reward_Callback_dm(app,'C');
end

if (app.state1_timeout.Value) > 2e6
    rtimer.StartDelay = 2e6;
else
    rtimer.StartDelay = app.state1_timeout.Value;
end

start(rtimer);
fprintf('%4.3f to_state_1\n',toc);

lick_countc = 0; lick_time_startc = toc;
scount = scount + 1;
app.state1_count.Text = num2str(scount);


