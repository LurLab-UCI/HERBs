function    process_wrong_spout(app)
global correct_L correct_R bias_ptr  reward_spout;
global wrong_spout sdata;
global new_trial_started;
global incorrect_count_L incorrect_count_R;

if new_trial_started % only do 1st time after trial start
    if reward_spout == 0  %left
        incorrect_count_L = incorrect_count_L + 1;
    else
        incorrect_count_R = incorrect_count_R + 1;
    end
end
new_trial_started = 0;

wrong_spout = 1;  % to be used later for ssd and tcsa

no_punish = get_no_punish_condition(app);
fprintf('%3.3f   -wrong spout--    no_punish = %d\n',toc,no_punish);

if app.RateDiscrimination.Value
    
    if no_punish
           to_state_3_5(app,0);  % no punishment, no reward, retrial
    else
           to_state_3_5(app,1);  % punishment and retrial
    end
    
else

    if app.light2.Value == 0                  % if in 6 panel mode
           if app.retrial_mode.Value == 0           % not retrial
                   if app.wrong_lick_punishment.Value        % punishment active
                           if no_punish   % if no punish on test panels
                               to_state_4(app);                                 % no punishment, no reward, new trial
                           else                                                                         % if punish on test panels
                               to_state_3_5(app,1);  % punishment, go to new trial
                           end
                   else                                             % punishment not active
%                            to_state_1(app);     % new trial
                           to_state_0(app);     % new trial
                   end
           else                                                 % in retrial mode
                   if app.wrong_lick_punishment.Value            % punishment active
                       if no_punish          % if no punish on test panels
                               to_state_4(app);                                 % no punishment, no reward, new trial
                       else                                                                         % if punish on test panels
                               to_state_3_5(app,1);  % punishment
                       end
                   else                                                 % punishment not active (shouldn't really be used)
                       %                                            to_state_3_5(app,get(app.wrong_lick_punishment,'value')); % do retrial without punishment (only short timeout)
%                        to_state_1(app);  % new trial
                               to_state_3_5(app,0);  % no punishment, no reward, retrial   % mjo 12/4/2020
                   end
           end
    elseif app.light2.Value == 1 && app.retrial_mode.Value == 0 % 2 panel, no retrial mode
           if ~app.wrong_lick_punishment.Value        % if punish not active
                   sdata = [];                                   % keep waiting for correct lick.
           else                                              % in punish active
                   to_state_3_5(app,1);  % punishment
           end
    elseif app.light2.Value == 1 && app.retrial_mode.Value == 1 % 2 panel, retrial mode
           if ~app.wrong_lick_punishment.Value           % if punish not active
               %                                        to_state_4(app);         % no punishment, no reward go to state 1.
               to_state_3_5(app,0);  % no punishment, no reward, retrial
           else
               to_state_3_5(app,1);  % punishment and retrial
           end
    end

    %  wrong  side detected
    if reward_spout == 0  % left
        correct_L(bias_ptr) =    0;
    else
        correct_R(bias_ptr) =    0;
    end
    % bias_ptr =  1 + mod(bias_ptr,bias_buffer_size);
    bias_ptr =  1 + bias_ptr;
end
