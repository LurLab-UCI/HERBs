function del = start_stimulus_with_delay(app)
global stimtimer arduino;

    % side discrimination
%     stimtimer.TasksToExecute =  app.number_of_stim_cycles.Value;
    stimtimer.StartDelay = get_stim_start_delay(app); % get delay from random buffer or fixed value
%     stimtimer.Period = (app.stim_cycle_duration.Value);
    del = stimtimer.StartDelay ;
    
if app.RateDiscrimination.Value  
    
    stimtimer.TasksToExecute = 1;
    stimtimer.Period = app.stim_duration_rate_disc.Value;

end
    start(stimtimer);
