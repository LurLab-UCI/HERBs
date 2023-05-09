classdef HERBs_2AFC < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure1                         matlab.ui.Figure
        InputFilePanel                  matlab.ui.container.Panel
        dir_input_file                  matlab.ui.control.Button
        text19_4                        matlab.ui.control.Label
        input_filename                  matlab.ui.control.EditField
        usefile                         matlab.ui.control.CheckBox
        servo                           matlab.ui.control.CheckBox
        linear                          matlab.ui.control.CheckBox
        RReTrials                       matlab.ui.control.Label
        LReTrials                       matlab.ui.control.Label
        text29_11                       matlab.ui.control.Label
        text29_10                       matlab.ui.control.Label
        RCorrect                        matlab.ui.control.Label
        LCorrect                        matlab.ui.control.Label
        RTrials                         matlab.ui.control.Label
        LTrials                         matlab.ui.control.Label
        text29_9                        matlab.ui.control.Label
        text29_8                        matlab.ui.control.Label
        R_lick                          matlab.ui.control.Button
        C_lick                          matlab.ui.control.Button
        L_lick                          matlab.ui.control.Button
        sp2ext                          matlab.ui.control.NumericEditField
        Spout2_ExtLabel                 matlab.ui.control.Label
        sp2rest                         matlab.ui.control.NumericEditField
        Spout2_RestLabel                matlab.ui.control.Label
        sp1ext                          matlab.ui.control.NumericEditField
        Spout1_ExtLabel                 matlab.ui.control.Label
        sp1rest                         matlab.ui.control.NumericEditField
        Spout1_RestLabel                matlab.ui.control.Label
        arates                          matlab.ui.control.Label
        RatesTextArea                   matlab.ui.control.TextArea
        RatesTextAreaLabel              matlab.ui.control.Label
        text29_7                        matlab.ui.control.Label
        text29_4                        matlab.ui.control.Label
        SaveSettingsButton              matlab.ui.control.Button
        LoadSettingsButton              matlab.ui.control.Button
        Panel_General                   matlab.ui.container.Panel
        text19_6                        matlab.ui.control.Label
        text19_5                        matlab.ui.control.Label
        right_first                     matlab.ui.control.CheckBox
        left_first                      matlab.ui.control.CheckBox
        number_of_rights                matlab.ui.control.NumericEditField
        number_of_lefts                 matlab.ui.control.NumericEditField
        forced_sequence                 matlab.ui.control.CheckBox
        percent_retrial_rewards         matlab.ui.control.NumericEditField
        PercentretrialrewardsLabel      matlab.ui.control.Label
        iti_min                         matlab.ui.control.NumericEditField
        iti_max                         matlab.ui.control.NumericEditField
        ITIminmaxsLabel                 matlab.ui.control.Label
        punishment_volume               matlab.ui.control.NumericEditField
        PunishmentVolumeLabel           matlab.ui.control.Label
        biason                          matlab.ui.control.CheckBox
        free_reward                     matlab.ui.control.CheckBox
        retrial_mode                    matlab.ui.control.CheckBox
        bias_diff                       matlab.ui.control.NumericEditField
        BiasCorrdiffLabel               matlab.ui.control.Label
        bias_buffer                     matlab.ui.control.NumericEditField
        BiasCorroftestsLabel            matlab.ui.control.Label
        punishment_rest_time            matlab.ui.control.NumericEditField
        PunishmentRestTimesLabel        matlab.ui.control.Label
        punishment_tone_time            matlab.ui.control.NumericEditField
        PunishmentToneTimesLabel        matlab.ui.control.Label
        airpuff_duration                matlab.ui.control.NumericEditField
        AirPuffmsLabel                  matlab.ui.control.Label
        wrong_lick_punishment           matlab.ui.control.CheckBox
        timeout_punishment              matlab.ui.control.CheckBox
        wait24                          matlab.ui.control.NumericEditField
        Waitbeforestate2or4Label        matlab.ui.control.Label
        text19_2                        matlab.ui.control.Label
        lick_time_requirement           matlab.ui.control.NumericEditField
        LickTimeRequirementLabel        matlab.ui.control.Label
        lick_count_requirement          matlab.ui.control.NumericEditField
        NumberofLicksRequiredLabel      matlab.ui.control.Label
        state3_timeout                  matlab.ui.control.NumericEditField
        State3TimeoutsLabel             matlab.ui.control.Label
        state1_timeout                  matlab.ui.control.NumericEditField
        State1TimeoutsLabel             matlab.ui.control.Label
        ex_duration                     matlab.ui.control.NumericEditField
        ExperimentDurationsLabel        matlab.ui.control.Label
        Panel_DM                        matlab.ui.container.Panel
        full_panel_training             matlab.ui.control.CheckBox
        TonePitchkHzDropDown            matlab.ui.control.DropDown
        TonePitchkHzDropDownLabel       matlab.ui.control.Label
        single_panel                    matlab.ui.control.CheckBox
        no_test_punishment_rd           matlab.ui.control.CheckBox
        mixed_rates                     matlab.ui.control.CheckBox
        two_rates_only                  matlab.ui.control.CheckBox
        number_of_stim_cycles           matlab.ui.control.NumericEditField
        NumberofstimcyclesLabel         matlab.ui.control.Label
        stim_cycle_duration             matlab.ui.control.NumericEditField
        Stim_cycle_durationsLabel       matlab.ui.control.Label
        stim_duration                   matlab.ui.control.NumericEditField
        Stim_durationsLabel             matlab.ui.control.Label
        higher_rate_correct             matlab.ui.control.CheckBox
        stim_duration_rate_disc         matlab.ui.control.NumericEditField
        DurationsLabel                  matlab.ui.control.Label
        low_rate                        matlab.ui.control.NumericEditField
        LowRateHzLabel                  matlab.ui.control.Label
        high_rate                       matlab.ui.control.NumericEditField
        HighRateHzLabel                 matlab.ui.control.Label
        SideDiscrimination              matlab.ui.control.CheckBox
        no_test_punishment              matlab.ui.control.CheckBox
        light8                          matlab.ui.control.CheckBox
        light2                          matlab.ui.control.CheckBox
        RateDiscrimination              matlab.ui.control.CheckBox
        ButtonGroup_DM                  matlab.ui.container.ButtonGroup
        volume                          matlab.ui.control.NumericEditField
        VolumeLabel                     matlab.ui.control.Label
        brightness                      matlab.ui.control.NumericEditField
        BrightnessLabel                 matlab.ui.control.Label
        white_noise                     matlab.ui.control.RadioButton
        tone                            matlab.ui.control.RadioButton
        Light                           matlab.ui.control.RadioButton
        Panel_TDC                       matlab.ui.container.Panel
        PercentageofCenterRewardsLabel  matlab.ui.control.Label
        percentage_of_center_rewards    matlab.ui.control.NumericEditField
        TCSALickTimeWindowsLabel        matlab.ui.control.Label
        tcsa_lick_time_window           matlab.ui.control.NumericEditField
        first_lick_no_reward            matlab.ui.control.CheckBox
        PercentageTrainingTrialsLabel   matlab.ui.control.Label
        percentage_of_training_trials   matlab.ui.control.NumericEditField
        PercentageofRightRewardsLabel   matlab.ui.control.Label
        per_R                           matlab.ui.control.NumericEditField
        override                        matlab.ui.control.CheckBox
        numberofsteps                   matlab.ui.control.NumericEditField
        numberofstepsEditField_2Label   matlab.ui.control.Label
        max_delay                       matlab.ui.control.NumericEditField
        maxsEditField_2Label            matlab.ui.control.Label
        min_delay                       matlab.ui.control.NumericEditField
        minsEditField_2Label            matlab.ui.control.Label
        DelayTableLabel                 matlab.ui.control.Label
        tcsa_reward                     matlab.ui.control.CheckBox
        time_center_spout_available_fixed  matlab.ui.control.NumericEditField
        TimeCenterSpoutAvailableLabel_2  matlab.ui.control.Label
        stim_start_delay_fixed          matlab.ui.control.NumericEditField
        StimStartDelayLabel             matlab.ui.control.Label
        Variable_SSD                    matlab.ui.control.CheckBox
        Variable_TCSA                   matlab.ui.control.CheckBox
        Stable_Delays                   matlab.ui.control.CheckBox
        text29_2                        matlab.ui.control.Label
        time_center_spout_available     matlab.ui.control.NumericEditField
        TimeCenterSpoutAvailableLabel   matlab.ui.control.Label
        stim_start_delay                matlab.ui.control.NumericEditField
        StimStartDelaysLabel            matlab.ui.control.Label
        text19_3                        matlab.ui.control.Label
        fullout                         matlab.ui.control.Button
        torest                          matlab.ui.control.Button
        fullretract                     matlab.ui.control.Button
        spout2_1                        matlab.ui.control.Button
        spout1_1                        matlab.ui.control.Button
        write                           matlab.ui.control.Button
        uipanel5                        matlab.ui.container.Panel
        airpuff                         matlab.ui.control.Button
        uipanel4                        matlab.ui.container.Panel
        allleds                         matlab.ui.control.CheckBox
        test                            matlab.ui.control.Button
        flashc                          matlab.ui.control.Button
        flashr                          matlab.ui.control.Button
        flashl                          matlab.ui.control.Button
        uipanel3                        matlab.ui.container.Panel
        vol_2                           matlab.ui.control.Button
        vol                             matlab.ui.control.Button
        tonel                           matlab.ui.control.Button
        toner                           matlab.ui.control.Button
        uipanel2                        matlab.ui.container.Panel
        reward_pulse_L                  matlab.ui.control.EditField
        reward_pulse_R                  matlab.ui.control.EditField
        reward_pulse_C                  matlab.ui.control.EditField
        text4                           matlab.ui.control.Label
        valveC                          matlab.ui.control.Button
        rewardC                         matlab.ui.control.Button
        rewardR                         matlab.ui.control.Button
        valveL                          matlab.ui.control.Button
        valveR                          matlab.ui.control.Button
        rewardL                         matlab.ui.control.Button
        text36                          matlab.ui.control.Label
        text29                          matlab.ui.control.Label
        state1_count                    matlab.ui.control.Label
        text26                          matlab.ui.control.Label
        notes                           matlab.ui.control.EditField
        dir                             matlab.ui.control.Button
        text19                          matlab.ui.control.Label
        animalid                        matlab.ui.control.EditField
        statenumber                     matlab.ui.control.Label
        start                           matlab.ui.control.Button
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function main_OpeningFcn(app)
            
            
              addpath(genpath(['.' filesep 'general' filesep]));
              addpath(genpath(['.' filesep 'DM' filesep]));
              addpath(genpath(['.' filesep 'SS' filesep]));

              if isfile([pwd filesep 'gui_settings_Decision_Making.mat'])
                    loadStatus(app,[pwd filesep 'gui_settings_Decision_Making.mat']);
              else
                    loadStatus(app,[pwd filesep 'gui_default_settings_Decision_Making.mat']);
              end

              app.figure1.Name = 'HERBs - 2AFC';
              app.start.Visible = 'off';
              init_DM(app);
              app.start.Visible = 'on';
              app.start.Enable = 'on';
              if app.SideDiscrimination.Value
                 update_rates(app); 
              end              

        end

        % Button pushed function: airpuff
        function airpuff_Callback(app, event)
            global arduino;
            
           write(arduino,'d',"uint8");  %r
            fprintf('%4.3f air_puff \n',toc);
        end

        % Callback function
        function airpuff_duration_Callback(app, event)
            global arduino;
            
           write(arduino,['u' round(app.airpuff_duration.Value)],"uint8");
        end

        % Callback function
        function cclock_Callback(app, event)
            global arduino;
            
            if contains(app.cclock.Text,'Start')
               write(arduino,'(',"uint8");
                app.cclock.Text = 'Stop Camera Clock';
            else
               write(arduino,')',"uint8");
                app.cclock.Text = 'Start Camera Clock';
            end
        end

        % Button pushed function: dir
        function dir_Callback(app, event)
            global dirpath;
            if isempty(dirpath)
                dirpath = pwd;
            end
            ddir = uigetdir(dirpath);
            
            app.animalid.Value = [ddir '\'];
        end

        % Button pushed function: flashc
        function flashc_Callback(app, event)
            if app.allleds.Value
                light_Callback(1,4);  % page 4 all leds on
                pause(0.25);
                light_Callback(1,7);
            else
            light_Callback(1,0);
            pause(0.25);
            light_Callback(1,7);  % turn off
            light_Callback(1,1);
            pause(0.25);
            light_Callback(1,7);  % turn off
            end
        end

        % Button pushed function: flashl
        function flashl_Callback(app, event)
            if  app.allleds.Value
                light_Callback(0,5);
                light_Callback(0,4);  % page 4 all leds on
                pause(0.25);
                light_Callback(0,7);
            elseif app.light2.Value
                light_Callback(0,5);
                pause(0.25);
                light_Callback(0,7);
            else
                light_Callback(0,5);
                pause(0.25);
                light_Callback(0,7);  % turn off
                light_Callback(0,0);
                pause(0.25);
                light_Callback(0,7);  % turn off
                light_Callback(0,1);
                pause(0.25);
                light_Callback(0,7);  % turn off
            end
        end

        % Button pushed function: flashr
        function flashr_Callback(app, event)
            if  app.allleds.Value
                light_Callback(2,5);
                light_Callback(2,4);  % page 4 all leds on
                pause(0.25);
                light_Callback(2,7);
            elseif  app.light2.Value
                light_Callback(2,5);
                pause(0.25);
                light_Callback(2,7); % turn off
            else
                light_Callback(2,5);
                pause(0.25);
                light_Callback(2,7); % turn off
                light_Callback(2,1);
                pause(0.25);
                light_Callback(2,7); % turn off
                light_Callback(2,0);
                pause(0.25);
                light_Callback(2,7);  % turn off
            end
        end

        % Button pushed function: fullout
        function fullout_Callback(app, event)
            global spout1pos spout2pos;
            global current_servo_position;
            
            spout1pos.ext = app.sp1ext.Value;
            spout2pos.ext = app.sp2ext.Value;
            spout1pos.rest = app.sp1rest.Value;
            spout2pos.rest = app.sp2rest.Value;
            
            control_spouts(spout1pos.ext,spout2pos.ext,app);
            current_servo_position =  [spout1pos.ext,spout2pos.ext];
        end

        % Button pushed function: fullretract
        function fullretract_Callback(app, event)
            % fully retract both spouts
            global current_servo_position;
            
            control_spouts(0,0,app);
            current_servo_position = [0,0];
        end

        % Value changed function: light2
        function light2_Callback(app, event)
            if app.light2.Value
               app.light2.Value = 1;
               app.light8.Value = 0;
            else
               app.light2.Value = 0;
               app.light8.Value = 1;
            end
        end

        % Value changed function: light8
        function light8_Callback(app, event)
            if app.light8.Value
               app.light2.Value = 0;
               app.light8.Value = 1;
            else
               app.light2.Value = 1;
               app.light8.Value = 0;
            end
        end

        % Callback function
        function per_R_Callback(app, event)
            global arduino;
            
           write(arduino,['w' round(app.reward_pulse_R.Value)],"uint8");
        end

        % Button pushed function: rewardC
        function rewardC_Callback(app, event)
            global arduino
            
           write(arduino,['q' round(str2double(app.reward_pulse_C.Value))],"uint8"); %added by SP 4/28 temp fix
            reward_Callback_dm(app,'C');
        end

        % Button pushed function: rewardL
        function rewardL_Callback(app, event)
            global arduino
            
           write(arduino,['v' round(str2double(app.reward_pulse_L.Value))],"uint8"); %added by SP 4/28 temp fix
            reward_Callback_dm(app,'L');
        end

        % Button pushed function: rewardR
        function rewardR_Callback(app, event)
            global arduino
            
           write(arduino,['v' round(str2double(app.reward_pulse_L.Value))],"uint8"); %added by SP 4/28 temp fix
            reward_Callback_dm(app,'R');

        end

        % Value changed function: reward_pulse_C
        function reward_pulse_C_Callback(app, event)
            global arduino;
            
           write(arduino,['q' round(str2double(app.reward_pulse_C.Value))],"uint8");
        end

        % Value changed function: reward_pulse_L
        function reward_pulse_L_Callback(app, event)
            global arduino;
            
           write(arduino,['v' round(str2double(app.reward_pulse_L.Value))],"uint8");
        end

        % Value changed function: reward_pulse_R
        function reward_pulse_R_Callback(app, event)
            global arduino;
            
           write(arduino,['w' round(str2double(app.reward_pulse_R.Value))],"uint8");
        end

        % Callback function
        function sp1ext_Callback(app, event)
            global spout1pos;
            spout1pos.ext = app.sp1ext.Value;
        end

        % Callback function
        function sp1rest_Callback(app, event)
            global spout1pos;
            spout1pos.rest = app.sp1rest.Value;
        end

        % Callback function
        function sp2ext_Callback(app, event)
            global spout2pos;
            spout2pos.ext = app.sp2ext.Value;
        end

        % Callback function
        function sp2rest_Callback(app, event)
            global spout2pos;
            spout2pos.rest = app.sp2rest.Value;
        end

        % Button pushed function: spout1_1
        function spout1(app, event)
            global spout1pos;
            global s1 s2 current_servo_position;
            
            if contains(app.spout1_1.Text,'Out')
                s1 = spout1pos.ext;
                fprintf('Spout_C to ext at %4.3f\n',toc);
                app.spout1_1.Text = 'Spout C In';
            else
                s1 = spout1pos.rest;
                fprintf('Spout_C to rest at %4.3f\n',toc);
                app.spout1_1.Text = 'Spout C Out';
            end
            s2 = current_servo_position(2);
            control_spouts(s1,s2,app);
            current_servo_position = [s1,s2];
        end

        % Button pushed function: spout2_1
        function spout2(app, event)
            global spout2pos;
            global s1 s2 current_servo_position;
            
            if contains(app.spout2_1.Text,'Out')
                s2 = spout2pos.ext;
                fprintf('Spout_LR to ext at %4.3f\n',toc);
                app.spout2_1.Text = 'Spout LR In';
            else
                s2 = spout2pos.rest;
                fprintf('Spout_LR to rest at %4.3f\n',toc);
                app.spout2_1.Text = 'Spout LR Out';
            end
               s1 = current_servo_position(1);
               control_spouts(s1,s2,app);
               current_servo_position = [s1,s2];
        end

        % Callback function
        function stop_Callback(app, event)
            global run;
            
            run = 0;
        end

        % Button pushed function: test
        function test_Callback(app, event)
            
            % light_Callback(hObject, eventdata, handles,0,7);
            % pause(0.25);
            light_Callback(0,0);
            pause(0.25);
            light_Callback(0,7); % turn off
            light_Callback(0,1);
            pause(0.25);
            light_Callback(0,7); % turn off
            light_Callback(1,0);
            pause(0.25);
             light_Callback(1,7); % turn off
            light_Callback(1,1);
            pause(0.25);
            light_Callback(1,7); % turn off
            light_Callback(2,0);
            pause(0.25);
            light_Callback(2,7); % turn off
            light_Callback(2,1);
            pause(0.25);
            light_Callback(2,7);
        end

        % Button pushed function: tonel
        function tonel_Callback(app, event)
            global arduino;
            
            tf = round(str2double(app.TonePitchkHzDropDown.Value));
            if strfind(app.tonel.Text,'ON') ~= 0
               app.tonel.Text = 'L OFF';
               if app.white_noise.Value
                  write(arduino,['=' tf 'e' 1 2 30],"uint8");
               else
                  write(arduino,['=' tf 'e' 1 1 40],"uint8");
               end
            else
              write(arduino,['=' 1 'e' 1 0 0],"uint8");
                app.tonel.Text = 'L ON';
            end
        end

        % Button pushed function: toner
        function toner_Callback(app, event)
            global arduino;
             tf = round(str2double(app.TonePitchkHzDropDown.Value));
            if strfind(app.toner.Text,'ON') ~= 0
               app.toner.Text = 'R OFF';
               if app.white_noise.Value
                  write(arduino,['=' tf  'e' 2 2 30],"uint8");
               else
                  write(arduino,['=' tf  'e' 2 1 40],"uint8");
               end
            else
              write(arduino,['=' 1 'e' 2 0 0],"uint8");
                app.toner.Text = 'R ON';
            end
        end

        % Button pushed function: torest
        function torest_Callback(app, event)
            global spout1pos spout2pos;
            global current_servo_position;
            % set bit spouts to rest position
            spout1pos.ext = app.sp1ext.Value;
            spout2pos.ext = app.sp2ext.Value;
            spout1pos.rest = app.sp1rest.Value;
            spout2pos.rest = app.sp2rest.Value;
            
            control_spouts(spout1pos.rest,spout2pos.rest,app);
            current_servo_position = [spout1pos.rest,spout2pos.rest];
        end

        % Button pushed function: vol
        function vol_Callback(app, event)
            global arduino;
            global audio_volume;
            
            audio_volume = audio_volume + 1;
            audio_volume = min(audio_volume,63);
           write(arduino,['a' audio_volume],"uint8");
            fprintf('audio volume = %d \n',audio_volume);
            
            
        end

        % Button pushed function: write
        function write_Callback(app, event)
            global notes notestime write_index;
            
            notes{write_index} = app.notes.Value;
            notestime{write_index} = toc;
            
            write_index = write_index + 1;
        end

        % Button pushed function: start
        function startButtonPushed(app, event)
            global run; 

            app.start.Text = 'Start';
            if run
                run = 0;
                return;
            end
                
            app.start.Text = 'Stop';        
            run = 1;                      
            start_Callback(app);

        end

        % Button pushed function: valveL
        function valveLButtonPushed(app, event)
           
            global arduino;
            if contains(app.valveL.Text,'Open')
               write(arduino,['k' 0 1],"uint8");
                app.valveL.Text = 'Close Valve L';
            else
               write(arduino,['k' 0 0],"uint8");
                app.valveL.Text = 'Open Valve L';
            end
            
        end

        % Button pushed function: valveC
        function valveCButtonPushed(app, event)
            
            global arduino;
            if contains(app.valveC.Text,'Open')
               write(arduino,['k' 1 1],"uint8");
                app.valveC.Text = 'Close Valve C';
            else
               write(arduino,['k' 1 0],"uint8");
                app.valveC.Text = 'Open Valve C';
            end
            
        end

        % Button pushed function: valveR
        function valveRButtonPushed(app, event)
            
            global arduino;
            if contains(app.valveR.Text,'Open')
               write(arduino,['k' 2 1],"uint8");
                app.valveR.Text = 'Close Valve R';
            else
               write(arduino,['k' 2 0],"uint8");
                app.valveR.Text = 'Open Valve R';
            end
            
        end

        % Callback function
        function freqValueChanged(app, event)
            global arduino;
            
           write(arduino,['{' round(app.freq.Value)],"uint8");
            
        end

        % Close request function: figure1
        function figure1CloseRequest(app, event)
            % fully retract both spouts
              global current_servo_position;
            
              control_spouts(0,0,app);
              current_servo_position = [0,0];
              saveStatus(app,[pwd filesep 'gui_settings_Decision_Making.mat']);
              delete(app);
%               delete(instrfindall);
            
        end

        % Callback function
        function brightnessValueChanged(app, event)
            global arduino;
            
%            write(arduino,'}');
%            write(arduino,round(app.brightness.Value));
%            write(arduino,0); % do not initialize panels
           write(arduino,['}' round(app.brightness.Value) 0],"uint8"); % do not initialize panels
            
            
        end

        % Button pushed function: vol_2
        function vol_2ButtonPushed(app, event)
            global arduino;
            global audio_volume;
            
%            write(arduino,'a');
            audio_volume = audio_volume - 1;
            audio_volume = max(audio_volume,0);
%            write(arduino,audio_volume);
           write(arduino,['a' audio_volume],"uint8");
            fprintf('audio volume = %d \n',audio_volume);
            
        end

        % Callback function
        function StopButtonPushed(app, event)
            global run;
            run = 0;
        end

        % Callback function
        function DMValueChanged3(app, event)
            app.DM.Value = 1;
            app.SS.Value = 0;
            set_backgrounds(app);
            
        end

        % Callback function
        function SSValueChanged(app, event)
            app.SS.Value = 1;
            app.DM.Value = 0;
            set_backgrounds(app);
            
        end

        % Value changed function: SideDiscrimination
        function SideDiscriminationValueChanged(app, event)
            value = app.SideDiscrimination.Value;
            app.RateDiscrimination.Value = ~value;
            
        end

        % Value changed function: Variable_SSD
        function Variable_SSDValueChanged(app, event)
            app.Variable_SSD.Value = 1;
            app.Variable_TCSA.Value = 0;
            app.Stable_Delays.Value = 0;
            
        end

        % Value changed function: Variable_TCSA
        function Variable_TCSAValueChanged(app, event)
            app.Variable_SSD.Value = 0;
            app.Variable_TCSA.Value = 1;
            app.Stable_Delays.Value = 0;
            
        end

        % Value changed function: RateDiscrimination
        function RateDiscriminationValueChanged(app, event)
            value = app.RateDiscrimination.Value;
            app.SideDiscrimination.Value = ~value;
            update_rates(app); 
        end

        % Button pushed function: SaveSettingsButton
        function SaveSettingsButtonPushed(app, event)
            global settings_path;
            if isempty(settings_path)
                settings_path = pwd;
            end
            [fn,pn,FilterIndex]  = ...
                 uiputfile({'*.mat'},'Input data file',settings_path);
            if (pn ~= 0)
                settings_path = pn;
            else
                 return;
            end
            saveStatus(app,[pn filesep fn]);

        end

        % Button pushed function: LoadSettingsButton
        function LoadSettingsButtonPushed(app, event)
            global settings_path;
            
            [fn,pn,FilterIndex]  = ...
                 uigetfile({'*.mat'},'Input data file',settings_path);
            if (pn ~= 0)
                settings_path = pn;
            else
                 return;
            end
            loadStatus(app,[pn filesep fn]);
            
        end

        % Callback function
        function SmallPanelCheckBoxValueChanged(app, event)
            app.SmallPanelCheckBox.Value = 1;
            app.FullpanelCheckBox.Value = 0;
            app.BarsCheckBox.Value = 0;
        end

        % Callback function
        function FullpanelCheckBoxValueChanged(app, event)
            app.FullpanelCheckBox.Value = 1;
            app.SmallPanelCheckBox.Value = 0;
            app.BarsCheckBox.Value = 0;
        end

        % Callback function
        function BarsCheckBoxValueChanged(app, event)
            app.BarsCheckBox.Value = 1;
            app.SmallPanelCheckBox.Value = 0;
            app.FullpanelCheckBox.Value = 0;

        end

        % Value changed function: Stable_Delays
        function Stable_DelaysValueChanged(app, event)
            app.Variable_SSD.Value = 0;
            app.Variable_TCSA.Value = 0;
            app.Stable_Delays.Value = 1;
            
        end

        % Value changed function: two_rates_only
        function two_rates_onlyValueChanged(app, event)
            app.two_rates_only.Value = 1;
            app.mixed_rates.Value = 0;

        end

        % Value changed function: mixed_rates
        function mixed_ratesValueChanged(app, event)
            app.mixed_rates.Value = 1;
            app.two_rates_only.Value = 0;
            
        end

        % Callback function
        function ButtonPushed(app, event)
            start_stimulus_with_delay(app);
        end

        % Value changed function: brightness
        function brightnessValueChanged2(app, event)
            value = app.brightness.Value;
            global arduino;
            v  = event.Value;
           write(arduino,['}' v 1],"uint8");  % 

            
        end

        % Value changed function: high_rate
        function high_rateValueChanged(app, event)
            value = app.high_rate.Value;   
            update_rates(app);
        end

        % Value changed function: low_rate
        function low_rateValueChanged(app, event)
            value = app.low_rate.Value;
            update_rates(app);            
        end

        % Callback function
        function max_ratioValueChanged(app, event)
            value = app.max_ratio.Value;
            update_rates(app);            
        end

        % Callback function
        function mixed_rates_number_of_stepsValueChanged(app, event)
            value = app.mixed_rates_number_of_steps.Value;
            update_rates(app);            
        end

        % Callback function
        function rate_stepValueChanged(app, event)
            value = app.rate_step.Value;
            update_rates(app);                        
        end

        % Value changed function: single_panel
        function single_panelValueChanged(app, event)
            value = app.single_panel.Value;
           update_rates(app);            
        end

        % Callback function
        function boundary_rateValueChanged(app, event)
            value = app.boundary_rate.Value;
           update_rates(app);                        
        end

        % Callback function
        function logbaseValueChanged(app, event)
            value = app.logbase.Value;
           update_rates(app);                        
        end

        % Button pushed function: L_lick
        function L_lickButtonPushed(app, event)
            global sdata;
            sdata = [108 99 76];
            sdata = char(sdata);
            fprintf('%3.3f lcL\n',toc);
        end

        % Button pushed function: C_lick
        function C_lickButtonPushed(app, event)
            global sdata;
            sdata = [108 99 67];
            sdata = char(sdata);
            fprintf('%3.3f lcC\n',toc);            
        end

        % Button pushed function: R_lick
        function R_lickButtonPushed(app, event)
            global sdata;
            sdata = [108 99 82];
            sdata = char(sdata);
            fprintf('%3.3f lcR\n',toc);            
        end

        % Value changed function: linear
        function linearValueChanged(app, event)
            value = app.linear.Value;
            if value
                app.servo.Value = 0;
            else
                app.servo.Value = 1;
            end
        end

        % Value changed function: servo
        function servoValueChanged(app, event)
            value = app.servo.Value;
            if value
                app.linear.Value = 0;
            else
                app.linear.Value = 1;
            end
        end

        % Button pushed function: dir_input_file
        function dir_input_fileButtonPushed(app, event)
            global dirpath_input_file;
%             if isempty(dirpath_input_file)
%                 dirpath_input_file = pwd;
%             end
%             ddir = uigetdir(dirpath_input_file);
%             app.input_filename.Value = [ddir '\'];            
%             
                     
            
            [fn,pn,FilterIndex]  = ...
                 uigetfile({'*.txt'},'Input data file',dirpath_input_file);
            if (pn ~= 0)
                dirpath_input_file = pn;
            else
                 return;
            end
            fn = [pn fn];
            app.input_filename.Value = fn;
            
        end

        % Value changed function: left_first
        function left_firstValueChanged(app, event)
        global forced_left_count  forced_right_count; 
            if app.left_first.Value
                app.right_first.Value = 0;
                forced_left_count = app.number_of_lefts.Value;
                forced_right_count = 0;
            else
                app.right_first.Value = 1;
                forced_right_count = app.number_of_rights.Value;
                forced_left_count = 0;
            end
        end

        % Value changed function: right_first
        function right_firstValueChanged(app, event)
        global forced_left_count  forced_right_count; 
            if app.right_first.Value
                app.left_first.Value = 0;
                forced_right_count = app.number_of_rights.Value;
                forced_left_count = 0;
            else
                app.left_first.Value = 1;
                forced_left_count = app.number_of_lefts.Value;
                forced_right_count = 0;
            end
        end

        % Value changed function: percent_retrial_rewards
        function percent_retrial_rewardsValueChanged(app, event)
            value = app.percent_retrial_rewards.Value;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure1 and hide until all components are created
            app.figure1 = uifigure('Visible', 'off');
            app.figure1.Position = [100 100 1242 754];
            app.figure1.Name = 'main';
            app.figure1.Resize = 'off';
            app.figure1.CloseRequestFcn = createCallbackFcn(app, @figure1CloseRequest, true);

            % Create start
            app.start = uibutton(app.figure1, 'push');
            app.start.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);
            app.start.FontSize = 21;
            app.start.FontWeight = 'bold';
            app.start.Position = [43 679 125 46];
            app.start.Text = 'Start';

            % Create statenumber
            app.statenumber = uilabel(app.figure1);
            app.statenumber.HorizontalAlignment = 'center';
            app.statenumber.VerticalAlignment = 'top';
            app.statenumber.FontSize = 27;
            app.statenumber.FontWeight = 'bold';
            app.statenumber.Position = [249 691 46 34];
            app.statenumber.Text = '0';

            % Create animalid
            app.animalid = uieditfield(app.figure1, 'text');
            app.animalid.Tag = 'Animal ID';
            app.animalid.HorizontalAlignment = 'center';
            app.animalid.FontSize = 13;
            app.animalid.FontWeight = 'bold';
            app.animalid.Position = [814 714 302 25];

            % Create text19
            app.text19 = uilabel(app.figure1);
            app.text19.VerticalAlignment = 'top';
            app.text19.FontSize = 13;
            app.text19.FontWeight = 'bold';
            app.text19.Position = [738 718 68 16];
            app.text19.Text = 'Animal ID';

            % Create dir
            app.dir = uibutton(app.figure1, 'push');
            app.dir.ButtonPushedFcn = createCallbackFcn(app, @dir_Callback, true);
            app.dir.FontSize = 16;
            app.dir.FontWeight = 'bold';
            app.dir.Position = [1138 716 68 23];
            app.dir.Text = 'Dir';

            % Create notes
            app.notes = uieditfield(app.figure1, 'text');
            app.notes.Tag = 'Notes';
            app.notes.HorizontalAlignment = 'center';
            app.notes.FontSize = 13;
            app.notes.FontWeight = 'bold';
            app.notes.Position = [814 681 302 25];

            % Create text26
            app.text26 = uilabel(app.figure1);
            app.text26.VerticalAlignment = 'top';
            app.text26.FontSize = 13;
            app.text26.FontWeight = 'bold';
            app.text26.Position = [748 685 48 16];
            app.text26.Text = 'Notes';

            % Create state1_count
            app.state1_count = uilabel(app.figure1);
            app.state1_count.HorizontalAlignment = 'center';
            app.state1_count.VerticalAlignment = 'top';
            app.state1_count.FontSize = 27;
            app.state1_count.FontWeight = 'bold';
            app.state1_count.Position = [188 693 44 32];
            app.state1_count.Text = '0';

            % Create text29
            app.text29 = uilabel(app.figure1);
            app.text29.VerticalAlignment = 'top';
            app.text29.FontSize = 13;
            app.text29.FontWeight = 'bold';
            app.text29.Position = [258 670 48 16];
            app.text29.Text = 'State';

            % Create text36
            app.text36 = uilabel(app.figure1);
            app.text36.VerticalAlignment = 'top';
            app.text36.FontSize = 13;
            app.text36.FontWeight = 'bold';
            app.text36.Position = [191 670 48 16];
            app.text36.Text = 'Trial #';

            % Create uipanel2
            app.uipanel2 = uipanel(app.figure1);
            app.uipanel2.Title = 'Valve Control';
            app.uipanel2.FontWeight = 'bold';
            app.uipanel2.FontSize = 13;
            app.uipanel2.Position = [873 13 327 155];

            % Create rewardL
            app.rewardL = uibutton(app.uipanel2, 'push');
            app.rewardL.ButtonPushedFcn = createCallbackFcn(app, @rewardL_Callback, true);
            app.rewardL.FontSize = 13;
            app.rewardL.FontWeight = 'bold';
            app.rewardL.Position = [22 94 80 35];
            app.rewardL.Text = 'Reward L';

            % Create valveR
            app.valveR = uibutton(app.uipanel2, 'push');
            app.valveR.ButtonPushedFcn = createCallbackFcn(app, @valveRButtonPushed, true);
            app.valveR.FontSize = 13;
            app.valveR.FontWeight = 'bold';
            app.valveR.Position = [223 55 80 35];
            app.valveR.Text = 'Open Valve R';

            % Create valveL
            app.valveL = uibutton(app.uipanel2, 'push');
            app.valveL.ButtonPushedFcn = createCallbackFcn(app, @valveLButtonPushed, true);
            app.valveL.FontSize = 13;
            app.valveL.FontWeight = 'bold';
            app.valveL.Position = [23 55 80 35];
            app.valveL.Text = 'Open Valve L';

            % Create rewardR
            app.rewardR = uibutton(app.uipanel2, 'push');
            app.rewardR.ButtonPushedFcn = createCallbackFcn(app, @rewardR_Callback, true);
            app.rewardR.FontSize = 13;
            app.rewardR.FontWeight = 'bold';
            app.rewardR.Position = [222 94 80 35];
            app.rewardR.Text = 'Reward R';

            % Create rewardC
            app.rewardC = uibutton(app.uipanel2, 'push');
            app.rewardC.ButtonPushedFcn = createCallbackFcn(app, @rewardC_Callback, true);
            app.rewardC.FontSize = 13;
            app.rewardC.FontWeight = 'bold';
            app.rewardC.Position = [122 94 80 35];
            app.rewardC.Text = 'Reward C';

            % Create valveC
            app.valveC = uibutton(app.uipanel2, 'push');
            app.valveC.ButtonPushedFcn = createCallbackFcn(app, @valveCButtonPushed, true);
            app.valveC.FontSize = 13;
            app.valveC.FontWeight = 'bold';
            app.valveC.Position = [123 55 80 35];
            app.valveC.Text = 'Open Valve C';

            % Create text4
            app.text4 = uilabel(app.uipanel2);
            app.text4.VerticalAlignment = 'top';
            app.text4.FontSize = 13;
            app.text4.FontWeight = 'bold';
            app.text4.Position = [95 -4 125 25];
            app.text4.Text = 'reward_pulses (ms)';

            % Create reward_pulse_C
            app.reward_pulse_C = uieditfield(app.uipanel2, 'text');
            app.reward_pulse_C.ValueChangedFcn = createCallbackFcn(app, @reward_pulse_C_Callback, true);
            app.reward_pulse_C.Tag = 'Reward Duration Center';
            app.reward_pulse_C.HorizontalAlignment = 'center';
            app.reward_pulse_C.FontSize = 13;
            app.reward_pulse_C.Position = [136 26 51 25];
            app.reward_pulse_C.Value = '100';

            % Create reward_pulse_R
            app.reward_pulse_R = uieditfield(app.uipanel2, 'text');
            app.reward_pulse_R.ValueChangedFcn = createCallbackFcn(app, @reward_pulse_R_Callback, true);
            app.reward_pulse_R.Tag = 'Reward Duration Right';
            app.reward_pulse_R.HorizontalAlignment = 'center';
            app.reward_pulse_R.FontSize = 13;
            app.reward_pulse_R.Position = [237 26 51 25];
            app.reward_pulse_R.Value = '100';

            % Create reward_pulse_L
            app.reward_pulse_L = uieditfield(app.uipanel2, 'text');
            app.reward_pulse_L.ValueChangedFcn = createCallbackFcn(app, @reward_pulse_L_Callback, true);
            app.reward_pulse_L.Tag = 'Reward Duration Left';
            app.reward_pulse_L.HorizontalAlignment = 'center';
            app.reward_pulse_L.FontSize = 13;
            app.reward_pulse_L.Position = [38 26 51 25];
            app.reward_pulse_L.Value = '100';

            % Create uipanel3
            app.uipanel3 = uipanel(app.figure1);
            app.uipanel3.Title = 'Tone Control';
            app.uipanel3.FontWeight = 'bold';
            app.uipanel3.FontSize = 13;
            app.uipanel3.Position = [1072 176 128 121];

            % Create toner
            app.toner = uibutton(app.uipanel3, 'push');
            app.toner.ButtonPushedFcn = createCallbackFcn(app, @toner_Callback, true);
            app.toner.FontSize = 13;
            app.toner.FontWeight = 'bold';
            app.toner.Position = [66 58 50 35];
            app.toner.Text = 'R ON';

            % Create tonel
            app.tonel = uibutton(app.uipanel3, 'push');
            app.tonel.ButtonPushedFcn = createCallbackFcn(app, @tonel_Callback, true);
            app.tonel.FontSize = 13;
            app.tonel.FontWeight = 'bold';
            app.tonel.Position = [9 58 50 35];
            app.tonel.Text = 'L  ON ';

            % Create vol
            app.vol = uibutton(app.uipanel3, 'push');
            app.vol.ButtonPushedFcn = createCallbackFcn(app, @vol_Callback, true);
            app.vol.FontSize = 13;
            app.vol.FontWeight = 'bold';
            app.vol.Position = [9 16 53 35];
            app.vol.Text = 'VOL +';

            % Create vol_2
            app.vol_2 = uibutton(app.uipanel3, 'push');
            app.vol_2.ButtonPushedFcn = createCallbackFcn(app, @vol_2ButtonPushed, true);
            app.vol_2.FontSize = 13;
            app.vol_2.FontWeight = 'bold';
            app.vol_2.Position = [66 16 53 35];
            app.vol_2.Text = 'VOL -';

            % Create uipanel4
            app.uipanel4 = uipanel(app.figure1);
            app.uipanel4.Title = 'Light Control';
            app.uipanel4.FontWeight = 'bold';
            app.uipanel4.FontSize = 13;
            app.uipanel4.Position = [873 176 190 121];

            % Create flashl
            app.flashl = uibutton(app.uipanel4, 'push');
            app.flashl.ButtonPushedFcn = createCallbackFcn(app, @flashl_Callback, true);
            app.flashl.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashl.FontSize = 13;
            app.flashl.FontWeight = 'bold';
            app.flashl.Position = [11 58 55 35];
            app.flashl.Text = 'Flash L';

            % Create flashr
            app.flashr = uibutton(app.uipanel4, 'push');
            app.flashr.ButtonPushedFcn = createCallbackFcn(app, @flashr_Callback, true);
            app.flashr.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashr.FontSize = 13;
            app.flashr.FontWeight = 'bold';
            app.flashr.Position = [125 58 55 35];
            app.flashr.Text = 'Flash R';

            % Create flashc
            app.flashc = uibutton(app.uipanel4, 'push');
            app.flashc.ButtonPushedFcn = createCallbackFcn(app, @flashc_Callback, true);
            app.flashc.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashc.FontSize = 13;
            app.flashc.FontWeight = 'bold';
            app.flashc.Position = [67 58 55 35];
            app.flashc.Text = 'Flash C';

            % Create test
            app.test = uibutton(app.uipanel4, 'push');
            app.test.ButtonPushedFcn = createCallbackFcn(app, @test_Callback, true);
            app.test.FontSize = 13;
            app.test.FontWeight = 'bold';
            app.test.Position = [13 25 164 30];
            app.test.Text = 'Light Sequence';

            % Create allleds
            app.allleds = uicheckbox(app.uipanel4);
            app.allleds.Text = 'All LED Pattern';
            app.allleds.FontSize = 13;
            app.allleds.FontWeight = 'bold';
            app.allleds.Position = [22 0 164 25];

            % Create uipanel5
            app.uipanel5 = uipanel(app.figure1);
            app.uipanel5.Title = 'Air Puff';
            app.uipanel5.FontWeight = 'bold';
            app.uipanel5.FontSize = 13;
            app.uipanel5.Position = [384 16 119 67];

            % Create airpuff
            app.airpuff = uibutton(app.uipanel5, 'push');
            app.airpuff.ButtonPushedFcn = createCallbackFcn(app, @airpuff_Callback, true);
            app.airpuff.FontSize = 13;
            app.airpuff.FontWeight = 'bold';
            app.airpuff.Position = [10 6 100 35];
            app.airpuff.Text = 'Send Air Puff';

            % Create write
            app.write = uibutton(app.figure1, 'push');
            app.write.ButtonPushedFcn = createCallbackFcn(app, @write_Callback, true);
            app.write.FontSize = 16;
            app.write.FontWeight = 'bold';
            app.write.Position = [1124 682 96 24];
            app.write.Text = 'Write Note';

            % Create spout1_1
            app.spout1_1 = uibutton(app.figure1, 'push');
            app.spout1_1.ButtonPushedFcn = createCallbackFcn(app, @spout1, true);
            app.spout1_1.FontSize = 13;
            app.spout1_1.FontWeight = 'bold';
            app.spout1_1.Position = [780 79 76 39];
            app.spout1_1.Text = 'C Out';

            % Create spout2_1
            app.spout2_1 = uibutton(app.figure1, 'push');
            app.spout2_1.ButtonPushedFcn = createCallbackFcn(app, @spout2, true);
            app.spout2_1.FontSize = 13;
            app.spout2_1.FontWeight = 'bold';
            app.spout2_1.Position = [780 35 76 39];
            app.spout2_1.Text = 'LR Out';

            % Create fullretract
            app.fullretract = uibutton(app.figure1, 'push');
            app.fullretract.ButtonPushedFcn = createCallbackFcn(app, @fullretract_Callback, true);
            app.fullretract.FontSize = 13;
            app.fullretract.FontWeight = 'bold';
            app.fullretract.Position = [692 59 76 39];
            app.fullretract.Text = 'FullRetract';

            % Create torest
            app.torest = uibutton(app.figure1, 'push');
            app.torest.ButtonPushedFcn = createCallbackFcn(app, @torest_Callback, true);
            app.torest.FontSize = 13;
            app.torest.FontWeight = 'bold';
            app.torest.Position = [692 15 76 39];
            app.torest.Text = 'ToRest';

            % Create fullout
            app.fullout = uibutton(app.figure1, 'push');
            app.fullout.ButtonPushedFcn = createCallbackFcn(app, @fullout_Callback, true);
            app.fullout.FontSize = 13;
            app.fullout.FontWeight = 'bold';
            app.fullout.Position = [692 103 76 39];
            app.fullout.Text = 'Full Out';

            % Create text19_3
            app.text19_3 = uilabel(app.figure1);
            app.text19_3.VerticalAlignment = 'top';
            app.text19_3.FontSize = 13;
            app.text19_3.FontWeight = 'bold';
            app.text19_3.Position = [529 137 99 22];
            app.text19_3.Text = 'Servo Controls';

            % Create Panel_TDC
            app.Panel_TDC = uipanel(app.figure1);
            app.Panel_TDC.FontWeight = 'bold';
            app.Panel_TDC.Position = [294 176 280 485];

            % Create StimStartDelaysLabel
            app.StimStartDelaysLabel = uilabel(app.Panel_TDC);
            app.StimStartDelaysLabel.FontWeight = 'bold';
            app.StimStartDelaysLabel.Position = [37 404 116 22];
            app.StimStartDelaysLabel.Text = 'Stim Start Delay (s)';

            % Create stim_start_delay
            app.stim_start_delay = uieditfield(app.Panel_TDC, 'numeric');
            app.stim_start_delay.Tag = 'Stim Start Delay';
            app.stim_start_delay.HorizontalAlignment = 'center';
            app.stim_start_delay.FontWeight = 'bold';
            app.stim_start_delay.Position = [219 404 50 22];
            app.stim_start_delay.Value = 0.5;

            % Create TimeCenterSpoutAvailableLabel
            app.TimeCenterSpoutAvailableLabel = uilabel(app.Panel_TDC);
            app.TimeCenterSpoutAvailableLabel.FontWeight = 'bold';
            app.TimeCenterSpoutAvailableLabel.Position = [37 375 168 22];
            app.TimeCenterSpoutAvailableLabel.Text = 'Time Center Spout Available';

            % Create time_center_spout_available
            app.time_center_spout_available = uieditfield(app.Panel_TDC, 'numeric');
            app.time_center_spout_available.Tag = 'Time Center Spout Available with Stable Delay';
            app.time_center_spout_available.HorizontalAlignment = 'center';
            app.time_center_spout_available.FontWeight = 'bold';
            app.time_center_spout_available.Position = [219 375 50 22];
            app.time_center_spout_available.Value = 0.1;

            % Create text29_2
            app.text29_2 = uilabel(app.Panel_TDC);
            app.text29_2.VerticalAlignment = 'top';
            app.text29_2.FontSize = 16;
            app.text29_2.FontWeight = 'bold';
            app.text29_2.Position = [11 458 200 22];
            app.text29_2.Text = 'Timer and Delay Controls';

            % Create Stable_Delays
            app.Stable_Delays = uicheckbox(app.Panel_TDC);
            app.Stable_Delays.ValueChangedFcn = createCallbackFcn(app, @Stable_DelaysValueChanged, true);
            app.Stable_Delays.Tag = 'Stable Delays';
            app.Stable_Delays.Text = 'Stable Delays';
            app.Stable_Delays.FontWeight = 'bold';
            app.Stable_Delays.Position = [11 431 100 22];

            % Create Variable_TCSA
            app.Variable_TCSA = uicheckbox(app.Panel_TDC);
            app.Variable_TCSA.ValueChangedFcn = createCallbackFcn(app, @Variable_TCSAValueChanged, true);
            app.Variable_TCSA.Tag = 'Time Center Spout Available with Variable  Delay';
            app.Variable_TCSA.Text = 'Variable Time Center Spout Available';
            app.Variable_TCSA.FontWeight = 'bold';
            app.Variable_TCSA.Position = [11 276 235 22];

            % Create Variable_SSD
            app.Variable_SSD = uicheckbox(app.Panel_TDC);
            app.Variable_SSD.ValueChangedFcn = createCallbackFcn(app, @Variable_SSDValueChanged, true);
            app.Variable_SSD.Tag = 'Variable Stim Start Delay';
            app.Variable_SSD.Text = 'Variable Stim Start Delay';
            app.Variable_SSD.FontWeight = 'bold';
            app.Variable_SSD.Position = [11 340 163 22];

            % Create StimStartDelayLabel
            app.StimStartDelayLabel = uilabel(app.Panel_TDC);
            app.StimStartDelayLabel.FontWeight = 'bold';
            app.StimStartDelayLabel.Position = [37 249 98 22];
            app.StimStartDelayLabel.Text = 'Stim Start Delay';

            % Create stim_start_delay_fixed
            app.stim_start_delay_fixed = uieditfield(app.Panel_TDC, 'numeric');
            app.stim_start_delay_fixed.Tag = 'Stim Start Delay with Variable Time Canter Spout Available';
            app.stim_start_delay_fixed.HorizontalAlignment = 'center';
            app.stim_start_delay_fixed.FontWeight = 'bold';
            app.stim_start_delay_fixed.Position = [219 249 50 22];
            app.stim_start_delay_fixed.Value = 1;

            % Create TimeCenterSpoutAvailableLabel_2
            app.TimeCenterSpoutAvailableLabel_2 = uilabel(app.Panel_TDC);
            app.TimeCenterSpoutAvailableLabel_2.FontWeight = 'bold';
            app.TimeCenterSpoutAvailableLabel_2.Position = [37 313 168 22];
            app.TimeCenterSpoutAvailableLabel_2.Text = 'Time Center Spout Available';

            % Create time_center_spout_available_fixed
            app.time_center_spout_available_fixed = uieditfield(app.Panel_TDC, 'numeric');
            app.time_center_spout_available_fixed.Tag = 'Time Center Spout Available with Variable  Delay';
            app.time_center_spout_available_fixed.HorizontalAlignment = 'center';
            app.time_center_spout_available_fixed.FontWeight = 'bold';
            app.time_center_spout_available_fixed.Position = [219 313 50 22];
            app.time_center_spout_available_fixed.Value = 1;

            % Create tcsa_reward
            app.tcsa_reward = uicheckbox(app.Panel_TDC);
            app.tcsa_reward.Tag = 'TCSA Reward';
            app.tcsa_reward.Text = 'TCSA reward';
            app.tcsa_reward.FontWeight = 'bold';
            app.tcsa_reward.Position = [11 148 97 20];

            % Create DelayTableLabel
            app.DelayTableLabel = uilabel(app.Panel_TDC);
            app.DelayTableLabel.FontWeight = 'bold';
            app.DelayTableLabel.Position = [11 218 75 22];
            app.DelayTableLabel.Text = 'Delay Table:';

            % Create minsEditField_2Label
            app.minsEditField_2Label = uilabel(app.Panel_TDC);
            app.minsEditField_2Label.HorizontalAlignment = 'right';
            app.minsEditField_2Label.FontWeight = 'bold';
            app.minsEditField_2Label.Position = [84 218 45 22];
            app.minsEditField_2Label.Text = 'min (s)';

            % Create min_delay
            app.min_delay = uieditfield(app.Panel_TDC, 'numeric');
            app.min_delay.Tag = 'Delay Table Min';
            app.min_delay.FontWeight = 'bold';
            app.min_delay.Position = [134 218 38 22];
            app.min_delay.Value = 1;

            % Create maxsEditField_2Label
            app.maxsEditField_2Label = uilabel(app.Panel_TDC);
            app.maxsEditField_2Label.HorizontalAlignment = 'right';
            app.maxsEditField_2Label.FontWeight = 'bold';
            app.maxsEditField_2Label.Position = [177 218 48 22];
            app.maxsEditField_2Label.Text = 'max (s)';

            % Create max_delay
            app.max_delay = uieditfield(app.Panel_TDC, 'numeric');
            app.max_delay.Tag = 'Delay Table Max';
            app.max_delay.FontWeight = 'bold';
            app.max_delay.Position = [229 218 38 22];
            app.max_delay.Value = 3;

            % Create numberofstepsEditField_2Label
            app.numberofstepsEditField_2Label = uilabel(app.Panel_TDC);
            app.numberofstepsEditField_2Label.HorizontalAlignment = 'right';
            app.numberofstepsEditField_2Label.FontWeight = 'bold';
            app.numberofstepsEditField_2Label.Position = [112 192 99 22];
            app.numberofstepsEditField_2Label.Text = 'number of steps';

            % Create numberofsteps
            app.numberofsteps = uieditfield(app.Panel_TDC, 'numeric');
            app.numberofsteps.Tag = 'Delay Table Number of Steps';
            app.numberofsteps.FontWeight = 'bold';
            app.numberofsteps.Position = [226 192 41 22];

            % Create override
            app.override = uicheckbox(app.Panel_TDC);
            app.override.Tag = 'Override Consecutive Constraint';
            app.override.Text = 'Override Consec Constraint';
            app.override.FontSize = 13;
            app.override.FontWeight = 'bold';
            app.override.Position = [11 127 229 20];

            % Create per_R
            app.per_R = uieditfield(app.Panel_TDC, 'numeric');
            app.per_R.Tag = 'Percentage Right Rewards';
            app.per_R.HorizontalAlignment = 'center';
            app.per_R.FontWeight = 'bold';
            app.per_R.Position = [223 38 49 22];
            app.per_R.Value = 50;

            % Create PercentageofRightRewardsLabel
            app.PercentageofRightRewardsLabel = uilabel(app.Panel_TDC);
            app.PercentageofRightRewardsLabel.FontWeight = 'bold';
            app.PercentageofRightRewardsLabel.Position = [14 38 172 22];
            app.PercentageofRightRewardsLabel.Text = 'Percentage of Right Rewards';

            % Create percentage_of_training_trials
            app.percentage_of_training_trials = uieditfield(app.Panel_TDC, 'numeric');
            app.percentage_of_training_trials.Tag = 'Percentage Training Trials';
            app.percentage_of_training_trials.HorizontalAlignment = 'center';
            app.percentage_of_training_trials.FontWeight = 'bold';
            app.percentage_of_training_trials.Position = [223 65 49 22];
            app.percentage_of_training_trials.Value = 100;

            % Create PercentageTrainingTrialsLabel
            app.PercentageTrainingTrialsLabel = uilabel(app.Panel_TDC);
            app.PercentageTrainingTrialsLabel.FontWeight = 'bold';
            app.PercentageTrainingTrialsLabel.Position = [14 65 155 22];
            app.PercentageTrainingTrialsLabel.Text = 'Percentage Training Trials';

            % Create first_lick_no_reward
            app.first_lick_no_reward = uicheckbox(app.Panel_TDC);
            app.first_lick_no_reward.Tag = 'First Lick No Reward';
            app.first_lick_no_reward.Text = 'First lick no reward';
            app.first_lick_no_reward.FontWeight = 'bold';
            app.first_lick_no_reward.Position = [11 169 132 20];

            % Create tcsa_lick_time_window
            app.tcsa_lick_time_window = uieditfield(app.Panel_TDC, 'numeric');
            app.tcsa_lick_time_window.Tag = 'TCSA Licj Time Window';
            app.tcsa_lick_time_window.HorizontalAlignment = 'center';
            app.tcsa_lick_time_window.FontWeight = 'bold';
            app.tcsa_lick_time_window.Position = [223 92 49 22];
            app.tcsa_lick_time_window.Value = 100;

            % Create TCSALickTimeWindowsLabel
            app.TCSALickTimeWindowsLabel = uilabel(app.Panel_TDC);
            app.TCSALickTimeWindowsLabel.FontWeight = 'bold';
            app.TCSALickTimeWindowsLabel.Position = [14 92 164 22];
            app.TCSALickTimeWindowsLabel.Text = 'TCSA Lick Time Window (s)';

            % Create percentage_of_center_rewards
            app.percentage_of_center_rewards = uieditfield(app.Panel_TDC, 'numeric');
            app.percentage_of_center_rewards.Tag = 'Percentage Center Rewards';
            app.percentage_of_center_rewards.HorizontalAlignment = 'center';
            app.percentage_of_center_rewards.FontWeight = 'bold';
            app.percentage_of_center_rewards.Position = [223 11 49 22];
            app.percentage_of_center_rewards.Value = 80;

            % Create PercentageofCenterRewardsLabel
            app.PercentageofCenterRewardsLabel = uilabel(app.Panel_TDC);
            app.PercentageofCenterRewardsLabel.FontWeight = 'bold';
            app.PercentageofCenterRewardsLabel.Position = [14 11 180 22];
            app.PercentageofCenterRewardsLabel.Text = 'Percentage of Center Rewards';

            % Create Panel_DM
            app.Panel_DM = uipanel(app.figure1);
            app.Panel_DM.FontWeight = 'bold';
            app.Panel_DM.Position = [581 176 283 485];

            % Create ButtonGroup_DM
            app.ButtonGroup_DM = uibuttongroup(app.Panel_DM);
            app.ButtonGroup_DM.FontWeight = 'bold';
            app.ButtonGroup_DM.Position = [1 404 280 55];

            % Create Light
            app.Light = uiradiobutton(app.ButtonGroup_DM);
            app.Light.Tag = 'Light Selected';
            app.Light.Text = 'Light';
            app.Light.FontWeight = 'bold';
            app.Light.Position = [7 29 58 22];
            app.Light.Value = true;

            % Create tone
            app.tone = uiradiobutton(app.ButtonGroup_DM);
            app.tone.Tag = 'Tone Selected';
            app.tone.Text = {'Tone'; ''};
            app.tone.FontWeight = 'bold';
            app.tone.Position = [145 29 48 22];

            % Create white_noise
            app.white_noise = uiradiobutton(app.ButtonGroup_DM);
            app.white_noise.Tag = 'Noise Selected';
            app.white_noise.Text = 'Noise';
            app.white_noise.FontWeight = 'bold';
            app.white_noise.Position = [205 28 55 22];

            % Create BrightnessLabel
            app.BrightnessLabel = uilabel(app.ButtonGroup_DM);
            app.BrightnessLabel.FontWeight = 'bold';
            app.BrightnessLabel.Position = [12 3 71 22];
            app.BrightnessLabel.Text = 'Brightness';

            % Create brightness
            app.brightness = uieditfield(app.ButtonGroup_DM, 'numeric');
            app.brightness.ValueChangedFcn = createCallbackFcn(app, @brightnessValueChanged2, true);
            app.brightness.Tag = 'Brightness';
            app.brightness.HorizontalAlignment = 'center';
            app.brightness.Position = [85 3 27 22];
            app.brightness.Value = 4;

            % Create VolumeLabel
            app.VolumeLabel = uilabel(app.ButtonGroup_DM);
            app.VolumeLabel.FontWeight = 'bold';
            app.VolumeLabel.Position = [170 1 50 22];
            app.VolumeLabel.Text = 'Volume';

            % Create volume
            app.volume = uieditfield(app.ButtonGroup_DM, 'numeric');
            app.volume.Tag = 'Volume';
            app.volume.HorizontalAlignment = 'center';
            app.volume.Position = [229 1 31 22];
            app.volume.Value = 4;

            % Create RateDiscrimination
            app.RateDiscrimination = uicheckbox(app.Panel_DM);
            app.RateDiscrimination.ValueChangedFcn = createCallbackFcn(app, @RateDiscriminationValueChanged, true);
            app.RateDiscrimination.Tag = 'Rate Discrimination Selected';
            app.RateDiscrimination.Text = 'Rate Discrimination';
            app.RateDiscrimination.FontWeight = 'bold';
            app.RateDiscrimination.Position = [10 213 135 22];

            % Create light2
            app.light2 = uicheckbox(app.Panel_DM);
            app.light2.ValueChangedFcn = createCallbackFcn(app, @light2_Callback, true);
            app.light2.Tag = '2 Panel Light';
            app.light2.Text = '2 Panel Light';
            app.light2.FontSize = 13;
            app.light2.FontWeight = 'bold';
            app.light2.Position = [37 353 108 25];

            % Create light8
            app.light8 = uicheckbox(app.Panel_DM);
            app.light8.ValueChangedFcn = createCallbackFcn(app, @light8_Callback, true);
            app.light8.Tag = '6 Panel Light';
            app.light8.Text = '6 panel Light';
            app.light8.FontSize = 13;
            app.light8.FontWeight = 'bold';
            app.light8.Position = [37 329 108 25];

            % Create no_test_punishment
            app.no_test_punishment = uicheckbox(app.Panel_DM);
            app.no_test_punishment.Tag = 'No Test Punish';
            app.no_test_punishment.Text = 'No Test Punish';
            app.no_test_punishment.FontSize = 13;
            app.no_test_punishment.FontWeight = 'bold';
            app.no_test_punishment.Position = [157 326 116 25];

            % Create SideDiscrimination
            app.SideDiscrimination = uicheckbox(app.Panel_DM);
            app.SideDiscrimination.ValueChangedFcn = createCallbackFcn(app, @SideDiscriminationValueChanged, true);
            app.SideDiscrimination.Text = 'Side Discrimination';
            app.SideDiscrimination.FontWeight = 'bold';
            app.SideDiscrimination.Position = [10 378 134 22];

            % Create HighRateHzLabel
            app.HighRateHzLabel = uilabel(app.Panel_DM);
            app.HighRateHzLabel.FontWeight = 'bold';
            app.HighRateHzLabel.Position = [21 91 87 22];
            app.HighRateHzLabel.Text = 'High Rate (Hz)';

            % Create high_rate
            app.high_rate = uieditfield(app.Panel_DM, 'numeric');
            app.high_rate.ValueChangedFcn = createCallbackFcn(app, @high_rateValueChanged, true);
            app.high_rate.Tag = 'High Rate';
            app.high_rate.HorizontalAlignment = 'center';
            app.high_rate.FontWeight = 'bold';
            app.high_rate.Position = [167 91 50 20];
            app.high_rate.Value = 10;

            % Create LowRateHzLabel
            app.LowRateHzLabel = uilabel(app.Panel_DM);
            app.LowRateHzLabel.FontWeight = 'bold';
            app.LowRateHzLabel.Position = [21 65 85 22];
            app.LowRateHzLabel.Text = 'Low Rate (Hz)';

            % Create low_rate
            app.low_rate = uieditfield(app.Panel_DM, 'numeric');
            app.low_rate.ValueChangedFcn = createCallbackFcn(app, @low_rateValueChanged, true);
            app.low_rate.Tag = 'Low Rate';
            app.low_rate.HorizontalAlignment = 'center';
            app.low_rate.FontWeight = 'bold';
            app.low_rate.Position = [167 65 50 20];
            app.low_rate.Value = 1;

            % Create DurationsLabel
            app.DurationsLabel = uilabel(app.Panel_DM);
            app.DurationsLabel.FontWeight = 'bold';
            app.DurationsLabel.Position = [21 39 73 22];
            app.DurationsLabel.Text = 'Duration (s)';

            % Create stim_duration_rate_disc
            app.stim_duration_rate_disc = uieditfield(app.Panel_DM, 'numeric');
            app.stim_duration_rate_disc.Tag = 'Duration';
            app.stim_duration_rate_disc.HorizontalAlignment = 'center';
            app.stim_duration_rate_disc.FontWeight = 'bold';
            app.stim_duration_rate_disc.Position = [167 39 50 20];
            app.stim_duration_rate_disc.Value = 5;

            % Create higher_rate_correct
            app.higher_rate_correct = uicheckbox(app.Panel_DM);
            app.higher_rate_correct.Tag = 'Higher Rate Correct';
            app.higher_rate_correct.Text = 'Higher Rate Crct';
            app.higher_rate_correct.FontWeight = 'bold';
            app.higher_rate_correct.Position = [21 184 117 22];

            % Create Stim_durationsLabel
            app.Stim_durationsLabel = uilabel(app.Panel_DM);
            app.Stim_durationsLabel.FontWeight = 'bold';
            app.Stim_durationsLabel.Position = [38 303 104 22];
            app.Stim_durationsLabel.Text = 'Stim_duration (s)';

            % Create stim_duration
            app.stim_duration = uieditfield(app.Panel_DM, 'numeric');
            app.stim_duration.Tag = 'Stim Duration';
            app.stim_duration.HorizontalAlignment = 'center';
            app.stim_duration.FontWeight = 'bold';
            app.stim_duration.Position = [184 304 50 20];
            app.stim_duration.Value = 0.1;

            % Create Stim_cycle_durationsLabel
            app.Stim_cycle_durationsLabel = uilabel(app.Panel_DM);
            app.Stim_cycle_durationsLabel.FontWeight = 'bold';
            app.Stim_cycle_durationsLabel.Position = [38 277 143 22];
            app.Stim_cycle_durationsLabel.Text = 'Stim_cycle_duration (s)';

            % Create stim_cycle_duration
            app.stim_cycle_duration = uieditfield(app.Panel_DM, 'numeric');
            app.stim_cycle_duration.Tag = 'Stim Cycle Duration';
            app.stim_cycle_duration.HorizontalAlignment = 'center';
            app.stim_cycle_duration.FontWeight = 'bold';
            app.stim_cycle_duration.Position = [184 277 50 20];
            app.stim_cycle_duration.Value = 0.25;

            % Create NumberofstimcyclesLabel
            app.NumberofstimcyclesLabel = uilabel(app.Panel_DM);
            app.NumberofstimcyclesLabel.FontWeight = 'bold';
            app.NumberofstimcyclesLabel.Position = [38 251 134 22];
            app.NumberofstimcyclesLabel.Text = 'Number of stim cycles';

            % Create number_of_stim_cycles
            app.number_of_stim_cycles = uieditfield(app.Panel_DM, 'numeric');
            app.number_of_stim_cycles.Tag = 'Number of Stim Cycles';
            app.number_of_stim_cycles.HorizontalAlignment = 'center';
            app.number_of_stim_cycles.FontWeight = 'bold';
            app.number_of_stim_cycles.Position = [184 251 50 20];
            app.number_of_stim_cycles.Value = 100;

            % Create two_rates_only
            app.two_rates_only = uicheckbox(app.Panel_DM);
            app.two_rates_only.ValueChangedFcn = createCallbackFcn(app, @two_rates_onlyValueChanged, true);
            app.two_rates_only.Tag = '2 Rates Oly';
            app.two_rates_only.Text = '2 Rates Only';
            app.two_rates_only.FontSize = 13;
            app.two_rates_only.FontWeight = 'bold';
            app.two_rates_only.Position = [21 157 108 25];

            % Create mixed_rates
            app.mixed_rates = uicheckbox(app.Panel_DM);
            app.mixed_rates.ValueChangedFcn = createCallbackFcn(app, @mixed_ratesValueChanged, true);
            app.mixed_rates.Tag = 'Mixed Rates';
            app.mixed_rates.Text = 'Mixed Rates';
            app.mixed_rates.FontSize = 13;
            app.mixed_rates.FontWeight = 'bold';
            app.mixed_rates.Position = [21 130 108 25];

            % Create no_test_punishment_rd
            app.no_test_punishment_rd = uicheckbox(app.Panel_DM);
            app.no_test_punishment_rd.Tag = 'No Test Punish';
            app.no_test_punishment_rd.Text = 'No Test Punish';
            app.no_test_punishment_rd.FontSize = 13;
            app.no_test_punishment_rd.FontWeight = 'bold';
            app.no_test_punishment_rd.Position = [157 130 116 25];

            % Create single_panel
            app.single_panel = uicheckbox(app.Panel_DM);
            app.single_panel.ValueChangedFcn = createCallbackFcn(app, @single_panelValueChanged, true);
            app.single_panel.Tag = 'Single Panel';
            app.single_panel.Text = 'Single Panel';
            app.single_panel.FontSize = 13;
            app.single_panel.FontWeight = 'bold';
            app.single_panel.Position = [157 157 108 25];

            % Create TonePitchkHzDropDownLabel
            app.TonePitchkHzDropDownLabel = uilabel(app.Panel_DM);
            app.TonePitchkHzDropDownLabel.FontWeight = 'bold';
            app.TonePitchkHzDropDownLabel.Position = [14 462 114 22];
            app.TonePitchkHzDropDownLabel.Text = 'Tone Pitch (kHz)';

            % Create TonePitchkHzDropDown
            app.TonePitchkHzDropDown = uidropdown(app.Panel_DM);
            app.TonePitchkHzDropDown.Items = {'2', '4', '6', '8', '12', '16', '24', '32'};
            app.TonePitchkHzDropDown.ItemsData = {'1', '2', '3', '4', '6', '8', '12', '16'};
            app.TonePitchkHzDropDown.Tag = 'Tone Pitch';
            app.TonePitchkHzDropDown.Position = [129 462 50 20];
            app.TonePitchkHzDropDown.Value = '1';

            % Create full_panel_training
            app.full_panel_training = uicheckbox(app.Panel_DM);
            app.full_panel_training.Tag = 'Full Panel Training';
            app.full_panel_training.Text = 'Full Panel Trng';
            app.full_panel_training.FontSize = 13;
            app.full_panel_training.FontWeight = 'bold';
            app.full_panel_training.Position = [157 353 116 25];

            % Create Panel_General
            app.Panel_General = uipanel(app.figure1);
            app.Panel_General.FontWeight = 'bold';
            app.Panel_General.Position = [6 9 280 652];

            % Create ExperimentDurationsLabel
            app.ExperimentDurationsLabel = uilabel(app.Panel_General);
            app.ExperimentDurationsLabel.FontWeight = 'bold';
            app.ExperimentDurationsLabel.Position = [11 601 142 22];
            app.ExperimentDurationsLabel.Text = 'Experiment Duration (s)';

            % Create ex_duration
            app.ex_duration = uieditfield(app.Panel_General, 'numeric');
            app.ex_duration.Tag = 'Experiment Duration';
            app.ex_duration.HorizontalAlignment = 'center';
            app.ex_duration.FontWeight = 'bold';
            app.ex_duration.Position = [219 601 50 22];
            app.ex_duration.Value = 900;

            % Create State1TimeoutsLabel
            app.State1TimeoutsLabel = uilabel(app.Panel_General);
            app.State1TimeoutsLabel.FontWeight = 'bold';
            app.State1TimeoutsLabel.Position = [11 575 109 22];
            app.State1TimeoutsLabel.Text = 'State1 Timeout (s)';

            % Create state1_timeout
            app.state1_timeout = uieditfield(app.Panel_General, 'numeric');
            app.state1_timeout.Tag = 'State1 Timeout';
            app.state1_timeout.HorizontalAlignment = 'center';
            app.state1_timeout.FontWeight = 'bold';
            app.state1_timeout.Position = [219 575 50 22];
            app.state1_timeout.Value = 30;

            % Create State3TimeoutsLabel
            app.State3TimeoutsLabel = uilabel(app.Panel_General);
            app.State3TimeoutsLabel.FontWeight = 'bold';
            app.State3TimeoutsLabel.Position = [11 549 109 22];
            app.State3TimeoutsLabel.Text = 'State3 Timeout (s)';

            % Create state3_timeout
            app.state3_timeout = uieditfield(app.Panel_General, 'numeric');
            app.state3_timeout.Tag = 'State3 Timeout';
            app.state3_timeout.HorizontalAlignment = 'center';
            app.state3_timeout.FontWeight = 'bold';
            app.state3_timeout.Position = [219 549 50 22];
            app.state3_timeout.Value = 30;

            % Create NumberofLicksRequiredLabel
            app.NumberofLicksRequiredLabel = uilabel(app.Panel_General);
            app.NumberofLicksRequiredLabel.FontWeight = 'bold';
            app.NumberofLicksRequiredLabel.Position = [11 497 155 22];
            app.NumberofLicksRequiredLabel.Text = 'Number of Licks Required';

            % Create lick_count_requirement
            app.lick_count_requirement = uieditfield(app.Panel_General, 'numeric');
            app.lick_count_requirement.Tag = 'Numner of Licks Required';
            app.lick_count_requirement.HorizontalAlignment = 'center';
            app.lick_count_requirement.FontWeight = 'bold';
            app.lick_count_requirement.Position = [219 497 50 22];
            app.lick_count_requirement.Value = 1;

            % Create LickTimeRequirementLabel
            app.LickTimeRequirementLabel = uilabel(app.Panel_General);
            app.LickTimeRequirementLabel.FontWeight = 'bold';
            app.LickTimeRequirementLabel.Position = [11 471 137 22];
            app.LickTimeRequirementLabel.Text = 'Lick Time Requirement';

            % Create lick_time_requirement
            app.lick_time_requirement = uieditfield(app.Panel_General, 'numeric');
            app.lick_time_requirement.Tag = 'Lick Time Window';
            app.lick_time_requirement.HorizontalAlignment = 'center';
            app.lick_time_requirement.FontWeight = 'bold';
            app.lick_time_requirement.Position = [219 471 50 22];
            app.lick_time_requirement.Value = 1;

            % Create text19_2
            app.text19_2 = uilabel(app.Panel_General);
            app.text19_2.VerticalAlignment = 'top';
            app.text19_2.FontSize = 16;
            app.text19_2.FontWeight = 'bold';
            app.text19_2.Position = [11 625 135 22];
            app.text19_2.Text = 'General Controls';

            % Create Waitbeforestate2or4Label
            app.Waitbeforestate2or4Label = uilabel(app.Panel_General);
            app.Waitbeforestate2or4Label.FontWeight = 'bold';
            app.Waitbeforestate2or4Label.Position = [11 445 137 22];
            app.Waitbeforestate2or4Label.Text = 'Wait before state 2 or 4';

            % Create wait24
            app.wait24 = uieditfield(app.Panel_General, 'numeric');
            app.wait24.Tag = 'Wait Before State 2 or 4';
            app.wait24.HorizontalAlignment = 'center';
            app.wait24.FontWeight = 'bold';
            app.wait24.Position = [219 445 50 22];
            app.wait24.Value = 1.5;

            % Create timeout_punishment
            app.timeout_punishment = uicheckbox(app.Panel_General);
            app.timeout_punishment.Tag = 'Timeout Punishment';
            app.timeout_punishment.Text = 'Timeout Punishment';
            app.timeout_punishment.FontSize = 13;
            app.timeout_punishment.FontWeight = 'bold';
            app.timeout_punishment.Position = [11 416 164 25];

            % Create wrong_lick_punishment
            app.wrong_lick_punishment = uicheckbox(app.Panel_General);
            app.wrong_lick_punishment.Tag = 'Wrong Lick Punishment';
            app.wrong_lick_punishment.Text = 'Wrong Lick Punishment';
            app.wrong_lick_punishment.FontSize = 13;
            app.wrong_lick_punishment.FontWeight = 'bold';
            app.wrong_lick_punishment.Position = [11 387 229 25];

            % Create AirPuffmsLabel
            app.AirPuffmsLabel = uilabel(app.Panel_General);
            app.AirPuffmsLabel.FontWeight = 'bold';
            app.AirPuffmsLabel.Position = [11 361 77 22];
            app.AirPuffmsLabel.Text = 'Air Puff (ms)';

            % Create airpuff_duration
            app.airpuff_duration = uieditfield(app.Panel_General, 'numeric');
            app.airpuff_duration.Tag = 'Air Puff Duration';
            app.airpuff_duration.HorizontalAlignment = 'center';
            app.airpuff_duration.FontWeight = 'bold';
            app.airpuff_duration.Position = [219 361 50 22];
            app.airpuff_duration.Value = 50;

            % Create PunishmentToneTimesLabel
            app.PunishmentToneTimesLabel = uilabel(app.Panel_General);
            app.PunishmentToneTimesLabel.FontWeight = 'bold';
            app.PunishmentToneTimesLabel.Position = [11 335 154 22];
            app.PunishmentToneTimesLabel.Text = 'Punishment Tone Time (s)';

            % Create punishment_tone_time
            app.punishment_tone_time = uieditfield(app.Panel_General, 'numeric');
            app.punishment_tone_time.Tag = 'Punishment Tone Time';
            app.punishment_tone_time.HorizontalAlignment = 'center';
            app.punishment_tone_time.FontWeight = 'bold';
            app.punishment_tone_time.Position = [219 335 50 22];
            app.punishment_tone_time.Value = 1;

            % Create PunishmentRestTimesLabel
            app.PunishmentRestTimesLabel = uilabel(app.Panel_General);
            app.PunishmentRestTimesLabel.FontWeight = 'bold';
            app.PunishmentRestTimesLabel.Position = [11 309 153 22];
            app.PunishmentRestTimesLabel.Text = 'Punishment Rest Time (s)';

            % Create punishment_rest_time
            app.punishment_rest_time = uieditfield(app.Panel_General, 'numeric');
            app.punishment_rest_time.Tag = 'Punishment Rest Time';
            app.punishment_rest_time.HorizontalAlignment = 'center';
            app.punishment_rest_time.FontWeight = 'bold';
            app.punishment_rest_time.Position = [219 309 50 22];
            app.punishment_rest_time.Value = 2;

            % Create BiasCorroftestsLabel
            app.BiasCorroftestsLabel = uilabel(app.Panel_General);
            app.BiasCorroftestsLabel.FontWeight = 'bold';
            app.BiasCorroftestsLabel.Position = [11 39 116 22];
            app.BiasCorroftestsLabel.Text = 'Bias Corr # of tests';

            % Create bias_buffer
            app.bias_buffer = uieditfield(app.Panel_General, 'numeric');
            app.bias_buffer.Tag = 'Bias Correction Number of Tests';
            app.bias_buffer.HorizontalAlignment = 'center';
            app.bias_buffer.FontWeight = 'bold';
            app.bias_buffer.Position = [219 39 50 22];
            app.bias_buffer.Value = 1;

            % Create BiasCorrdiffLabel
            app.BiasCorrdiffLabel = uilabel(app.Panel_General);
            app.BiasCorrdiffLabel.FontWeight = 'bold';
            app.BiasCorrdiffLabel.Position = [11 13 85 22];
            app.BiasCorrdiffLabel.Text = 'Bias Corr  diff';

            % Create bias_diff
            app.bias_diff = uieditfield(app.Panel_General, 'numeric');
            app.bias_diff.Tag = 'Bias Correction Diff';
            app.bias_diff.HorizontalAlignment = 'center';
            app.bias_diff.FontWeight = 'bold';
            app.bias_diff.Position = [219 13 50 22];
            app.bias_diff.Value = 1;

            % Create retrial_mode
            app.retrial_mode = uicheckbox(app.Panel_General);
            app.retrial_mode.Tag = 'Retrial Mode';
            app.retrial_mode.Text = 'Retrial Mode';
            app.retrial_mode.FontSize = 13;
            app.retrial_mode.FontWeight = 'bold';
            app.retrial_mode.Position = [11 254 126 25];

            % Create free_reward
            app.free_reward = uicheckbox(app.Panel_General);
            app.free_reward.Tag = 'Free Reward';
            app.free_reward.Text = 'Free Reward';
            app.free_reward.FontSize = 13;
            app.free_reward.FontWeight = 'bold';
            app.free_reward.Position = [11 199 96 25];

            % Create biason
            app.biason = uicheckbox(app.Panel_General);
            app.biason.Tag = 'Bias Correction Active';
            app.biason.Text = 'Bias Correction Active';
            app.biason.FontSize = 13;
            app.biason.FontWeight = 'bold';
            app.biason.Position = [11 65 229 25];

            % Create PunishmentVolumeLabel
            app.PunishmentVolumeLabel = uilabel(app.Panel_General);
            app.PunishmentVolumeLabel.FontWeight = 'bold';
            app.PunishmentVolumeLabel.Position = [11 283 137 22];
            app.PunishmentVolumeLabel.Text = 'Punishment Volume';

            % Create punishment_volume
            app.punishment_volume = uieditfield(app.Panel_General, 'numeric');
            app.punishment_volume.Tag = 'Punishment Volume';
            app.punishment_volume.HorizontalAlignment = 'center';
            app.punishment_volume.FontWeight = 'bold';
            app.punishment_volume.Position = [219 283 50 22];
            app.punishment_volume.Value = 22;

            % Create ITIminmaxsLabel
            app.ITIminmaxsLabel = uilabel(app.Panel_General);
            app.ITIminmaxsLabel.FontWeight = 'bold';
            app.ITIminmaxsLabel.Position = [11 523 96 22];
            app.ITIminmaxsLabel.Text = 'ITI  min  max (s)';

            % Create iti_max
            app.iti_max = uieditfield(app.Panel_General, 'numeric');
            app.iti_max.Tag = 'ITI Max';
            app.iti_max.HorizontalAlignment = 'center';
            app.iti_max.FontWeight = 'bold';
            app.iti_max.Position = [219 523 50 22];
            app.iti_max.Value = 7;

            % Create iti_min
            app.iti_min = uieditfield(app.Panel_General, 'numeric');
            app.iti_min.Tag = 'ITI Min';
            app.iti_min.HorizontalAlignment = 'center';
            app.iti_min.FontWeight = 'bold';
            app.iti_min.Position = [165 523 50 22];
            app.iti_min.Value = 2;

            % Create PercentretrialrewardsLabel
            app.PercentretrialrewardsLabel = uilabel(app.Panel_General);
            app.PercentretrialrewardsLabel.FontWeight = 'bold';
            app.PercentretrialrewardsLabel.Position = [11 228 137 22];
            app.PercentretrialrewardsLabel.Text = 'Percent retrial rewards';

            % Create percent_retrial_rewards
            app.percent_retrial_rewards = uieditfield(app.Panel_General, 'numeric');
            app.percent_retrial_rewards.ValueChangedFcn = createCallbackFcn(app, @percent_retrial_rewardsValueChanged, true);
            app.percent_retrial_rewards.Tag = 'Percent Retrial Rewards';
            app.percent_retrial_rewards.HorizontalAlignment = 'center';
            app.percent_retrial_rewards.FontWeight = 'bold';
            app.percent_retrial_rewards.Position = [219 228 50 22];
            app.percent_retrial_rewards.Value = 80;

            % Create forced_sequence
            app.forced_sequence = uicheckbox(app.Panel_General);
            app.forced_sequence.Tag = 'Forced Sequence';
            app.forced_sequence.Text = 'Forced Sequence';
            app.forced_sequence.FontSize = 13;
            app.forced_sequence.FontWeight = 'bold';
            app.forced_sequence.Position = [11 169 135 25];

            % Create number_of_lefts
            app.number_of_lefts = uieditfield(app.Panel_General, 'numeric');
            app.number_of_lefts.Tag = 'Number of Lefts';
            app.number_of_lefts.HorizontalAlignment = 'center';
            app.number_of_lefts.FontWeight = 'bold';
            app.number_of_lefts.Position = [71 137 50 22];
            app.number_of_lefts.Value = 5;

            % Create number_of_rights
            app.number_of_rights = uieditfield(app.Panel_General, 'numeric');
            app.number_of_rights.Tag = 'Number of Rights';
            app.number_of_rights.HorizontalAlignment = 'center';
            app.number_of_rights.FontWeight = 'bold';
            app.number_of_rights.Position = [214 137 50 22];
            app.number_of_rights.Value = 5;

            % Create left_first
            app.left_first = uicheckbox(app.Panel_General);
            app.left_first.ValueChangedFcn = createCallbackFcn(app, @left_firstValueChanged, true);
            app.left_first.Tag = 'Left First ';
            app.left_first.Text = 'Left First';
            app.left_first.FontSize = 13;
            app.left_first.FontWeight = 'bold';
            app.left_first.Position = [25 101 82 25];

            % Create right_first
            app.right_first = uicheckbox(app.Panel_General);
            app.right_first.ValueChangedFcn = createCallbackFcn(app, @right_firstValueChanged, true);
            app.right_first.Tag = 'Right First';
            app.right_first.Text = 'Right First';
            app.right_first.FontSize = 13;
            app.right_first.FontWeight = 'bold';
            app.right_first.Position = [174 101 87 25];

            % Create text19_5
            app.text19_5 = uilabel(app.Panel_General);
            app.text19_5.VerticalAlignment = 'top';
            app.text19_5.FontSize = 13;
            app.text19_5.FontWeight = 'bold';
            app.text19_5.Position = [157 135 47 22];
            app.text19_5.Text = '# of R''s';

            % Create text19_6
            app.text19_6 = uilabel(app.Panel_General);
            app.text19_6.VerticalAlignment = 'top';
            app.text19_6.FontSize = 13;
            app.text19_6.FontWeight = 'bold';
            app.text19_6.Position = [20 136 51 22];
            app.text19_6.Text = '# of L''s';

            % Create LoadSettingsButton
            app.LoadSettingsButton = uibutton(app.figure1, 'push');
            app.LoadSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @LoadSettingsButtonPushed, true);
            app.LoadSettingsButton.FontWeight = 'bold';
            app.LoadSettingsButton.Position = [410 114 95 47];
            app.LoadSettingsButton.Text = 'Load Settings';

            % Create SaveSettingsButton
            app.SaveSettingsButton = uibutton(app.figure1, 'push');
            app.SaveSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveSettingsButtonPushed, true);
            app.SaveSettingsButton.FontWeight = 'bold';
            app.SaveSettingsButton.Position = [292 114 94 47];
            app.SaveSettingsButton.Text = 'Save Settings';

            % Create text29_4
            app.text29_4 = uilabel(app.figure1);
            app.text29_4.VerticalAlignment = 'top';
            app.text29_4.FontSize = 13;
            app.text29_4.FontWeight = 'bold';
            app.text29_4.Position = [416 700 63 22];
            app.text29_4.Text = 'L Correct';

            % Create text29_7
            app.text29_7 = uilabel(app.figure1);
            app.text29_7.VerticalAlignment = 'top';
            app.text29_7.FontSize = 13;
            app.text29_7.FontWeight = 'bold';
            app.text29_7.Position = [416 673 87 22];
            app.text29_7.Text = 'R Correct';

            % Create RatesTextAreaLabel
            app.RatesTextAreaLabel = uilabel(app.figure1);
            app.RatesTextAreaLabel.HorizontalAlignment = 'right';
            app.RatesTextAreaLabel.FontSize = 10;
            app.RatesTextAreaLabel.Position = [910 517 32 22];
            app.RatesTextAreaLabel.Text = 'Rates';

            % Create RatesTextArea
            app.RatesTextArea = uitextarea(app.figure1);
            app.RatesTextArea.FontSize = 10;
            app.RatesTextArea.Position = [881 311 326 230];

            % Create arates
            app.arates = uilabel(app.figure1);
            app.arates.VerticalAlignment = 'top';
            app.arates.FontSize = 13;
            app.arates.FontWeight = 'bold';
            app.arates.Position = [999 545 84 22];
            app.arates.Text = 'Active Rates';

            % Create Spout1_RestLabel
            app.Spout1_RestLabel = uilabel(app.figure1);
            app.Spout1_RestLabel.FontWeight = 'bold';
            app.Spout1_RestLabel.Position = [525 104 79 22];
            app.Spout1_RestLabel.Text = 'Spout1_Rest';

            % Create sp1rest
            app.sp1rest = uieditfield(app.figure1, 'numeric');
            app.sp1rest.Tag = 'Spout 1 Rest Position';
            app.sp1rest.HorizontalAlignment = 'center';
            app.sp1rest.FontWeight = 'bold';
            app.sp1rest.Position = [611 104 50 22];
            app.sp1rest.Value = 11;

            % Create Spout1_ExtLabel
            app.Spout1_ExtLabel = uilabel(app.figure1);
            app.Spout1_ExtLabel.FontWeight = 'bold';
            app.Spout1_ExtLabel.Position = [525 76 72 22];
            app.Spout1_ExtLabel.Text = 'Spout1_Ext';

            % Create sp1ext
            app.sp1ext = uieditfield(app.figure1, 'numeric');
            app.sp1ext.Tag = 'Spout 1 Extended Position';
            app.sp1ext.HorizontalAlignment = 'center';
            app.sp1ext.FontWeight = 'bold';
            app.sp1ext.Position = [611 76 50 22];
            app.sp1ext.Value = 16;

            % Create Spout2_RestLabel
            app.Spout2_RestLabel = uilabel(app.figure1);
            app.Spout2_RestLabel.FontWeight = 'bold';
            app.Spout2_RestLabel.Position = [525 48 79 22];
            app.Spout2_RestLabel.Text = 'Spout2_Rest';

            % Create sp2rest
            app.sp2rest = uieditfield(app.figure1, 'numeric');
            app.sp2rest.Tag = 'Spout 2 Rest Position';
            app.sp2rest.HorizontalAlignment = 'center';
            app.sp2rest.FontWeight = 'bold';
            app.sp2rest.Position = [611 48 50 22];
            app.sp2rest.Value = 11;

            % Create Spout2_ExtLabel
            app.Spout2_ExtLabel = uilabel(app.figure1);
            app.Spout2_ExtLabel.FontWeight = 'bold';
            app.Spout2_ExtLabel.Position = [525 20 72 22];
            app.Spout2_ExtLabel.Text = 'Spout2_Ext';

            % Create sp2ext
            app.sp2ext = uieditfield(app.figure1, 'numeric');
            app.sp2ext.Tag = 'Spout 2 Extended Position';
            app.sp2ext.HorizontalAlignment = 'center';
            app.sp2ext.FontWeight = 'bold';
            app.sp2ext.Position = [611 20 50 22];
            app.sp2ext.Value = 16;

            % Create L_lick
            app.L_lick = uibutton(app.figure1, 'push');
            app.L_lick.ButtonPushedFcn = createCallbackFcn(app, @L_lickButtonPushed, true);
            app.L_lick.FontSize = 13;
            app.L_lick.FontWeight = 'bold';
            app.L_lick.Position = [303 78 60 30];
            app.L_lick.Text = 'L';

            % Create C_lick
            app.C_lick = uibutton(app.figure1, 'push');
            app.C_lick.ButtonPushedFcn = createCallbackFcn(app, @C_lickButtonPushed, true);
            app.C_lick.FontSize = 13;
            app.C_lick.FontWeight = 'bold';
            app.C_lick.Position = [303 44 60 30];
            app.C_lick.Text = 'C';

            % Create R_lick
            app.R_lick = uibutton(app.figure1, 'push');
            app.R_lick.ButtonPushedFcn = createCallbackFcn(app, @R_lickButtonPushed, true);
            app.R_lick.FontSize = 13;
            app.R_lick.FontWeight = 'bold';
            app.R_lick.Position = [303 10 60 30];
            app.R_lick.Text = 'R';

            % Create text29_8
            app.text29_8 = uilabel(app.figure1);
            app.text29_8.VerticalAlignment = 'top';
            app.text29_8.FontSize = 13;
            app.text29_8.FontWeight = 'bold';
            app.text29_8.Position = [312 701 51 22];
            app.text29_8.Text = 'L Trials';

            % Create text29_9
            app.text29_9 = uilabel(app.figure1);
            app.text29_9.VerticalAlignment = 'top';
            app.text29_9.FontSize = 13;
            app.text29_9.FontWeight = 'bold';
            app.text29_9.Position = [312 674 87 22];
            app.text29_9.Text = 'R Trials';

            % Create LTrials
            app.LTrials = uilabel(app.figure1);
            app.LTrials.VerticalAlignment = 'top';
            app.LTrials.FontSize = 16;
            app.LTrials.FontWeight = 'bold';
            app.LTrials.Position = [382 701 29 22];
            app.LTrials.Text = '0';

            % Create RTrials
            app.RTrials = uilabel(app.figure1);
            app.RTrials.VerticalAlignment = 'top';
            app.RTrials.FontSize = 16;
            app.RTrials.FontWeight = 'bold';
            app.RTrials.Position = [383 675 29 22];
            app.RTrials.Text = '0';

            % Create LCorrect
            app.LCorrect = uilabel(app.figure1);
            app.LCorrect.VerticalAlignment = 'top';
            app.LCorrect.FontSize = 16;
            app.LCorrect.FontWeight = 'bold';
            app.LCorrect.Position = [502 700 29 22];
            app.LCorrect.Text = '0';

            % Create RCorrect
            app.RCorrect = uilabel(app.figure1);
            app.RCorrect.VerticalAlignment = 'top';
            app.RCorrect.FontSize = 16;
            app.RCorrect.FontWeight = 'bold';
            app.RCorrect.Position = [503 674 29 22];
            app.RCorrect.Text = '0';

            % Create text29_10
            app.text29_10 = uilabel(app.figure1);
            app.text29_10.VerticalAlignment = 'top';
            app.text29_10.FontSize = 13;
            app.text29_10.FontWeight = 'bold';
            app.text29_10.Position = [562 699 82 22];
            app.text29_10.Text = 'LRetr/InCorr';

            % Create text29_11
            app.text29_11 = uilabel(app.figure1);
            app.text29_11.VerticalAlignment = 'top';
            app.text29_11.FontSize = 13;
            app.text29_11.FontWeight = 'bold';
            app.text29_11.Position = [564 672 87 22];
            app.text29_11.Text = 'RRetr/InCorr';

            % Create LReTrials
            app.LReTrials = uilabel(app.figure1);
            app.LReTrials.VerticalAlignment = 'top';
            app.LReTrials.FontSize = 16;
            app.LReTrials.FontWeight = 'bold';
            app.LReTrials.Position = [658 699 29 22];
            app.LReTrials.Text = '0';

            % Create RReTrials
            app.RReTrials = uilabel(app.figure1);
            app.RReTrials.VerticalAlignment = 'top';
            app.RReTrials.FontSize = 16;
            app.RReTrials.FontWeight = 'bold';
            app.RReTrials.Position = [659 673 29 22];
            app.RReTrials.Text = '0';

            % Create linear
            app.linear = uicheckbox(app.figure1);
            app.linear.ValueChangedFcn = createCallbackFcn(app, @linearValueChanged, true);
            app.linear.Text = 'Linear';
            app.linear.FontSize = 13;
            app.linear.FontWeight = 'bold';
            app.linear.Position = [659 145 71 25];

            % Create servo
            app.servo = uicheckbox(app.figure1);
            app.servo.ValueChangedFcn = createCallbackFcn(app, @servoValueChanged, true);
            app.servo.Text = 'Servo';
            app.servo.FontSize = 13;
            app.servo.FontWeight = 'bold';
            app.servo.Position = [756 144 71 25];

            % Create InputFilePanel
            app.InputFilePanel = uipanel(app.figure1);
            app.InputFilePanel.Title = 'Input File';
            app.InputFilePanel.FontWeight = 'bold';
            app.InputFilePanel.FontSize = 16;
            app.InputFilePanel.Position = [873 573 356 95];

            % Create usefile
            app.usefile = uicheckbox(app.InputFilePanel);
            app.usefile.Tag = 'Use File for Input Sequence Control';
            app.usefile.Text = 'Use File for Input Sequence Control';
            app.usefile.FontSize = 13;
            app.usefile.FontWeight = 'bold';
            app.usefile.Position = [12 41 240 25];

            % Create input_filename
            app.input_filename = uieditfield(app.InputFilePanel, 'text');
            app.input_filename.Tag = 'File Name';
            app.input_filename.HorizontalAlignment = 'center';
            app.input_filename.FontSize = 13;
            app.input_filename.FontWeight = 'bold';
            app.input_filename.Position = [84 6 245 25];

            % Create text19_4
            app.text19_4 = uilabel(app.InputFilePanel);
            app.text19_4.VerticalAlignment = 'top';
            app.text19_4.FontSize = 13;
            app.text19_4.FontWeight = 'bold';
            app.text19_4.Position = [11 8 68 22];
            app.text19_4.Text = 'Filename';

            % Create dir_input_file
            app.dir_input_file = uibutton(app.InputFilePanel, 'push');
            app.dir_input_file.ButtonPushedFcn = createCallbackFcn(app, @dir_input_fileButtonPushed, true);
            app.dir_input_file.FontSize = 16;
            app.dir_input_file.FontWeight = 'bold';
            app.dir_input_file.Position = [259 39 88 26];
            app.dir_input_file.Text = 'Open File';

            % Show the figure after all components are created
            app.figure1.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = HERBs_2AFC

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.figure1)

            % Execute the startup function
            runStartupFcn(app, @main_OpeningFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.figure1)
        end
    end
end