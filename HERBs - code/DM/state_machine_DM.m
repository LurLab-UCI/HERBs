function state_machine_DM(app)

global run;
global state;
global arduino;
global stimtimer
global lick_countc;
global lick_time_startc;
global lick_countl lick_countr;
global lick_time_startl lick_time_startr;
global lick_time_c   lick_time_r lick_time_l;
global reward_spout;
global sdata;
global light_count;
global reward_denied;
global stim_timer_start_delay_active;
global wrong_spout;
global state_timer_timeout;
global lick_detected;
global retrial;
global rate;
global single_panel_rate  boundary_frequency;
global number_of_left_retrials number_of_right_retrials;
global incorrect_count_L incorrect_count_R;
global from_retrial;

retrial = 0;
light_count = 0; % added 9/18/2020
sdata = [];


to_state_0(app);

while run
      app.LReTrials.Text = num2str(number_of_left_retrials/incorrect_count_L,'%2.1f');
      app.RReTrials.Text = num2str(number_of_right_retrials/incorrect_count_R,'%2.1f');
    drawnow;
    switch state
        
        case '0'
            if state_timer_timeout
                to_state_1(app);
            end
% ----------------------------------------------------------------------------------            
        case '1'  % start new trial
            
%         first see if timer expired
            if state_timer_timeout
%                 toc
                if app.timeout_punishment.Value
                   to_state_3_5(app,1);  % punishment and retrial
                end
            
            else
%          if timer not expired  the continue with lick detects
            
                if ~isempty(sdata) && contains(char(sdata),'lcC')
        %                 center lick detected
                    sdata = [];     %  clear sdata
                    lick_countc = lick_countc + 1;
%                     fprintf('lick_count = %d\n',lick_countc);
                   if   (app.lick_count_requirement.Value) == 1
                       process_lick = 1;  % only one lick required
                   else % more than one lick required, check the time and count
                       process_lick = 0;
                       if lick_countc == 1              % first lick
                            lick_time_startc = toc;
                       else  % second or later lick
                            lick_time_c  = toc  - lick_time_startc;
                            lick_time_startc = toc;
                            
                            if lick_time_c > (app.lick_time_requirement.Value)
                                lick_countc = 1; % lick time exceeded, start overt again with count 1
                                fprintf('time ex\n');
                                lick_time_startc = toc;
                            else 
                               if  lick_countc >=  (app.lick_count_requirement.Value)
                                    process_lick = 1; %  enough licks detected within the time
                               end
                            end
                       end
                   end

                  if process_lick
%                     give immediate reward  if not disabled
                        if ~app.first_lick_no_reward.Value
                            if  rand < app.percentage_of_center_rewards.Value/100
                                reward_Callback(app,'C');
                            end
                        end
                        to_state_1_1(app);
                  end
                end  
            end
% ----------------------------------------------------------------------------------            
            
        case '1_1'
        
%             see if SSD expired
            if  stim_timer_start_delay_active == 0 % check this logic mjo 12/4/2020
%                 timer expired, only give reward if SSD was variable
                   if  lick_detected &&  app.Variable_SSD.Value && app.tcsa_reward.Value
                            reward_Callback(app,'C');
                   end
                   to_state_1_2(app);
            end
%             monitor licks while waiting
            if ~isempty(sdata)
                if contains(char(sdata),'lcC')
                    lick_detected = 1;
                end
            end
% ----------------------------------------------------------------------------------            
            
        case '1_2'
        
%             wait for timer to run out before proceeding to next state
%                 only give reward if TCSA was variable and tcsa_no_reward
%                 is not active
            if state_timer_timeout
%                  timer expired, 
                   if  lick_detected &&  app.Variable_TCSA.Value && app.tcsa_reward.Value
                            reward_Callback(app,'C');
                   end
                   
%                    if retrial skip state 2 and go directly to state 3
                   if retrial
                        to_state_3(app);
                   else
                        to_state_2(app);
                   end
            end
%             monitor licks while waiting
            if ~isempty(sdata)
                if contains(char(sdata),'lcC')
                    lick_detected = 1;
                end
            end
           
% ----------------------------------------------------------------------------------            
            
        case '2'
%             wait for timer to run out before proceeding to next state
            if state_timer_timeout
%                 timer expired,
                 to_state_3(app);
            end
            
%--------------------------------------------------------------------------------            
        case '3'      % L and R spouts are available
%         first see if timer expired
            if state_timer_timeout
%                 timer expired,
                no_punish = get_no_punish_condition(app);
                if app.retrial_mode.Value
                    to_state_3_5(app,1);  % punishment
                else
                    if app.timeout_punishment.Value
                        %  if no_test_punishment avtive and one of 6 mode panel then return
                        if no_punish 
                            to_state_4(app); % no punishment, no reward.
                        else
                            to_state_3_5(app,1);  % punishment
                        end
                    else % no punishment
                        to_state_4(app); % no punishment, no reward.
                    end
                end
            else
            
    %          if timer not expired  the contiue with lick detects

                wrong_spout = 0;  % to be used later for ssd and tcsa

                if ~isempty(sdata)  &&  contains(char(sdata),'lc') && stim_timer_start_delay_active
%                     if lick detected during stim start delay period  then
%                     wrong spout
%                     wrong_spout(app);
%                     if get(stimtimer,'running')
%                         stop(stimtimer);
                        stop_all_stims();

