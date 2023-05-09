function to_state_5(app)
global state rtimer;

state  = '5';
app.statenumber.Text = state;
stop(rtimer);
rtimer.StartDelay = app.punishment_rest_time.Value -   app.punishment_tone_time.Value;    
start(rtimer);
fprintf('%4.3f to_state_5\n',toc);
