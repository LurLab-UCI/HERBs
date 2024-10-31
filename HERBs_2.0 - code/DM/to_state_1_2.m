function to_state_1_2(app)
global state rtimer;
global state12_start_time;
global sdata lick_detected;

state  = '1_2';
app.statenumber.Text = state;
stop(rtimer);

% rtimer.StartDelay = app.time_center_spout_available.Value;
rtimer.StartDelay = get_time_center_spout_available(app);
start(rtimer);

tm = rtimer.StartDelay  - app.tcsa_lick_time_window.Value;
 
 if tm > 0
        licktimer = timer;
        licktimer.ExecutionMode ='singleshot';
        licktimer.TimerFcn = {@clear_licks};
        start(licktimer);
 end

% state2_start_time = toc;
state12_start_time =  toc;  % forces reward to be given immediately
fprintf('%4.3f to_state_1_2 \n',toc);

sdata = [];     %  clear licks
lick_detected = 0;