%                     end
%                     to_state_1(app);
                    to_state_0(app);
                      
                elseif ~isempty(sdata) && contains(char(sdata),'lcR')
    %                  right lick detected
                    sdata = [];     %  clear sdata
                    lick_countr = lick_countr + 1;
                   if   (app.lick_count_requirement.Value) == 1
                       process_lick = 1;  % only one lick required
                   else % more than one lick required, check the time and count
                       process_lick = 0;
                       if lick_countr == 1              % first lick
                            lick_time_startr = toc;
                       else  % second or later lick
                            lick_time_r  = toc  - lick_time_startr;
                            lick_time_startr = toc;
                            
                            if lick_time_r > (app.lick_time_requirement.Value)
                                lick_countr = 1; % lick time exceeded, start overt again with count 1
                                lick_time_startr = toc;
                            else 
                               if  lick_countr >=  (app.lick_count_requirement.Value)
                                    process_lick = 1; %  enough licks detected within the time
                               end
                            end
                       end
                   end

% --------------------------------------------------
                           if  process_lick
                                                             
                               if app.SideDiscrimination.Value
%                                    Side Discrimination
                                       if reward_spout == 1     % correct spout
                                           to_state_4(app);
                                           reward_Callback(app,'R');
                                       else
                                           % wrong spout
                                            process_wrong_spout(app);
                                       end
                                       sdata = [];
                               else
%                                    Rate Discrimination
                                    if ~app.single_panel.Value
                                            if  (app.higher_rate_correct.Value &&  (rate.r > rate.l)) || (~app.higher_rate_correct.Value &&  (rate.r < rate.l))
            %                                     correct side
                                               to_state_4(app);
                                               reward_Callback(app,'R');
                                            else
            %                                     wrong side
                                                process_wrong_spout(app);
                                            end
                                    else  % single panel mode
                                            if  (app.higher_rate_correct.Value &&  (single_panel_rate > boundary_frequency)) || (~app.higher_rate_correct.Value &&  (single_panel_rate<boundary_frequency))
            %                                     correct side
                                               to_state_4(app);
                                               reward_Callback(app,'R');
                                            else
            %                                     wrong side
                                                process_wrong_spout(app);
                                            end
                                    end
                               end
                           end
% --------------------------------------------------
               elseif  ~isempty(sdata) && contains(char(sdata),'lcL')
    %                  left lick detected
                        sdata = [];     %  clear sdata
                        lick_countl = lick_countl + 1;
                       if   (app.lick_count_requirement.Value) == 1
                           process_lick = 1;  % only one lick required
                       else % more than one lick required, check the time and count
                           process_lick = 0;
                           if lick_countl == 1              % first lick
                                lick_time_startl = toc;
                           else  % second or later lick
                                lick_time_l  = toc  - lick_time_startl;
                                lick_time_startl = toc;

                                if lick_time_l > (app.lick_time_requirement.Value)
                                    lick_countl = 1; % lick time exceeded, start over again with count 1
                                    lick_time_startl = toc;
                                else 
                                   if  lick_countl >=  (app.lick_count_requirement.Value)
                                        process_lick = 1; %  enough licks detected within the time
                                   end
                                end
                           end
                       end

                       
% --------------------------------------------------
                           if  process_lick
                                                             
                               if app.SideDiscrimination.Value
%                                    Side Discrimination
                                       if reward_spout == 0     % correct spout
                                           to_state_4(app);
                                           reward_Callback(app,'L');
                                       else
                                           % wrong spout
                                            process_wrong_spout(app);
                                       end
                                       sdata = [];
                                       
                               else
%                                    Rate Discrimination
                                    if ~app.single_panel.Value
                                            if  (app.higher_rate_correct.Value &&  (rate.l > rate.r)) || (~app.higher_rate_correct.Value &&  (rate.r > rate.l))
            %                                     correct
                                               to_state_4(app);
                                               reward_Callback(app,'L');
                                            else
            %                                     wrong side
                                                process_wrong_spout(app);
                                            end
                                    else % single panel mode
                                            if  (app.higher_rate_correct.Value &&  (single_panel_rate < boundary_frequency)) || (~app.higher_rate_correct.Value &&  (single_panel_rate>boundary_frequency))
            %                                     correct
                                               to_state_4(app);
                                               reward_Callback(app,'L');
                                            else
            %                                     wrong side
                                                process_wrong_spout(app);
                                            end
                                    end
                               end
                           end
% --------------------------------------------------

                       
%                            if  process_lick
%                                if reward_spout == 0     % correct spout
%                                    to_state_4(app);
%                                    reward_Callback(app,'L');
%                                else
%                                     % wrong spout
%                                     process_wrong_spout(app);
%                                end
%                                sdata = [];
%                            end
               end
            end
    
% ----------------------------------------------------------------------------------            
            
        case '4'
%             wait for timer to run out before proceeding to next state
            if state_timer_timeout
%                 timer expired,
%                 stop(stimtimer);
                stop_all_stims();
%                 light_off(0,0,app);
%                 to_state_1(app);         
                to_state_0(app);         
            end
    
% ----------------------------------------------------------------------------------            

        case '3_5'
%             wait for timer to run out before proceeding to next state
            
            if state_timer_timeout
%                 timer expired,
%                  write(arduino,'>');  %     stop white noise here
                 write(arduino,['=' 0 'e' 3 0 0],"uint8");
                 fprintf('%4.3f noise_stop  \n',toc);
%                 clear licks
                 sdata = [];
                 to_state_5(app);
            end
            
% ----------------------------------------------------------------------------------            
            
        case '5'
            
%             wait for timer to run out before proceeding to next state
            if state_timer_timeout
%                 timer expired,
%                 punishment rest time expired
%                 clear licks
                 sdata = [];
                 
                 if app.retrial_mode.Value
    %                      retrial mode
                        reward_denied = 1;
                        retrial = 1;    % this is used to bypass state 2
                        from_retrial = 1;
                        to_state_1_1(app);  
                 else    % non retrial mode
%                         to_state_1(app);
                        to_state_0(app);
                 end
            end
% ----------------------------------------------------------------------------------            
    end
end
