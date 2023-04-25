function to_state_3(app)
global state rtimer;
global spout1pos spout2pos;
global lick_countl lick_countr;
global lick_time_startl lick_time_startr lick_time_start ;
global light_value;
global rest_pause;
global state3_count;
global retrial;
global reward_spout;


light_value = 1;
state = '3';
app.statenumber.Text = state;
fprintf('%4.3f spouts _to_rest \n',toc);
control_spouts(spout1pos.rest,spout2pos.rest,app);
pause(rest_pause);
fprintf('%4.3f spout_LR \n',toc);
control_spouts(spout1pos.rest,spout2pos.ext,app);

% if free reward then give reward to  one of side spouts
if  app.free_reward.Value
    if reward_spout == 0     % left
         reward_Callback( app,'L');
    else % right
         reward_Callback( app,'R');
    end
end

rtimer.StartDelay = app.state3_timeout.Value;
start(rtimer);

state3_count = state3_count + 1;

fprintf(['%4.3f to_state_3_' num2str(state3_count) '\n'],toc);
lick_countl = 0; lick_time_startl = toc;
lick_countr = 0; lick_time_startr = toc;
lick_time_start = toc;

retrial = 0;