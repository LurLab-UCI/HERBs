function state_machine(app)

global run;
global state;
global state_timer_timeout
global statetimer;
global sdata spout1pos;
global trial_type;
global next_trial_type;
global false_alarm_count hit_count correct_reject_count  miss_count;
global lick_counter licktimer lick_detected;
global outcome;
global arduino;
global no_response_timer;


statetimer = timer;
statetimer.ExecutionMode ='singleshot';
statetimer.TimerFcn = {@new_state};
statetimer.StartFcn = {@clr_timeout};

licktimer = timer;
licktimer.ExecutionMode ='singleshot';
licktimer.TimerFcn = {@clear_licks_gonogo};
licktimer.StartDelay = app.lick_time.Value;

if isvalid(no_response_timer)
    stop(no_response_timer);
    no_response_timer.StartDelay = app.max_window_of_no_responses.Value;
    start(no_response_timer);
else
    clear no_response_timer;
    no_response_timer = timer;
    no_response_timer.ExecutionMode ='singleshot';
    no_response_timer.TimerFcn = {@stop_gonogo,app};
    no_response_timer.StartDelay = app.max_window_of_no_responses.Value;
    start(no_response_timer);
end

fprintf('%4.3f starting  no_response timer \n',toc);
outcome = '';

to_new_trial(app);
tic;

% fprintf('%4.3f starting  stim_start_delay \n',toc);

run = 1;
while run
    drawnow;

%     monitor lics

% if lick detected outside wait_for_lick and iti go to iti
if lick_detected 
%         check no_response_timer
       if isvalid(no_response_timer)
            stop(no_response_timer);
            start(no_response_timer);
            fprintf('%4.3f starting  no_response timer \n',toc);
            lick_detected = 0;
       end        
        if  ~strcmp(state,'wait_for_lick') %  && ~strcmp(state,'punishment')
%     do only if  early_lick_reset active
            if app.early_lick_reset.Value && ~strcmp(state,'wait_after_lick')
                 to_iti_long(app);
            end
        end
end
    
% no_response_timer
    switch state
% =======================        
        case 'stim_start_delay'
            if state_timer_timeout
                    to_delay_period(app);
            end

% =======================        
        case 'delay_period' 
            if state_timer_timeout
                to_wait_for_lick(app);
            end
     
% =======================        
        case 'wait_for_lick' 
            if state_timer_timeout
%                timeout
%               no lick detected within the response window
                   stop(licktimer);
                   control_spouts_gonogo(spout1pos.rest,0,app);
                    % response window indicator to LOW
                    write(arduino,['o'  0],"uint8");

                switch trial_type
                        case 'go'
%                               2.	MISS = Go trial, did not lick in response window -> no reward, ITI, new trial 
                                    next_trial_type = 'gonogo';
                                    miss_count = miss_count + 1;
                                    app.MISSLabel.Text = ['MISS ' num2str(miss_count)];
                                    fprintf('%4.3f outcome = MISS\n',toc);
                                    to_iti_long(app);
                        case 'nogo'
%                                3.	CORRECT REJECT = no-Go trial, no lick in response window -> no reward, short ITI, next trail must be Go
                                    correct_reject_count = correct_reject_count + 1;
                                    app.CRLabel.Text = ['CR ' num2str(correct_reject_count)];
                                    fprintf('%4.3f outcome = CR\n',toc);
                                    
                                    
                                    if app.cr_rule.Value    % if if cr_rule set do same as before
                                        next_trial_type = 'go';
    %                                  if free reward then no short ITI
                                          if app.free_reward.Value
                                                to_iti_long(app);
                                          else
                                                to_iti_short(app);
                                          end
                                    else  % otherwise
%                                 either go or nogo based on the
%                                 percentage
                                      next_trial_type = 'gonogo';
    %                                  if free reward then no short ITI
                                          if app.free_reward.Value
                                                to_iti_long(app);
                                          else
                                                to_iti_short(app);
                                          end
                                    end
                                    
                        case 'catch'
%                     5.	CATCH = no stimulus, lick / no lick in response window -> no reward, ITI, new trial        
                                    next_trial_type = 'gonogo';
                                     fprintf('%4.3f outcome = CATCH\n',toc);
                                    to_iti_long(app);
                end
                    
            else       % no timeout yet
%             rules operation here
%                 look for a lick
                if ~isempty(sdata) && contains(char(sdata),'lcC')

%               lick detected within the response window
                    sdata = '';
                    lick_counter = lick_counter + 1;
                    
                     if lick_counter >= app.number_of_licks_required.Value
                    
%                         enough licks detected to satisfy the requirement
                            stop(licktimer);
                           % response window indicator to LOW
                             write(arduino,['o'  0],"uint8");
                            
                            switch trial_type
                                case 'go'
        %                                 1.	HIT = Go trial, lick within response window -> reward, ITI, new trial               
%                                             give reward only if free reward not active
                                            if ~app.free_reward.Value
                                                    reward_Callback(app,'C');
                                            end
                                            next_trial_type = 'gonogo';
                                            hit_count = hit_count + 1;
                                            app.HITLabel.Text = ['HIT ' num2str(hit_count)];
%                                             fprintf('lick detected\n');
                                            fprintf('%4.3f outcome = HIT\n',toc);
                                            to_wait_after_lick(app);
                                case 'nogo'
        %                               4.	FALSE ALARM = no-Go trial, lick in response window -> no reward, punishment, ITI, new trial                            
                                            next_trial_type = 'gonogo';
                                            false_alarm_count = false_alarm_count + 1;
                                            app.FALabel.Text = ['FA ' num2str(false_alarm_count)];
                                            control_spouts_gonogo(spout1pos.rest,0,app);
                                            fprintf('%4.3f outcome = FA\n',toc);
%                                             if free reward then no
%                                             punishment but iti
                                            if app.free_reward.Value
                                                to_iti_long(app);
                                            else
                                                to_punishment_nogo(app);
                                            end
                                case 'catch'
        %                               5.	CATCH = no stimulus, lick / no lick in response window -> no reward, ITI, new trial                            
                                            next_trial_type = 'gonogo';
                                            control_spouts_gonogo(spout1pos.rest,0,app);
                                             fprintf('%4.3f outcome = CATCH\n',toc);
                                            to_iti_long(app);
                            end
                     else
%                          not enough licks yet
                                if  lick_counter == 1
    %                                 if first lick start lick timer
                                    start(licktimer);
                                end
                    end
                end
            end
                    
% =======================        
         case 'wait_after_lick'
                    
             if state_timer_timeout
%                  timeout
                     control_spouts_gonogo(spout1pos.rest,0,app);
                     to_iti_long(app);
                end

% =======================        
            case 'punishment'
                if state_timer_timeout
                        to_punishment_timeout(app);
                end
            
% =======================        
            case 'punishment_timeout'
                if state_timer_timeout
%                     iti expired, new trial
                        to_iti_long(app);
                end
            
% =======================        
            case 'iti'
                if state_timer_timeout
%                     iti expired, new trial
                        to_new_trial(app);
                end

    end
    
end



    