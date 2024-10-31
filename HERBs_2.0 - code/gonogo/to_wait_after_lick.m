function to_wait_after_lick(app)
global statetimer state lick_detected;
stop(statetimer);
statetimer.StartDelay = app.wait_after_lick_time.Value;
start(statetimer);
state = 'wait_after_lick';
app.statetext.Text = state; 
fprintf('%4.3f starting wait_after_lick  \n',toc);
lick_detected = 0;



