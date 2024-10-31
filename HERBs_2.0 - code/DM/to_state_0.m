function to_state_0(app)
global state;
global rtimer;
global new_trial_started;
global spout1pos spout2pos;

new_trial_started = 1;
stop(rtimer);

% for ITI
min_iti_time = app.iti_min.Value;
max_iti_time = app.iti_max.Value;
iti_range = max_iti_time - min_iti_time;
% this controls the width of the distribution, larger number means narrower distribution
dist_width_factor = 5;  
mu1 =  1;    
mu1 = iti_range * mu1/dist_width_factor;
flag = 1;
while flag
    r1 = min_iti_time + exprnd(mu1);   % exponential disribution
    if r1 < max_iti_time
        flag = 0;
    end
end
delay = round(1000*r1);
delay = delay/1000;

rtimer.StartDelay = delay;
state = '0';
start(rtimer);
fprintf('%4.3f to_state_0 \n',toc);
fprintf('%4.3f   ITI delay = %4.3f  \n',toc,delay);

fprintf('%4.3f start_of_new_trial\n',toc);

% spouts to rest
fprintf('%4.3f spouts_to_rest \n',toc);
control_spouts(spout1pos.rest,spout2pos.rest,app);


