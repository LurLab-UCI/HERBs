function stim_start(~,~,app)

global randtable lightval;
global light_count;
global vlpair arduino;
global randfornext;
global stim_timer_start_delay_active;
global rate;
global rate_tablel;
global  reward_spout;
global difficulty_selected;


stim_timer_start_delay_active = 0;
%  difficulty_selected
% reward_spout
if app.SideDiscrimination.Value  
% side discrimination

    % ------------------------------------------------------
    if app.Light.Value

        %     light mode
        % extra light off here
%         light_Callback(vlpair(1),7);
%         start_light_sequence(app,vlpair(1),7);  ????

%         light_count = light_count + 1;
%         stop(stimtimer_up);
        if app.light2.Value
             light_2_panel(app);
        else
        %     6 panel mode
             if (100*randfornext) < (app.percentage_of_training_trials.Value)
            %         do 2 panel instead of 6 panel
                    light_2_panel( app);
              else
                    vlpair = [randtable(lightval,1),randtable(lightval,2)];
                    if app.allleds.Value
%                         light_Callback(vlpair(1),4);  % page 4 all leds on
                        start_light_sequence(app,vlpair(1),4);  % page 4 all leds on
                    else
%                         light_Callback(vlpair(1),vlpair(2));
                        start_light_sequence(app,vlpair(1),vlpair(2));
                    end
        %             fprintf('%4.3f light_on_%d_%d  \n',toc,lightval,light_count);
                    fprintf('%4.3f  light_on_%d_%d  \n',toc,lightval,light_count);
                    fprintf('%4.3f Stim_start\n',toc);
            end
        end
    % ------------------------------------------------------
    
    else   % audio stim
                  start_audio_sequence(app);
    end

    % ------------------------------------------------------

else    % ===============================================================
%     rate discrimination
%  0 difficulty = training
if reward_spout == 0  % left trial
         volts = difficulty_selected*5;
else  % right trial
         volts = 45 - difficulty_selected*5;
end

% use channel C on the dac 
% fprintf('^^^^^^^^^^^^^^^^ %d    %d\n' ,volts_l, volts_h );
% write(arduino,['c'   8  0  2 ]);

    if ~app.single_panel.Value
            fprintf('%3.3f   stim rates   l = %2.1f   r = %2.1f\n',toc,rate.l ,rate.r);
    end

    if app.Light.Value
           start_light_sequence_rate_disc(app,volts) ;   
    else
           start_audio_sequence_rate_disc(app) ;   
    end
end

