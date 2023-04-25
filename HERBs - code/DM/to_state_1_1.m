function to_state_1_1(app)
global state rtimer sdata;
global stim_timer_start_delay_active lick_detected light_countc reward_spout;
global retrial;
global number_of_left_trials number_of_right_trials;
global number_of_left_retrials number_of_right_retrials;
global rate;
global correct_count_L  correct_count_R;
global incorrect_count_L incorrect_count_R;

global number_of_trials_L_correct number_of_trials_L_incorrect number_of_retrials_L;
global number_of_trials_R_correct number_of_trials_R_incorrect number_of_retrials_R;
global arduino;
global from_retrial;

state  = '1_1';
app.statenumber.Text = state;
stop(rtimer);
fprintf('%4.3f to_state_1_1 \n',toc);

% stop(stimtimer);
stop_all_stims();

light_countc  = 0;

% only update spout if not retrial  ( instead of retrial mode)
if ~retrial
      
    if app.SideDiscrimination.Value
    %         side discrimination
        reward_spout = get_next_spout(app) ;
    else
    %         rate discrimination
%         if ~app.single_panel.Value
            reward_spout = get_next_rates(app);
%         else
%             reward_spout = get_next_rates_single_panel(app);
%         end
    end
end

% if app.retrial_mode.Value
if ~from_retrial
    if reward_spout == 0 
        number_of_left_trials = number_of_left_trials + 1;
        app.LTrials.Text = num2str(number_of_left_trials);
    else
        number_of_right_trials = number_of_right_trials + 1;
        app.RTrials.Text = num2str(number_of_right_trials);
    end
else  % retrial mode
    if reward_spout == 0 
        number_of_left_retrials = number_of_left_retrials + 1;
        app.LReTrials.Text = num2str(number_of_left_retrials/incorrect_count_L,'%2.1f');
    else
        number_of_right_retrials = number_of_right_retrials + 1;
        app.RReTrials.Text = num2str(number_of_right_retrials/incorrect_count_R,'%2.1f');
    end
end
% else
% 
% 
%     if reward_spout == 0 
%         number_of_left_trials = number_of_left_trials + 1;
%         app.LReTrials.Text = num2str(number_of_left_trials);
%     else
%         number_of_right_trials = number_of_right_trials + 1;
%         app.RReTrials.Text = num2str(number_of_right_trials);
%     end
% end

del = start_stimulus_with_delay(app);
tm = del  - app.tcsa_lick_time_window.Value;
 
 if tm > 0
        licktimer = timer;
        licktimer.ExecutionMode ='singleshot';
        licktimer.TimerFcn = {@clear_licks};
        start(licktimer);
 end

stim_timer_start_delay_active = 1;
sdata = [];     %  clear licks
lick_detected = 0;

