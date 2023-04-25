function to_punishment_timeout(app)
global statetimer state lick_detected;
stop(statetimer);

statetimer.StartDelay  = (app.punishment_timeout.Value);
start(statetimer);
state = 'punishment_timeout';
app.statetext.Text = state; 
fprintf('%4.3f starting punishment_timeout    \n',toc);
lick_detected = 0;




