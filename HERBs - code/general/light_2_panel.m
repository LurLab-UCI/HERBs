function light_2_panel(app)

global reward_spout;
global lightval;
global light_count;
global vlpair;

        if reward_spout == 0  % left
            lightval = 0;   
            vlpair = [0 5];
            if app.allleds.Value || app.full_panel_training.Value
%                 light_Callback(vlpair(1),4);  % page 4 all leds on
                start_light_sequence(app,vlpair(1),4);  % page 4 all leds on
            else
%                 light_Callback(vlpair(1),vlpair(2));
                start_light_sequence(app,vlpair(1),vlpair(2));
            end
            fprintf('%4.3f light_on_%d_%d \n',toc,0,light_count);
            fprintf('%4.3f Stim_start_L\n',toc);
        else  % right 
%             lightval = 9; 
            lightval = 7; 
            vlpair = [2 5];
            if app.allleds.Value || app.full_panel_training.Value
%                 light_Callback(vlpair(1),4);  % page 4 all leds on
                start_light_sequence(app,vlpair(1),4);  % page 4 all leds on
            else
%                 light_Callback(vlpair(1),vlpair(2));
                start_light_sequence(app,vlpair(1),vlpair(2));
            end
            fprintf('%4.3f light_on_%d_%d \n',toc,7,light_count);  % GL edit change "2" to "lightval"
            fprintf('%4.3f Stim_start_R\n',toc);
        end
