function to_wait_for_lick(app)

global state statetimer;
global spout1pos;
global sdata;
global  lick_counter ;
global trial_type;
global arduino;

lick_counter = 0;

fprintf('%4.3f  delay_period expired \n',toc);
% center_spout in
% set  spouts to rest position
spout1pos.ext = app.sp1ext.Value;
spout1pos.rest = app.sp1rest.Value;
% spout2pos.ext = app.sp2ext.Value;
% spout2pos.rest = app.sp2rest.Value;

control_spouts_gonogo(spout1pos.ext,0,app);
stop(statetimer);
% in Go trials give a reward here
if app.free_reward.Value && strcmp(trial_type,'go')
    reward_Callback(app,'C');
end

statetimer.StartDelay = app.response_window.Value;
start(statetimer);
state = 'wait_for_lick';
app.statetext.Text = state; 
fprintf('%4.3f  starting wait_for_lick  \n',toc);
sdata = [];

% response window indicator to HIGH
write(arduino,['o'  1],"uint8");


