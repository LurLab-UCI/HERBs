function to_state_2(app)
global state rtimer;
global state2_start_time;

state  = '2';
app.statenumber.Text = state;
stop(rtimer);

rtimer.StartDelay = app.wait24.Value;   % GL edit 190903: wait for GUI set time
start(rtimer);

% state2_start_time = toc;
state2_start_time =  toc;  % forces reward to be given immediately
fprintf('%4.3f to_state_2 \n',toc);
 
