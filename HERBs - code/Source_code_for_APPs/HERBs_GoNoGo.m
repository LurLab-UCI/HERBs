classdef HERBs_GoNoGo < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure1                         matlab.ui.Figure
        brightness                      matlab.ui.control.NumericEditField
        BrightnessLabel                 matlab.ui.control.Label
        trial_text                      matlab.ui.control.Label
        statetext                       matlab.ui.control.Label
        FALabel                         matlab.ui.control.Label
        CRLabel                         matlab.ui.control.Label
        MISSLabel                       matlab.ui.control.Label
        HITLabel                        matlab.ui.control.Label
        uipanel3_3                      matlab.ui.container.Panel
        timemsLabel                     matlab.ui.control.Label
        reward_pulse_C                  matlab.ui.control.NumericEditField
        valve_on_off                    matlab.ui.control.Button
        reward                          matlab.ui.control.Button
        uipanel3_2                      matlab.ui.container.Panel
        disable_center_spout            matlab.ui.control.CheckBox
        sp2ext                          matlab.ui.control.NumericEditField
        sp2rest                         matlab.ui.control.NumericEditField
        locationLabel_2                 matlab.ui.control.Label
        full_out_2                      matlab.ui.control.Button
        rest_2                          matlab.ui.control.Button
        SpoutsLRLabel                   matlab.ui.control.Label
        full_retract_2                  matlab.ui.control.Button
        SpoutCLabel                     matlab.ui.control.Label
        servo                           matlab.ui.control.CheckBox
        linear                          matlab.ui.control.CheckBox
        locationLabel                   matlab.ui.control.Label
        sp1ext                          matlab.ui.control.NumericEditField
        sp1rest                         matlab.ui.control.NumericEditField
        full_out                        matlab.ui.control.Button
        full_retract                    matlab.ui.control.Button
        rest                            matlab.ui.control.Button
        StimulusPanel_2                 matlab.ui.container.Panel
        stripe_bar_thickness_nogo       matlab.ui.control.DropDown
        StripeBarThicknessDropDownLabel_2  matlab.ui.control.Label
        StimulussideButtonGroup_4       matlab.ui.container.ButtonGroup
        stimulus_side_right_nogo        matlab.ui.control.RadioButton
        stimulus_side_left_nogo         matlab.ui.control.RadioButton
        audio_stimulus_type_nogo        matlab.ui.control.DropDown
        auditorystimtypeDropDown_2Label  matlab.ui.control.Label
        audio_tone_pitch_nogo           matlab.ui.control.DropDown
        TonePitchkHzDropDown_4Label     matlab.ui.control.Label
        audio_stimulation_frequency_nogo  matlab.ui.control.NumericEditField
        StimulationfreqHzLabel_7        matlab.ui.control.Label
        audio_volume_nogo               matlab.ui.control.NumericEditField
        VolumeLabel_6                   matlab.ui.control.Label
        StimulusdurationmsLabel_7       matlab.ui.control.Label
        audio_stimulus_duration_nogo    matlab.ui.control.NumericEditField
        auditory_active_nogo            matlab.ui.control.CheckBox
        visual_active_nogo              matlab.ui.control.CheckBox
        stimulation_type_visual_nogo    matlab.ui.control.DropDown
        visstimtypeDropDown_2Label      matlab.ui.control.Label
        StimulationfreqHzLabel_6        matlab.ui.control.Label
        stimulation_frequency_visual_nogo  matlab.ui.control.NumericEditField
        stimulus_duration_visual_nogo   matlab.ui.control.NumericEditField
        StimulusdurationmsLabel_6       matlab.ui.control.Label
        line_delay_nogo                 matlab.ui.control.NumericEditField
        SpeedlinedelaymsLabel_2         matlab.ui.control.Label
        NOGoStimulusLabel               matlab.ui.control.Label
        GeneralControlsPanel            matlab.ui.container.Panel
        stim_start_delay_number_of_steps  matlab.ui.control.NumericEditField
        stim_start_delay_min            matlab.ui.control.NumericEditField
        cr_rule                         matlab.ui.control.CheckBox
        early_lick_reset                matlab.ui.control.CheckBox
        start_tone_pitch                matlab.ui.control.DropDown
        StartTonePitchkHzDropDownLabel  matlab.ui.control.Label
        start_tone_volume               matlab.ui.control.NumericEditField
        VolumeLabel_7                   matlab.ui.control.Label
        secLabel                        matlab.ui.control.Label
        punishment_volume               matlab.ui.control.NumericEditField
        PunishmentVolumeLabel           matlab.ui.control.Label
        WaitAfterLicksLabel             matlab.ui.control.Label
        wait_after_lick_time            matlab.ui.control.NumericEditField
        delay_period_number_of_steps    matlab.ui.control.NumericEditField
        delay_period_max                matlab.ui.control.NumericEditField
        punishment_timeout              matlab.ui.control.NumericEditField
        PunishmentTimeoutsLabel         matlab.ui.control.Label
        punishment_tone_frequency       matlab.ui.control.DropDown
        punishmentTonekHzLabel          matlab.ui.control.Label
        punishment_duration             matlab.ui.control.NumericEditField
        DurationsLabel_2                matlab.ui.control.Label
        trial_start_signal              matlab.ui.control.DropDown
        TrialStartSignalDropDownLabel   matlab.ui.control.Label
        start_signal_duration           matlab.ui.control.NumericEditField
        DurationsLabel                  matlab.ui.control.Label
        punishment_signal               matlab.ui.control.DropDown
        PunishmentSignalDropDownLabel   matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        lick_time                       matlab.ui.control.NumericEditField
        PercentageofCatchTrialsLabel    matlab.ui.control.Label
        percentage_of_catch_trials      matlab.ui.control.NumericEditField
        free_reward                     matlab.ui.control.CheckBox
        number_of_licks_required        matlab.ui.control.NumericEditField
        NumberofLicksLabel              matlab.ui.control.Label
        response_window                 matlab.ui.control.NumericEditField
        ResponseWindowsLabel            matlab.ui.control.Label
        delay_period_min                matlab.ui.control.NumericEditField
        DelayPeriodsLabel               matlab.ui.control.Label
        stim_start_delay_max            matlab.ui.control.NumericEditField
        StimStartDelaysLabel            matlab.ui.control.Label
        MaxWindowofNoResponsessLabel    matlab.ui.control.Label
        max_window_of_no_responses      matlab.ui.control.NumericEditField
        PercentageofGoTrialsLabel       matlab.ui.control.Label
        percentage_of_go_trials         matlab.ui.control.NumericEditField
        short_iti_max                   matlab.ui.control.NumericEditField
        ShortITIminmaxsLabel            matlab.ui.control.Label
        iti_max                         matlab.ui.control.NumericEditField
        ITIminmaxsLabel                 matlab.ui.control.Label
        ex_duration                     matlab.ui.control.NumericEditField
        ExperimentDurationsLabel        matlab.ui.control.Label
        short_iti_min                   matlab.ui.control.NumericEditField
        iti_min                         matlab.ui.control.NumericEditField
        lick                            matlab.ui.control.Button
        SaveSettingsButton              matlab.ui.control.Button
        LoadSettingsButton              matlab.ui.control.Button
        StimulusPanel                   matlab.ui.container.Panel
        stimulation_type_visual_go      matlab.ui.control.DropDown
        visstimtypeDropDown_2Label_2    matlab.ui.control.Label
        stripe_bar_thickness_go         matlab.ui.control.DropDown
        StripeBarThicknessDropDownLabel  matlab.ui.control.Label
        StimulussideButtonGroup_3       matlab.ui.container.ButtonGroup
        stimulus_side_right_go          matlab.ui.control.RadioButton
        stimulus_side_left_go           matlab.ui.control.RadioButton
        audio_stimulus_type_go          matlab.ui.control.DropDown
        auditorystimtypeDropDownLabel   matlab.ui.control.Label
        audio_tone_pitch_go             matlab.ui.control.DropDown
        TonePitchkHzDropDown_3Label     matlab.ui.control.Label
        audio_stimulation_frequency_go  matlab.ui.control.NumericEditField
        StimulationfreqHzLabel_5        matlab.ui.control.Label
        audio_volume_go                 matlab.ui.control.NumericEditField
        VolumeLabel_5                   matlab.ui.control.Label
        StimulusdurationmsLabel_5       matlab.ui.control.Label
        audio_stimulus_duration_go      matlab.ui.control.NumericEditField
        auditory_active_go              matlab.ui.control.CheckBox
        visual_active_go                matlab.ui.control.CheckBox
        StimulationfreqHzLabel_2        matlab.ui.control.Label
        stimulation_frequency_visual_go  matlab.ui.control.NumericEditField
        stimulus_duration_visual_go     matlab.ui.control.NumericEditField
        StimulusdurationmsLabel_2       matlab.ui.control.Label
        line_delay_go                   matlab.ui.control.NumericEditField
        SpeedlinedelaymsLabel           matlab.ui.control.Label
        GoStimulusLabel                 matlab.ui.control.Label
        write                           matlab.ui.control.Button
        uipanel4                        matlab.ui.container.Panel
        test                            matlab.ui.control.Button
        flashc                          matlab.ui.control.Button
        flashr                          matlab.ui.control.Button
        flashl                          matlab.ui.control.Button
        uipanel3                        matlab.ui.container.Panel
        vol_2                           matlab.ui.control.Button
        vol                             matlab.ui.control.Button
        tonel                           matlab.ui.control.Button
        toner                           matlab.ui.control.Button
        text36                          matlab.ui.control.Label
        presentation_number             matlab.ui.control.Label
        text26                          matlab.ui.control.Label
        notes                           matlab.ui.control.EditField
        dir                             matlab.ui.control.Button
        text19                          matlab.ui.control.Label
        animalid                        matlab.ui.control.EditField
        start                           matlab.ui.control.Button
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function main_OpeningFcn(app)
            
              if isfile([pwd filesep 'gui_settings_gonogo.mat'])
                    loadStatus(app,[pwd filesep 'gui_settings_gonogo.mat']);
              else
                    loadStatus(app,[pwd filesep 'gui_default_settings_gonogo.mat']);
              end
            
              addpath(genpath(['.' filesep 'general' filesep]));
%               addpath(genpath(['.' filesep 'DM' filesep]));
              addpath(genpath(['.' filesep 'gonogo' filesep]));

              app.figure1.Name = 'HERBs - Go/NoGo';
              app.start.Visible = 'off';
              app.start.Visible = 'on';
              app.start.Enable = 'on';
              init_gonogo(app);
              
        end

        % Callback function
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
            if 0 % app.allleds.Value
                light_Callback(1,4);  % page 4 all leds on
                pause(0.25);
                light_Callback(1,7);
            else
                if 1
            light_Callback(1,0);
            pause(0.25);
            light_Callback(1,7);  % turn off
            light_Callback(1,1);
            pause(0.25);
            light_Callback(1,7);  % turn off
                else
            light_Callback(1,5);
            pause(1.25);
            light_Callback(1,7);  % turn off
                end
            end
        end

        % Button pushed function: flashl
        function flashl_Callback(app, event)
            if  0% app.allleds.Value
                light_Callback(0,5);
                light_Callback(0,4);  % page 4 all leds on
                pause(0.25);
                light_Callback(0,7);
%             elseif app.light2.Value
%                 light_Callback(0,5);
%                 pause(0.25);
%                 light_Callback(0,7);
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
            if  0 %app.allleds.Value
                light_Callback(2,5);
                light_Callback(2,4);  % page 4 all leds on
                pause(0.25);
                light_Callback(2,7);
%             elseif  app.light2.Value
%                 light_Callback(2,5);
%                 pause(0.25);
%                 light_Callback(2,7); % turn off
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

        % Callback function
        function light2_Callback(app, event)
            if app.light2.Value
               app.light2.Value = 1;
               app.light8.Value = 0;
            else
               app.light2.Value = 0;
               app.light8.Value = 1;
            end
        end

        % Callback function
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

        % Callback function
        function stop_Callback(app, event)
            global run;
            
            run = 0;
        end

        % Button pushed function: test
        function test_Callback(app, event)
            global arduino;
           
           light_Callback(0,0);
            pause(0.3);
           light_Callback(0,1);
            pause(0.3);
           light_Callback(0,2);
            pause(0.3);
           light_Callback(0,3);
            pause(0.3);
           light_Callback(0,4);
            pause(0.3);
           light_Callback(0,5);
            pause(0.3);
           light_Callback(0,6);
            pause(0.3);
           light_Callback(0,7);
            pause(0.3);

          
            
           light_Callback(1,0);
            pause(0.3);
           light_Callback(1,1);
            pause(0.3);
           light_Callback(1,2);
            pause(0.3);
           light_Callback(1,3);
            pause(0.3);
           light_Callback(1,4);
            pause(0.3);
           light_Callback(1,5);
            pause(0.3);
           light_Callback(1,6);
            pause(0.3);
           light_Callback(1,7);
            pause(0.3);

                        
           light_Callback(2,0);
            pause(0.3);
           light_Callback(2,1);
            pause(0.3);
           light_Callback(2,2);
            pause(0.3);
           light_Callback(2,3);
            pause(0.3);
           light_Callback(2,4);
            pause(0.3);
           light_Callback(2,5);
            pause(0.3);
           light_Callback(2,6);
            pause(0.3);
           light_Callback(2,7);
            pause(0.3);

          

         

        end

        % Button pushed function: tonel
        function tonel_Callback(app, event)
            global arduino;

            tf = round(str2double(app.start_tone_pitch.Value));
            if strfind(app.tonel.Text,'ON') ~= 0
               app.tonel.Text = 'L OFF';
%                if app.white_noise.Value
               if strcmp(app.trial_start_signal.Value,'noise')
                   write(arduino,['=' tf 'e' 1 2 30],"uint8");
               else
                   write(arduino,['=' tf 'e' 1 1 30],"uint8");
               end
            else
               write(arduino,['=' tf 'e' 1 0 0],"uint8");
                app.tonel.Text = 'L ON';
            end
        end

        % Button pushed function: toner
        function toner_Callback(app, event)
            global arduino;

            tf = round(str2double(app.start_tone_pitch.Value));
            if strfind(app.toner.Text,'ON') ~= 0
               app.toner.Text = 'R OFF';
               if strcmp(app.trial_start_signal.Value,'noise')
%                if app.white_noise.Value
                   write(arduino,['=' tf  'e' 2 2 20],"uint8");
               else
                   write(arduino,['=' tf  'e' 2 1 20],"uint8");
               end
            else
               write(arduino,['=' tf 'e' 2 0 0],"uint8");
                app.toner.Text = 'R ON';
            end
        end

        % Callback function
        function torest_Callback(app, event)
            global spout1pos;
            % set bit spouts to rest position
            control_spouts_gonogo(spout1pos.rest,0,app);
        end

        % Button pushed function: vol
        function vol_Callback(app, event)
            global arduino;
            global audio_volume;
            
%             write(arduino,'a');
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
                app.trial_text.Text = '';
                return;
            end
                
            app.start.Text = 'Stop';        
            start_gonogo(app);      
            
            app.start.Text = 'Start';
            run = 0;

        end

        % Value changed function: line_delay_go
        function line_delay_goValueChanged(app, event)
            global arduino;
            
            write(arduino,['{' round(app.line_delay_go.Value)],"uint8");
            
        end

        % Close request function: figure1
        function figure1CloseRequest(app, event)
% spouts to full retract              
              control_spouts_gonogo(0,0,app);
              control_spouts_gonogo(0,1,app);
           
              saveStatus(app,[pwd filesep 'gui_settings_gonogo.mat']);
              delete(app);
%               delete(instrfindall);
            
        end

        % Value changed function: brightness
        function brightnessValueChanged(app, event)
            global arduino;
            
%             write(arduino,'}');
%             write(arduino,round(app.brightness.Value));
%             write(arduino,0); % do not initialize panels
            write(arduino,['}' round(app.brightness.Value) 0],"uint8"); % do not initialize panels
            
            
        end

        % Button pushed function: vol_2
        function vol_2ButtonPushed(app, event)
            global arduino;
            global audio_volume;
            
%             write(arduino,'a');
            audio_volume = audio_volume - 1;
            audio_volume = max(audio_volume,0);
%             write(arduino,audio_volume);
            write(arduino,['a' audio_volume],"uint8");
            fprintf('audio volume = %d \n',audio_volume);
            
        end

        % Callback function
        function StopButtonPushed(app, event)
            global run;
            run = 0;
        end

        % Callback function
        function SSValueChanged(app, event)
            app.SS.Value = 1;
%             set_backgrounds(app);
            
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
        function smallValueChanged(app, event)
            app.small.Value = 1;
            app.full.Value = 0;
            app.single.Value = 0;
            app.double.Value = 0;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.combo.Value = 0;

        end

        % Callback function
        function fullValueChanged(app, event)
            app.full.Value = 1;
            app.small.Value = 0;
            app.single.Value = 0;
            app.double.Value = 0;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.combo.Value = 0;
           
        end

        % Callback function
        function singleValueChanged(app, event)
            app.single.Value = 1;
            app.small.Value = 0;
            app.full.Value = 0;
            app.double.Value = 0;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.combo.Value = 0;

        end

        % Callback function
        function ButtonPushed(app, event)
            start_stimulus_with_delay(app);
        end

        % Callback function
        function DM_brightness_volumeValueChanged(app, event)
            value = app.DM_brightness_volume.Value;
            global arduino;
            v  = event.Value;
            write(arduino,['}' v 1],"uint8");  % 

            
        end

        % Callback function
        function doubleValueChanged(app, event)
            app.double.Value = 1;
            app.small.Value = 0;
            app.full.Value = 0;
            app.single.Value = 0;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.combo.Value = 0;
            
        end

        % Callback function
        function white_noiseValueChanged(app, event)
            app.white_noise.Value = 1;
            app.tone.Value = 0;
            
        end

        % Callback function
        function toneValueChanged(app, event)
            app.tone.Value = 1;
            app.white_noise.Value = 0;
            
        end

        % Callback function
        function visual_onlyValueChanged(app, event)
            app.visual_only.Value = 1;
            app.auditory_only.Value = 0;
            app.visual_and_auditory.Value = 0;
            
        end

        % Callback function
        function auditory_onlyValueChanged(app, event)
            app.auditory_only.Value = 1;
            app.visual_only.Value = 0;
            app.visual_and_auditory.Value = 0;
            
        end

        % Callback function
        function visual_and_auditoryValueChanged(app, event)
            app.visual_and_auditory.Value = 1;
            app.auditory_only.Value = 0;
            app.visual_only.Value = 0;
            
        end

        % Callback function
        function stim_sides_sameValueChanged(app, event)
            app.stim_sides_same.Value = 1;
            app.stim_sides_opposite.Value = 0;
            app.stim_sides_alternating.Value = 0;
            
        end

        % Callback function
        function stim_sides_oppositeValueChanged(app, event)
            app.stim_sides_opposite.Value = 1;
            app.stim_sides_alternating.Value = 0;
            app.stim_sides_same.Value = 0;
            
        end

        % Callback function
        function stim_sides_alternatingValueChanged(app, event)
            app.stim_sides_alternating.Value = 1;
            app.stim_sides_same.Value = 0;
            app.stim_sides_opposite.Value = 0;
            
        end

        % Callback function
        function visual_stable_auditory_alternatingValueChanged(app, event)
            app.visual_stable_auditory_alternating.Value = 1;
            app.auditory_stable_visual_alternating.Value = 0;
            
        end

        % Callback function
        function auditory_stable_visual_alternatingValueChanged(app, event)
            app.auditory_stable_visual_alternating.Value = 1;
            app.visual_stable_auditory_alternating.Value = 0;
            
        end

        % Button pushed function: lick
        function lickButtonPushed(app, event)
             global  lick_detected;
%             write(arduino,'^');
                global sdata;
           
             sdata = [108 99 67];
             sdata = char(sdata);
             fprintf('%3.3f lcC\n',toc); 
             lick_detected = 1;
           
        end

        % Value changed function: visual_active_go
        function visual_active_goValueChanged(app, event)
            value = app.visual_active_go.Value;
            if value
                app.auditory_active_go.Value = 0;
            else
                app.auditory_active_go.Value = 1;
            end
            
        end

        % Value changed function: auditory_active_go
        function auditory_active_goValueChanged(app, event)
            value = app.auditory_active_go.Value;
            if value
                app.visual_active_go.Value = 0;
            else
                app.visual_active_go.Value = 1;
            end
            
        end

        % Button pushed function: rest
        function restButtonPushed(app, event)
            global spout1pos;
            % set bit spouts to rest position
            spout1pos.ext = app.sp1ext.Value;
%             spout2pos.ext = app.sp2ext.Value;
            spout1pos.rest = app.sp1rest.Value;
%             spout2pos.rest = app.sp2rest.Value;
            
            control_spouts_gonogo(spout1pos.rest,0,app);
            
        end

        % Value changed function: visual_active_nogo
        function visual_active_nogoValueChanged(app, event)
            value = app.visual_active_nogo.Value;
            if value
                app.auditory_active_nogo.Value = 0;
            else
                app.auditory_active_nogo.Value = 1;
            end
 
        end

        % Value changed function: auditory_active_nogo
        function auditory_active_nogoValueChanged(app, event)
            value = app.auditory_active_nogo.Value;
            if value
                app.visual_active_nogo.Value = 0;
            else
                app.visual_active_npgo.Value = 1;
            end
            
        end

        % Button pushed function: full_retract
        function full_retractButtonPushed(app, event)
            control_spouts_gonogo(0,0,app);
           
        end

        % Button pushed function: full_out
        function full_outButtonPushed(app, event)
            global spout1pos;
            
            spout1pos.ext = app.sp1ext.Value;
%             spout2pos.ext = app.sp2ext.Value;
            spout1pos.rest = app.sp1rest.Value;
%             spout2pos.rest = app.sp2rest.Value;
            
            control_spouts_gonogo(spout1pos.ext,0,app);
            
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

        % Button pushed function: reward
        function rewardButtonPushed(app, event)
            reward_Callback(app,'C');
        end

        % Button pushed function: valve_on_off
        function valve_on_offButtonPushed(app, event)
            global arduino;
            if contains(app.valve_on_off.Text,'Open')
                write(arduino,['k' 1 1],"uint8");
                app.valve_on_off.Text = 'Close Valve C';
            else
                write(arduino,['k' 1 0],"uint8");
                app.valve_on_off.Text = 'Open Valve C';
            end

        end

        % Button pushed function: full_retract_2
        function full_retract_2ButtonPushed(app, event)
            control_spouts_gonogo(0,1,app);
            
        end

        % Button pushed function: rest_2
        function rest_2ButtonPushed(app, event)
            global spout2pos;
            % set bit spouts to rest position
            spout2pos.ext = app.sp2ext.Value;
            spout2pos.rest = app.sp2rest.Value;
            
            control_spouts_gonogo(spout2pos.rest,1,app);
            
            
        end

        % Button pushed function: full_out_2
        function full_out_2ButtonPushed(app, event)
            global spout2pos;
            
            spout2pos.ext = app.sp2ext.Value;
            spout2pos.rest = app.sp2rest.Value;
            
            control_spouts_gonogo(spout2pos.ext,1,app);
            
        end

        % Value changed function: reward_pulse_C
        function reward_pulse_CValueChanged(app, event)
            global arduino;
            value = app.reward_pulse_C.Value;
            write(arduino,['q' value],"uint8");
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure1 and hide until all components are created
            app.figure1 = uifigure('Visible', 'off');
            app.figure1.Position = [100 100 1228 802];
            app.figure1.Name = 'main';
            app.figure1.Resize = 'off';
            app.figure1.CloseRequestFcn = createCallbackFcn(app, @figure1CloseRequest, true);

            % Create start
            app.start = uibutton(app.figure1, 'push');
            app.start.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);
            app.start.FontSize = 21;
            app.start.FontWeight = 'bold';
            app.start.Position = [396 66 125 46];
            app.start.Text = 'Start';

            % Create animalid
            app.animalid = uieditfield(app.figure1, 'text');
            app.animalid.HorizontalAlignment = 'center';
            app.animalid.FontSize = 13;
            app.animalid.FontWeight = 'bold';
            app.animalid.Position = [605 754 409 25];

            % Create text19
            app.text19 = uilabel(app.figure1);
            app.text19.VerticalAlignment = 'top';
            app.text19.FontSize = 13;
            app.text19.FontWeight = 'bold';
            app.text19.Position = [528 758 68 16];
            app.text19.Text = 'Animal ID';

            % Create dir
            app.dir = uibutton(app.figure1, 'push');
            app.dir.ButtonPushedFcn = createCallbackFcn(app, @dir_Callback, true);
            app.dir.FontSize = 16;
            app.dir.FontWeight = 'bold';
            app.dir.Position = [1036 756 68 23];
            app.dir.Text = 'Dir';

            % Create notes
            app.notes = uieditfield(app.figure1, 'text');
            app.notes.HorizontalAlignment = 'center';
            app.notes.FontSize = 13;
            app.notes.FontWeight = 'bold';
            app.notes.Position = [605 721 409 25];

            % Create text26
            app.text26 = uilabel(app.figure1);
            app.text26.VerticalAlignment = 'top';
            app.text26.FontSize = 13;
            app.text26.FontWeight = 'bold';
            app.text26.Position = [538 725 48 16];
            app.text26.Text = 'Notes';

            % Create presentation_number
            app.presentation_number = uilabel(app.figure1);
            app.presentation_number.HorizontalAlignment = 'center';
            app.presentation_number.VerticalAlignment = 'top';
            app.presentation_number.FontSize = 27;
            app.presentation_number.FontWeight = 'bold';
            app.presentation_number.Position = [227 741 44 32];
            app.presentation_number.Text = '0';

            % Create text36
            app.text36 = uilabel(app.figure1);
            app.text36.VerticalAlignment = 'top';
            app.text36.FontSize = 13;
            app.text36.FontWeight = 'bold';
            app.text36.Position = [217 712 95 22];
            app.text36.Text = 'Presentation #';

            % Create uipanel3
            app.uipanel3 = uipanel(app.figure1);
            app.uipanel3.Title = 'Tone Test';
            app.uipanel3.FontWeight = 'bold';
            app.uipanel3.FontSize = 13;
            app.uipanel3.Position = [666 65 131 107];

            % Create toner
            app.toner = uibutton(app.uipanel3, 'push');
            app.toner.ButtonPushedFcn = createCallbackFcn(app, @toner_Callback, true);
            app.toner.FontSize = 13;
            app.toner.FontWeight = 'bold';
            app.toner.Position = [66 45 50 35];
            app.toner.Text = 'R ON';

            % Create tonel
            app.tonel = uibutton(app.uipanel3, 'push');
            app.tonel.ButtonPushedFcn = createCallbackFcn(app, @tonel_Callback, true);
            app.tonel.FontSize = 13;
            app.tonel.FontWeight = 'bold';
            app.tonel.Position = [9 45 50 35];
            app.tonel.Text = 'L  ON ';

            % Create vol
            app.vol = uibutton(app.uipanel3, 'push');
            app.vol.ButtonPushedFcn = createCallbackFcn(app, @vol_Callback, true);
            app.vol.FontSize = 13;
            app.vol.FontWeight = 'bold';
            app.vol.Position = [9 3 53 35];
            app.vol.Text = 'VOL +';

            % Create vol_2
            app.vol_2 = uibutton(app.uipanel3, 'push');
            app.vol_2.ButtonPushedFcn = createCallbackFcn(app, @vol_2ButtonPushed, true);
            app.vol_2.FontSize = 13;
            app.vol_2.FontWeight = 'bold';
            app.vol_2.Position = [66 3 53 35];
            app.vol_2.Text = 'VOL -';

            % Create uipanel4
            app.uipanel4 = uipanel(app.figure1);
            app.uipanel4.Title = 'Light Test';
            app.uipanel4.FontWeight = 'bold';
            app.uipanel4.FontSize = 13;
            app.uipanel4.Position = [804 68 190 101];

            % Create flashl
            app.flashl = uibutton(app.uipanel4, 'push');
            app.flashl.ButtonPushedFcn = createCallbackFcn(app, @flashl_Callback, true);
            app.flashl.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashl.FontSize = 13;
            app.flashl.FontWeight = 'bold';
            app.flashl.Position = [11 39 55 35];
            app.flashl.Text = 'Flash L';

            % Create flashr
            app.flashr = uibutton(app.uipanel4, 'push');
            app.flashr.ButtonPushedFcn = createCallbackFcn(app, @flashr_Callback, true);
            app.flashr.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashr.FontSize = 13;
            app.flashr.FontWeight = 'bold';
            app.flashr.Position = [125 39 55 35];
            app.flashr.Text = 'Flash R';

            % Create flashc
            app.flashc = uibutton(app.uipanel4, 'push');
            app.flashc.ButtonPushedFcn = createCallbackFcn(app, @flashc_Callback, true);
            app.flashc.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashc.FontSize = 13;
            app.flashc.FontWeight = 'bold';
            app.flashc.Position = [67 39 55 35];
            app.flashc.Text = 'Flash C';

            % Create test
            app.test = uibutton(app.uipanel4, 'push');
            app.test.ButtonPushedFcn = createCallbackFcn(app, @test_Callback, true);
            app.test.FontSize = 13;
            app.test.FontWeight = 'bold';
            app.test.Position = [13 6 164 30];
            app.test.Text = 'Light Sequence';

            % Create write
            app.write = uibutton(app.figure1, 'push');
            app.write.ButtonPushedFcn = createCallbackFcn(app, @write_Callback, true);
            app.write.FontSize = 16;
            app.write.FontWeight = 'bold';
            app.write.Position = [1022 722 96 24];
            app.write.Text = 'Write Note';

            % Create StimulusPanel
            app.StimulusPanel = uipanel(app.figure1);
            app.StimulusPanel.FontWeight = 'bold';
            app.StimulusPanel.Position = [328 183 327 508];

            % Create GoStimulusLabel
            app.GoStimulusLabel = uilabel(app.StimulusPanel);
            app.GoStimulusLabel.FontSize = 16;
            app.GoStimulusLabel.FontWeight = 'bold';
            app.GoStimulusLabel.Position = [12 481 99 22];
            app.GoStimulusLabel.Text = 'Go Stimulus';

            % Create SpeedlinedelaymsLabel
            app.SpeedlinedelaymsLabel = uilabel(app.StimulusPanel);
            app.SpeedlinedelaymsLabel.FontWeight = 'bold';
            app.SpeedlinedelaymsLabel.Position = [23 415 130 22];
            app.SpeedlinedelaymsLabel.Text = 'Speed (line delay, ms)';

            % Create line_delay_go
            app.line_delay_go = uieditfield(app.StimulusPanel, 'numeric');
            app.line_delay_go.ValueChangedFcn = createCallbackFcn(app, @line_delay_goValueChanged, true);
            app.line_delay_go.Tag = 'Stimulus Speed GO Visual';
            app.line_delay_go.HorizontalAlignment = 'center';
            app.line_delay_go.FontWeight = 'bold';
            app.line_delay_go.Position = [169 415 50 20];
            app.line_delay_go.Value = 2;

            % Create StimulusdurationmsLabel_2
            app.StimulusdurationmsLabel_2 = uilabel(app.StimulusPanel);
            app.StimulusdurationmsLabel_2.FontWeight = 'bold';
            app.StimulusdurationmsLabel_2.Position = [23 357 136 22];
            app.StimulusdurationmsLabel_2.Text = 'Stimulus duration (ms)';

            % Create stimulus_duration_visual_go
            app.stimulus_duration_visual_go = uieditfield(app.StimulusPanel, 'numeric');
            app.stimulus_duration_visual_go.Tag = 'Stimulus Duration GO Visual';
            app.stimulus_duration_visual_go.HorizontalAlignment = 'center';
            app.stimulus_duration_visual_go.Position = [169 357 50 22];
            app.stimulus_duration_visual_go.Value = 1000;

            % Create stimulation_frequency_visual_go
            app.stimulation_frequency_visual_go = uieditfield(app.StimulusPanel, 'numeric');
            app.stimulation_frequency_visual_go.Tag = 'Stimulus Frequency GO Visual';
            app.stimulation_frequency_visual_go.HorizontalAlignment = 'center';
            app.stimulation_frequency_visual_go.FontWeight = 'bold';
            app.stimulation_frequency_visual_go.Position = [169 388 50 20];
            app.stimulation_frequency_visual_go.Value = 2;

            % Create StimulationfreqHzLabel_2
            app.StimulationfreqHzLabel_2 = uilabel(app.StimulusPanel);
            app.StimulationfreqHzLabel_2.FontWeight = 'bold';
            app.StimulationfreqHzLabel_2.Position = [23 387 126 22];
            app.StimulationfreqHzLabel_2.Text = 'Stimulation freq. (Hz)';

            % Create visual_active_go
            app.visual_active_go = uicheckbox(app.StimulusPanel);
            app.visual_active_go.ValueChangedFcn = createCallbackFcn(app, @visual_active_goValueChanged, true);
            app.visual_active_go.Tag = 'Visual GO';
            app.visual_active_go.Text = 'Visual';
            app.visual_active_go.FontWeight = 'bold';
            app.visual_active_go.Position = [17 451 57 22];

            % Create auditory_active_go
            app.auditory_active_go = uicheckbox(app.StimulusPanel);
            app.auditory_active_go.ValueChangedFcn = createCallbackFcn(app, @auditory_active_goValueChanged, true);
            app.auditory_active_go.Tag = 'Auditory GO';
            app.auditory_active_go.Text = 'Auditory';
            app.auditory_active_go.FontWeight = 'bold';
            app.auditory_active_go.Position = [15 243 71 22];

            % Create audio_stimulus_duration_go
            app.audio_stimulus_duration_go = uieditfield(app.StimulusPanel, 'numeric');
            app.audio_stimulus_duration_go.Tag = 'Stimulation Duration GO Auditory';
            app.audio_stimulus_duration_go.HorizontalAlignment = 'center';
            app.audio_stimulus_duration_go.Position = [169 134 50 22];
            app.audio_stimulus_duration_go.Value = 1000;

            % Create StimulusdurationmsLabel_5
            app.StimulusdurationmsLabel_5 = uilabel(app.StimulusPanel);
            app.StimulusdurationmsLabel_5.FontWeight = 'bold';
            app.StimulusdurationmsLabel_5.Position = [23 134 136 22];
            app.StimulusdurationmsLabel_5.Text = 'Stimulus duration (ms)';

            % Create VolumeLabel_5
            app.VolumeLabel_5 = uilabel(app.StimulusPanel);
            app.VolumeLabel_5.FontWeight = 'bold';
            app.VolumeLabel_5.Position = [23 219 65 22];
            app.VolumeLabel_5.Text = 'Volume';

            % Create audio_volume_go
            app.audio_volume_go = uieditfield(app.StimulusPanel, 'numeric');
            app.audio_volume_go.Tag = 'Stimulus Volume GO Auditory';
            app.audio_volume_go.HorizontalAlignment = 'center';
            app.audio_volume_go.Position = [169 220 50 20];
            app.audio_volume_go.Value = 4;

            % Create StimulationfreqHzLabel_5
            app.StimulationfreqHzLabel_5 = uilabel(app.StimulusPanel);
            app.StimulationfreqHzLabel_5.FontWeight = 'bold';
            app.StimulationfreqHzLabel_5.Position = [23 161 126 22];
            app.StimulationfreqHzLabel_5.Text = 'Stimulation freq. (Hz)';

            % Create audio_stimulation_frequency_go
            app.audio_stimulation_frequency_go = uieditfield(app.StimulusPanel, 'numeric');
            app.audio_stimulation_frequency_go.Tag = 'Stimulation Frequency GO Auditory';
            app.audio_stimulation_frequency_go.HorizontalAlignment = 'center';
            app.audio_stimulation_frequency_go.FontWeight = 'bold';
            app.audio_stimulation_frequency_go.Position = [169 162 50 20];
            app.audio_stimulation_frequency_go.Value = 2;

            % Create TonePitchkHzDropDown_3Label
            app.TonePitchkHzDropDown_3Label = uilabel(app.StimulusPanel);
            app.TonePitchkHzDropDown_3Label.FontWeight = 'bold';
            app.TonePitchkHzDropDown_3Label.Position = [23 193 114 22];
            app.TonePitchkHzDropDown_3Label.Text = 'Tone Pitch (kHz)';

            % Create audio_tone_pitch_go
            app.audio_tone_pitch_go = uidropdown(app.StimulusPanel);
            app.audio_tone_pitch_go.Items = {'2', '4', '6', '8', '12', '16', '24', '32'};
            app.audio_tone_pitch_go.ItemsData = {'1', '2', '3', '4', '6', '8', '12', '16'};
            app.audio_tone_pitch_go.Tag = 'Tone Pitch GO Auditory';
            app.audio_tone_pitch_go.Position = [166 193 50 22];
            app.audio_tone_pitch_go.Value = '1';

            % Create auditorystimtypeDropDownLabel
            app.auditorystimtypeDropDownLabel = uilabel(app.StimulusPanel);
            app.auditorystimtypeDropDownLabel.HorizontalAlignment = 'right';
            app.auditorystimtypeDropDownLabel.FontWeight = 'bold';
            app.auditorystimtypeDropDownLabel.Position = [32 102 109 22];
            app.auditorystimtypeDropDownLabel.Text = 'auditory stim type';

            % Create audio_stimulus_type_go
            app.audio_stimulus_type_go = uidropdown(app.StimulusPanel);
            app.audio_stimulus_type_go.Items = {'tone', 'white noise'};
            app.audio_stimulus_type_go.Tag = 'Stimulation Type GO Auditory';
            app.audio_stimulus_type_go.FontWeight = 'bold';
            app.audio_stimulus_type_go.Position = [156 102 156 22];
            app.audio_stimulus_type_go.Value = 'tone';

            % Create StimulussideButtonGroup_3
            app.StimulussideButtonGroup_3 = uibuttongroup(app.StimulusPanel);
            app.StimulussideButtonGroup_3.Title = 'Stimulus side';
            app.StimulussideButtonGroup_3.FontWeight = 'bold';
            app.StimulussideButtonGroup_3.Position = [15 21 287 62];

            % Create stimulus_side_left_go
            app.stimulus_side_left_go = uiradiobutton(app.StimulussideButtonGroup_3);
            app.stimulus_side_left_go.Tag = 'Stimulus Side Left GO';
            app.stimulus_side_left_go.Text = 'Left';
            app.stimulus_side_left_go.FontWeight = 'bold';
            app.stimulus_side_left_go.Position = [15 12 58 22];
            app.stimulus_side_left_go.Value = true;

            % Create stimulus_side_right_go
            app.stimulus_side_right_go = uiradiobutton(app.StimulussideButtonGroup_3);
            app.stimulus_side_right_go.Tag = 'Stimulus Side Right GO';
            app.stimulus_side_right_go.Text = 'Right';
            app.stimulus_side_right_go.FontWeight = 'bold';
            app.stimulus_side_right_go.Position = [83 12 65 22];

            % Create StripeBarThicknessDropDownLabel
            app.StripeBarThicknessDropDownLabel = uilabel(app.StimulusPanel);
            app.StripeBarThicknessDropDownLabel.FontWeight = 'bold';
            app.StripeBarThicknessDropDownLabel.Position = [34 287 132 22];
            app.StripeBarThicknessDropDownLabel.Text = 'Stripe / Bar Thickness';

            % Create stripe_bar_thickness_go
            app.stripe_bar_thickness_go = uidropdown(app.StimulusPanel);
            app.stripe_bar_thickness_go.Items = {'1', '2', '3'};
            app.stripe_bar_thickness_go.ItemsData = {'1', '2', '3'};
            app.stripe_bar_thickness_go.Tag = 'Stripe/Bar Thickness Type GO Visual';
            app.stripe_bar_thickness_go.Position = [177 287 50 22];
            app.stripe_bar_thickness_go.Value = '1';

            % Create visstimtypeDropDown_2Label_2
            app.visstimtypeDropDown_2Label_2 = uilabel(app.StimulusPanel);
            app.visstimtypeDropDown_2Label_2.HorizontalAlignment = 'right';
            app.visstimtypeDropDown_2Label_2.FontWeight = 'bold';
            app.visstimtypeDropDown_2Label_2.Position = [28 324 78 22];
            app.visstimtypeDropDown_2Label_2.Text = 'vis stim type';

            % Create stimulation_type_visual_go
            app.stimulation_type_visual_go = uidropdown(app.StimulusPanel);
            app.stimulation_type_visual_go.Items = {'full panel', 'vertical stripes', 'horizontal stripes', 'left diagonal', 'right diagonal', 'single vertical stripe', 'single horizontal stripe'};
            app.stimulation_type_visual_go.ItemsData = {'1', '2', '3', '4', '5', '6', '7'};
            app.stimulation_type_visual_go.Tag = 'Stimulation Type GO Visual';
            app.stimulation_type_visual_go.FontWeight = 'bold';
            app.stimulation_type_visual_go.Position = [121 324 186 22];
            app.stimulation_type_visual_go.Value = '4';

            % Create LoadSettingsButton
            app.LoadSettingsButton = uibutton(app.figure1, 'push');
            app.LoadSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @LoadSettingsButtonPushed, true);
            app.LoadSettingsButton.FontWeight = 'bold';
            app.LoadSettingsButton.Position = [546 73 94 38];
            app.LoadSettingsButton.Text = 'Load Settings';

            % Create SaveSettingsButton
            app.SaveSettingsButton = uibutton(app.figure1, 'push');
            app.SaveSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveSettingsButtonPushed, true);
            app.SaveSettingsButton.FontWeight = 'bold';
            app.SaveSettingsButton.Position = [548 119 94 38];
            app.SaveSettingsButton.Text = 'Save Settings';

            % Create lick
            app.lick = uibutton(app.figure1, 'push');
            app.lick.ButtonPushedFcn = createCallbackFcn(app, @lickButtonPushed, true);
            app.lick.FontSize = 14;
            app.lick.FontWeight = 'bold';
            app.lick.Position = [401 133 107 28];
            app.lick.Text = 'Do a Lick';

            % Create GeneralControlsPanel
            app.GeneralControlsPanel = uipanel(app.figure1);
            app.GeneralControlsPanel.Title = 'General Controls';
            app.GeneralControlsPanel.FontWeight = 'bold';
            app.GeneralControlsPanel.FontSize = 16;
            app.GeneralControlsPanel.Position = [24 14 296 677];

            % Create iti_min
            app.iti_min = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.iti_min.Tag = 'ITI Min';
            app.iti_min.HorizontalAlignment = 'center';
            app.iti_min.FontWeight = 'bold';
            app.iti_min.Position = [176 541 50 20];
            app.iti_min.Value = 7;

            % Create short_iti_min
            app.short_iti_min = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.short_iti_min.Tag = 'Short ITI Min';
            app.short_iti_min.HorizontalAlignment = 'center';
            app.short_iti_min.FontWeight = 'bold';
            app.short_iti_min.Position = [176 514 50 20];
            app.short_iti_min.Value = 7;

            % Create ExperimentDurationsLabel
            app.ExperimentDurationsLabel = uilabel(app.GeneralControlsPanel);
            app.ExperimentDurationsLabel.FontWeight = 'bold';
            app.ExperimentDurationsLabel.Position = [35 627 142 22];
            app.ExperimentDurationsLabel.Text = 'Experiment Duration (s)';

            % Create ex_duration
            app.ex_duration = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.ex_duration.Tag = 'Experiment Duration';
            app.ex_duration.HorizontalAlignment = 'center';
            app.ex_duration.FontWeight = 'bold';
            app.ex_duration.Position = [243 627 50 20];
            app.ex_duration.Value = 900;

            % Create ITIminmaxsLabel
            app.ITIminmaxsLabel = uilabel(app.GeneralControlsPanel);
            app.ITIminmaxsLabel.FontWeight = 'bold';
            app.ITIminmaxsLabel.Position = [35 542 96 22];
            app.ITIminmaxsLabel.Text = 'ITI  min  max (s)';

            % Create iti_max
            app.iti_max = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.iti_max.Tag = 'ITI Max';
            app.iti_max.HorizontalAlignment = 'center';
            app.iti_max.FontWeight = 'bold';
            app.iti_max.Position = [243 542 50 20];
            app.iti_max.Value = 7;

            % Create ShortITIminmaxsLabel
            app.ShortITIminmaxsLabel = uilabel(app.GeneralControlsPanel);
            app.ShortITIminmaxsLabel.FontWeight = 'bold';
            app.ShortITIminmaxsLabel.Position = [35 514 131 22];
            app.ShortITIminmaxsLabel.Text = 'Short ITI  min  max (s)';

            % Create short_iti_max
            app.short_iti_max = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.short_iti_max.Tag = 'Short ITI Max';
            app.short_iti_max.HorizontalAlignment = 'center';
            app.short_iti_max.FontWeight = 'bold';
            app.short_iti_max.Position = [243 514 50 20];
            app.short_iti_max.Value = 7;

            % Create percentage_of_go_trials
            app.percentage_of_go_trials = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.percentage_of_go_trials.Tag = 'Percentage of GO Trials';
            app.percentage_of_go_trials.HorizontalAlignment = 'center';
            app.percentage_of_go_trials.FontWeight = 'bold';
            app.percentage_of_go_trials.Position = [244 376 49 20];
            app.percentage_of_go_trials.Value = 50;

            % Create PercentageofGoTrialsLabel
            app.PercentageofGoTrialsLabel = uilabel(app.GeneralControlsPanel);
            app.PercentageofGoTrialsLabel.FontWeight = 'bold';
            app.PercentageofGoTrialsLabel.Position = [35 376 140 22];
            app.PercentageofGoTrialsLabel.Text = 'Percentage of Go Trials';

            % Create max_window_of_no_responses
            app.max_window_of_no_responses = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.max_window_of_no_responses.Tag = 'Max Window of No Responses';
            app.max_window_of_no_responses.HorizontalAlignment = 'center';
            app.max_window_of_no_responses.FontWeight = 'bold';
            app.max_window_of_no_responses.Position = [244 598 49 20];
            app.max_window_of_no_responses.Value = 50;

            % Create MaxWindowofNoResponsessLabel
            app.MaxWindowofNoResponsessLabel = uilabel(app.GeneralControlsPanel);
            app.MaxWindowofNoResponsessLabel.FontWeight = 'bold';
            app.MaxWindowofNoResponsessLabel.Position = [35 598 198 22];
            app.MaxWindowofNoResponsessLabel.Text = 'Max Window of No Responses (s)';

            % Create StimStartDelaysLabel
            app.StimStartDelaysLabel = uilabel(app.GeneralControlsPanel);
            app.StimStartDelaysLabel.FontWeight = 'bold';
            app.StimStartDelaysLabel.Position = [35 486 116 22];
            app.StimStartDelaysLabel.Text = 'Stim Start Delay (s)';

            % Create stim_start_delay_max
            app.stim_start_delay_max = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.stim_start_delay_max.Tag = 'Stim Start Delay Max';
            app.stim_start_delay_max.HorizontalAlignment = 'center';
            app.stim_start_delay_max.FontWeight = 'bold';
            app.stim_start_delay_max.Position = [201 486 40 20];
            app.stim_start_delay_max.Value = 0.5;

            % Create DelayPeriodsLabel
            app.DelayPeriodsLabel = uilabel(app.GeneralControlsPanel);
            app.DelayPeriodsLabel.FontWeight = 'bold';
            app.DelayPeriodsLabel.Position = [38 460 96 22];
            app.DelayPeriodsLabel.Text = 'Delay Period (s)';

            % Create delay_period_min
            app.delay_period_min = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.delay_period_min.Tag = 'Delay Period Min';
            app.delay_period_min.HorizontalAlignment = 'center';
            app.delay_period_min.FontWeight = 'bold';
            app.delay_period_min.Position = [153 460 40 20];
            app.delay_period_min.Value = 0.1;

            % Create ResponseWindowsLabel
            app.ResponseWindowsLabel = uilabel(app.GeneralControlsPanel);
            app.ResponseWindowsLabel.FontWeight = 'bold';
            app.ResponseWindowsLabel.Position = [35 432 130 22];
            app.ResponseWindowsLabel.Text = 'Response Window (s)';

            % Create response_window
            app.response_window = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.response_window.Tag = 'Response Window';
            app.response_window.HorizontalAlignment = 'center';
            app.response_window.FontWeight = 'bold';
            app.response_window.Position = [243 432 50 20];
            app.response_window.Value = 0.1;

            % Create NumberofLicksLabel
            app.NumberofLicksLabel = uilabel(app.GeneralControlsPanel);
            app.NumberofLicksLabel.FontWeight = 'bold';
            app.NumberofLicksLabel.Position = [35 404 176 22];
            app.NumberofLicksLabel.Text = 'Number of Licks';

            % Create number_of_licks_required
            app.number_of_licks_required = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.number_of_licks_required.Tag = 'Number of Licks Required';
            app.number_of_licks_required.HorizontalAlignment = 'center';
            app.number_of_licks_required.FontWeight = 'bold';
            app.number_of_licks_required.Position = [147 404 45 20];
            app.number_of_licks_required.Value = 1;

            % Create free_reward
            app.free_reward = uicheckbox(app.GeneralControlsPanel);
            app.free_reward.Tag = 'Free Reward';
            app.free_reward.Text = 'Free Reward';
            app.free_reward.FontSize = 13;
            app.free_reward.FontWeight = 'bold';
            app.free_reward.Position = [35 166 102 25];

            % Create percentage_of_catch_trials
            app.percentage_of_catch_trials = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.percentage_of_catch_trials.Tag = 'Percentage of Catch Trials';
            app.percentage_of_catch_trials.HorizontalAlignment = 'center';
            app.percentage_of_catch_trials.FontWeight = 'bold';
            app.percentage_of_catch_trials.Position = [244 348 49 20];
            app.percentage_of_catch_trials.Value = 50;

            % Create PercentageofCatchTrialsLabel
            app.PercentageofCatchTrialsLabel = uilabel(app.GeneralControlsPanel);
            app.PercentageofCatchTrialsLabel.FontWeight = 'bold';
            app.PercentageofCatchTrialsLabel.Position = [35 348 157 22];
            app.PercentageofCatchTrialsLabel.Text = 'Percentage of Catch Trials';

            % Create lick_time
            app.lick_time = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.lick_time.Tag = 'Number of Licks Time Window';
            app.lick_time.HorizontalAlignment = 'center';
            app.lick_time.FontWeight = 'bold';
            app.lick_time.Position = [211 405 40 20];
            app.lick_time.Value = 7;

            % Create Label
            app.Label = uilabel(app.GeneralControlsPanel);
            app.Label.Position = [201 405 25 22];
            app.Label.Text = '/';

            % Create PunishmentSignalDropDownLabel
            app.PunishmentSignalDropDownLabel = uilabel(app.GeneralControlsPanel);
            app.PunishmentSignalDropDownLabel.HorizontalAlignment = 'right';
            app.PunishmentSignalDropDownLabel.FontWeight = 'bold';
            app.PunishmentSignalDropDownLabel.Position = [31 134 114 22];
            app.PunishmentSignalDropDownLabel.Text = 'Punishment Signal';

            % Create punishment_signal
            app.punishment_signal = uidropdown(app.GeneralControlsPanel);
            app.punishment_signal.Items = {'visual', 'tone', 'noise', 'none'};
            app.punishment_signal.Tag = 'Punishment Signal';
            app.punishment_signal.FontWeight = 'bold';
            app.punishment_signal.Position = [175 134 86 22];
            app.punishment_signal.Value = 'visual';

            % Create DurationsLabel
            app.DurationsLabel = uilabel(app.GeneralControlsPanel);
            app.DurationsLabel.FontWeight = 'bold';
            app.DurationsLabel.Position = [35 259 72 22];
            app.DurationsLabel.Text = 'Duration (s)';

            % Create start_signal_duration
            app.start_signal_duration = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.start_signal_duration.Tag = 'Start Signal Duration';
            app.start_signal_duration.HorizontalAlignment = 'center';
            app.start_signal_duration.FontWeight = 'bold';
            app.start_signal_duration.Position = [169 259 65 20];
            app.start_signal_duration.Value = 0.5;

            % Create TrialStartSignalDropDownLabel
            app.TrialStartSignalDropDownLabel = uilabel(app.GeneralControlsPanel);
            app.TrialStartSignalDropDownLabel.HorizontalAlignment = 'right';
            app.TrialStartSignalDropDownLabel.FontWeight = 'bold';
            app.TrialStartSignalDropDownLabel.Position = [31 287 100 22];
            app.TrialStartSignalDropDownLabel.Text = 'Trial Start Signal';

            % Create trial_start_signal
            app.trial_start_signal = uidropdown(app.GeneralControlsPanel);
            app.trial_start_signal.Items = {'visual', 'tone', 'noise', 'none'};
            app.trial_start_signal.Tag = 'Trial Start Signal';
            app.trial_start_signal.FontWeight = 'bold';
            app.trial_start_signal.Position = [167 287 87 22];
            app.trial_start_signal.Value = 'visual';

            % Create DurationsLabel_2
            app.DurationsLabel_2 = uilabel(app.GeneralControlsPanel);
            app.DurationsLabel_2.FontWeight = 'bold';
            app.DurationsLabel_2.Position = [35 48 72 22];
            app.DurationsLabel_2.Text = 'Duration (s)';

            % Create punishment_duration
            app.punishment_duration = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.punishment_duration.Tag = 'Punishment Duration';
            app.punishment_duration.HorizontalAlignment = 'center';
            app.punishment_duration.FontWeight = 'bold';
            app.punishment_duration.Position = [194 48 57 20];
            app.punishment_duration.Value = 0.5;

            % Create punishmentTonekHzLabel
            app.punishmentTonekHzLabel = uilabel(app.GeneralControlsPanel);
            app.punishmentTonekHzLabel.FontWeight = 'bold';
            app.punishmentTonekHzLabel.Position = [35 20 137 22];
            app.punishmentTonekHzLabel.Text = 'punishment Tone (kHz)';

            % Create punishment_tone_frequency
            app.punishment_tone_frequency = uidropdown(app.GeneralControlsPanel);
            app.punishment_tone_frequency.Items = {'2', '4', '6', '8', '12', '16', '24', '32'};
            app.punishment_tone_frequency.ItemsData = {'1', '2', '3', '4', '6', '8', '8', '12', '16'};
            app.punishment_tone_frequency.Tag = 'Punishment Tone Pitch';
            app.punishment_tone_frequency.FontWeight = 'bold';
            app.punishment_tone_frequency.Position = [194 18 57 22];
            app.punishment_tone_frequency.Value = '1';

            % Create PunishmentTimeoutsLabel
            app.PunishmentTimeoutsLabel = uilabel(app.GeneralControlsPanel);
            app.PunishmentTimeoutsLabel.FontWeight = 'bold';
            app.PunishmentTimeoutsLabel.Position = [35 76 142 22];
            app.PunishmentTimeoutsLabel.Text = 'Punishment Timeout (s)';

            % Create punishment_timeout
            app.punishment_timeout = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.punishment_timeout.Tag = 'Punishment Timeout';
            app.punishment_timeout.HorizontalAlignment = 'center';
            app.punishment_timeout.FontWeight = 'bold';
            app.punishment_timeout.Position = [191 78 57 20];
            app.punishment_timeout.Value = 0.5;

            % Create delay_period_max
            app.delay_period_max = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.delay_period_max.Tag = 'Delay Period Max';
            app.delay_period_max.HorizontalAlignment = 'center';
            app.delay_period_max.FontWeight = 'bold';
            app.delay_period_max.Position = [201 460 40 20];

            % Create delay_period_number_of_steps
            app.delay_period_number_of_steps = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.delay_period_number_of_steps.Tag = 'Delay Period Number of Steps';
            app.delay_period_number_of_steps.FontWeight = 'bold';
            app.delay_period_number_of_steps.Position = [251 460 40 20];

            % Create wait_after_lick_time
            app.wait_after_lick_time = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.wait_after_lick_time.Tag = 'Wait After Lick';
            app.wait_after_lick_time.HorizontalAlignment = 'center';
            app.wait_after_lick_time.FontWeight = 'bold';
            app.wait_after_lick_time.Position = [244 570 49 20];
            app.wait_after_lick_time.Value = 50;

            % Create WaitAfterLicksLabel
            app.WaitAfterLicksLabel = uilabel(app.GeneralControlsPanel);
            app.WaitAfterLicksLabel.FontWeight = 'bold';
            app.WaitAfterLicksLabel.Position = [35 570 107 22];
            app.WaitAfterLicksLabel.Text = 'Wait After Lick (s)';

            % Create PunishmentVolumeLabel
            app.PunishmentVolumeLabel = uilabel(app.GeneralControlsPanel);
            app.PunishmentVolumeLabel.FontWeight = 'bold';
            app.PunishmentVolumeLabel.Position = [35 104 120 22];
            app.PunishmentVolumeLabel.Text = 'Punishment Volume';

            % Create punishment_volume
            app.punishment_volume = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.punishment_volume.Tag = 'Punishment Volume';
            app.punishment_volume.HorizontalAlignment = 'center';
            app.punishment_volume.FontWeight = 'bold';
            app.punishment_volume.Position = [194 104 57 20];
            app.punishment_volume.Value = 0.5;

            % Create secLabel
            app.secLabel = uilabel(app.GeneralControlsPanel);
            app.secLabel.FontWeight = 'bold';
            app.secLabel.Position = [262 402 26 22];
            app.secLabel.Text = 'sec';

            % Create VolumeLabel_7
            app.VolumeLabel_7 = uilabel(app.GeneralControlsPanel);
            app.VolumeLabel_7.FontWeight = 'bold';
            app.VolumeLabel_7.Position = [37 232 72 22];
            app.VolumeLabel_7.Text = 'Volume';

            % Create start_tone_volume
            app.start_tone_volume = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.start_tone_volume.Tag = 'Start Signal Volume';
            app.start_tone_volume.HorizontalAlignment = 'center';
            app.start_tone_volume.FontWeight = 'bold';
            app.start_tone_volume.Position = [171 232 65 20];
            app.start_tone_volume.Value = 20;

            % Create StartTonePitchkHzDropDownLabel
            app.StartTonePitchkHzDropDownLabel = uilabel(app.GeneralControlsPanel);
            app.StartTonePitchkHzDropDownLabel.FontWeight = 'bold';
            app.StartTonePitchkHzDropDownLabel.Position = [32 198 129 22];
            app.StartTonePitchkHzDropDownLabel.Text = 'Start Tone Pitch (kHz)';

            % Create start_tone_pitch
            app.start_tone_pitch = uidropdown(app.GeneralControlsPanel);
            app.start_tone_pitch.Items = {'2', '4', '6', '8', '12', '16', '24', '32'};
            app.start_tone_pitch.ItemsData = {'1', '2', '3', '4', '6', '8', '12', '16'};
            app.start_tone_pitch.Tag = 'Start Signal Tone Pitch';
            app.start_tone_pitch.FontWeight = 'bold';
            app.start_tone_pitch.Position = [179 199 75 22];
            app.start_tone_pitch.Value = '2';

            % Create early_lick_reset
            app.early_lick_reset = uicheckbox(app.GeneralControlsPanel);
            app.early_lick_reset.Tag = 'Earlt Lick Reset';
            app.early_lick_reset.Text = 'Early Lick Reset';
            app.early_lick_reset.FontSize = 13;
            app.early_lick_reset.FontWeight = 'bold';
            app.early_lick_reset.Position = [147 167 120 25];

            % Create cr_rule
            app.cr_rule = uicheckbox(app.GeneralControlsPanel);
            app.cr_rule.Tag = 'CR Rule';
            app.cr_rule.Text = 'CR Rule ON';
            app.cr_rule.FontSize = 13;
            app.cr_rule.FontWeight = 'bold';
            app.cr_rule.Position = [35 317 102 25];

            % Create stim_start_delay_min
            app.stim_start_delay_min = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.stim_start_delay_min.Tag = 'Stim Start Delay Min';
            app.stim_start_delay_min.HorizontalAlignment = 'center';
            app.stim_start_delay_min.FontWeight = 'bold';
            app.stim_start_delay_min.Position = [154 486 40 20];
            app.stim_start_delay_min.Value = 0.5;

            % Create stim_start_delay_number_of_steps
            app.stim_start_delay_number_of_steps = uieditfield(app.GeneralControlsPanel, 'numeric');
            app.stim_start_delay_number_of_steps.Tag = 'Stim Start Delay Number of Steps';
            app.stim_start_delay_number_of_steps.HorizontalAlignment = 'center';
            app.stim_start_delay_number_of_steps.FontWeight = 'bold';
            app.stim_start_delay_number_of_steps.Position = [251 486 40 20];
            app.stim_start_delay_number_of_steps.Value = 0.5;

            % Create StimulusPanel_2
            app.StimulusPanel_2 = uipanel(app.figure1);
            app.StimulusPanel_2.FontWeight = 'bold';
            app.StimulusPanel_2.Position = [666 183 327 508];

            % Create NOGoStimulusLabel
            app.NOGoStimulusLabel = uilabel(app.StimulusPanel_2);
            app.NOGoStimulusLabel.FontSize = 16;
            app.NOGoStimulusLabel.FontWeight = 'bold';
            app.NOGoStimulusLabel.Position = [12 482 138 22];
            app.NOGoStimulusLabel.Text = 'NO - Go Stimulus';

            % Create SpeedlinedelaymsLabel_2
            app.SpeedlinedelaymsLabel_2 = uilabel(app.StimulusPanel_2);
            app.SpeedlinedelaymsLabel_2.FontWeight = 'bold';
            app.SpeedlinedelaymsLabel_2.Position = [23 420 130 22];
            app.SpeedlinedelaymsLabel_2.Text = 'Speed (line delay, ms)';

            % Create line_delay_nogo
            app.line_delay_nogo = uieditfield(app.StimulusPanel_2, 'numeric');
            app.line_delay_nogo.Tag = 'Stimulus Speed NOGO Visual';
            app.line_delay_nogo.HorizontalAlignment = 'center';
            app.line_delay_nogo.FontWeight = 'bold';
            app.line_delay_nogo.Position = [169 420 50 20];
            app.line_delay_nogo.Value = 2;

            % Create StimulusdurationmsLabel_6
            app.StimulusdurationmsLabel_6 = uilabel(app.StimulusPanel_2);
            app.StimulusdurationmsLabel_6.FontWeight = 'bold';
            app.StimulusdurationmsLabel_6.Position = [23 362 136 22];
            app.StimulusdurationmsLabel_6.Text = 'Stimulus duration (ms)';

            % Create stimulus_duration_visual_nogo
            app.stimulus_duration_visual_nogo = uieditfield(app.StimulusPanel_2, 'numeric');
            app.stimulus_duration_visual_nogo.Tag = 'Stimulus Duration NOGO Visual';
            app.stimulus_duration_visual_nogo.HorizontalAlignment = 'center';
            app.stimulus_duration_visual_nogo.Position = [169 362 50 22];
            app.stimulus_duration_visual_nogo.Value = 1000;

            % Create stimulation_frequency_visual_nogo
            app.stimulation_frequency_visual_nogo = uieditfield(app.StimulusPanel_2, 'numeric');
            app.stimulation_frequency_visual_nogo.Tag = 'Stimulus Frequency NOGO Visual';
            app.stimulation_frequency_visual_nogo.HorizontalAlignment = 'center';
            app.stimulation_frequency_visual_nogo.FontWeight = 'bold';
            app.stimulation_frequency_visual_nogo.Position = [169 393 50 20];
            app.stimulation_frequency_visual_nogo.Value = 2;

            % Create StimulationfreqHzLabel_6
            app.StimulationfreqHzLabel_6 = uilabel(app.StimulusPanel_2);
            app.StimulationfreqHzLabel_6.FontWeight = 'bold';
            app.StimulationfreqHzLabel_6.Position = [23 392 126 22];
            app.StimulationfreqHzLabel_6.Text = 'Stimulation freq. (Hz)';

            % Create visstimtypeDropDown_2Label
            app.visstimtypeDropDown_2Label = uilabel(app.StimulusPanel_2);
            app.visstimtypeDropDown_2Label.HorizontalAlignment = 'right';
            app.visstimtypeDropDown_2Label.FontWeight = 'bold';
            app.visstimtypeDropDown_2Label.Position = [28 332 78 22];
            app.visstimtypeDropDown_2Label.Text = 'vis stim type';

            % Create stimulation_type_visual_nogo
            app.stimulation_type_visual_nogo = uidropdown(app.StimulusPanel_2);
            app.stimulation_type_visual_nogo.Items = {'full panel', 'vertical stripes', 'horizontal stripes', 'left diagonal', 'right diagonal', 'single vertical stripe', 'single horizontal stripe'};
            app.stimulation_type_visual_nogo.ItemsData = {'1', '2', '3', '4', '5', '6', '7', ''};
            app.stimulation_type_visual_nogo.Tag = 'Stimulation Type NOGO Visual';
            app.stimulation_type_visual_nogo.FontWeight = 'bold';
            app.stimulation_type_visual_nogo.Position = [121 332 186 22];
            app.stimulation_type_visual_nogo.Value = '4';

            % Create visual_active_nogo
            app.visual_active_nogo = uicheckbox(app.StimulusPanel_2);
            app.visual_active_nogo.ValueChangedFcn = createCallbackFcn(app, @visual_active_nogoValueChanged, true);
            app.visual_active_nogo.Tag = 'Visual NOGO';
            app.visual_active_nogo.Text = 'Visual';
            app.visual_active_nogo.FontWeight = 'bold';
            app.visual_active_nogo.Position = [17 452 57 22];

            % Create auditory_active_nogo
            app.auditory_active_nogo = uicheckbox(app.StimulusPanel_2);
            app.auditory_active_nogo.ValueChangedFcn = createCallbackFcn(app, @auditory_active_nogoValueChanged, true);
            app.auditory_active_nogo.Tag = 'Auditory NOGO';
            app.auditory_active_nogo.Text = 'Auditory';
            app.auditory_active_nogo.FontWeight = 'bold';
            app.auditory_active_nogo.Position = [17 246 71 22];

            % Create audio_stimulus_duration_nogo
            app.audio_stimulus_duration_nogo = uieditfield(app.StimulusPanel_2, 'numeric');
            app.audio_stimulus_duration_nogo.Tag = 'Stimulation Duration GO Auditory';
            app.audio_stimulus_duration_nogo.HorizontalAlignment = 'center';
            app.audio_stimulus_duration_nogo.Position = [171 137 50 22];
            app.audio_stimulus_duration_nogo.Value = 1000;

            % Create StimulusdurationmsLabel_7
            app.StimulusdurationmsLabel_7 = uilabel(app.StimulusPanel_2);
            app.StimulusdurationmsLabel_7.FontWeight = 'bold';
            app.StimulusdurationmsLabel_7.Position = [25 137 136 22];
            app.StimulusdurationmsLabel_7.Text = 'Stimulus duration (ms)';

            % Create VolumeLabel_6
            app.VolumeLabel_6 = uilabel(app.StimulusPanel_2);
            app.VolumeLabel_6.FontWeight = 'bold';
            app.VolumeLabel_6.Position = [25 222 65 22];
            app.VolumeLabel_6.Text = 'Volume';

            % Create audio_volume_nogo
            app.audio_volume_nogo = uieditfield(app.StimulusPanel_2, 'numeric');
            app.audio_volume_nogo.Tag = 'Stimulus Volume NOGO Auditory';
            app.audio_volume_nogo.HorizontalAlignment = 'center';
            app.audio_volume_nogo.Position = [171 223 50 20];
            app.audio_volume_nogo.Value = 4;

            % Create StimulationfreqHzLabel_7
            app.StimulationfreqHzLabel_7 = uilabel(app.StimulusPanel_2);
            app.StimulationfreqHzLabel_7.FontWeight = 'bold';
            app.StimulationfreqHzLabel_7.Position = [25 164 126 22];
            app.StimulationfreqHzLabel_7.Text = 'Stimulation freq. (Hz)';

            % Create audio_stimulation_frequency_nogo
            app.audio_stimulation_frequency_nogo = uieditfield(app.StimulusPanel_2, 'numeric');
            app.audio_stimulation_frequency_nogo.Tag = 'Stimulation Frequency NOGO Auditory';
            app.audio_stimulation_frequency_nogo.HorizontalAlignment = 'center';
            app.audio_stimulation_frequency_nogo.FontWeight = 'bold';
            app.audio_stimulation_frequency_nogo.Position = [171 165 50 20];
            app.audio_stimulation_frequency_nogo.Value = 2;

            % Create TonePitchkHzDropDown_4Label
            app.TonePitchkHzDropDown_4Label = uilabel(app.StimulusPanel_2);
            app.TonePitchkHzDropDown_4Label.FontWeight = 'bold';
            app.TonePitchkHzDropDown_4Label.Position = [25 196 114 22];
            app.TonePitchkHzDropDown_4Label.Text = 'Tone Pitch (kHz)';

            % Create audio_tone_pitch_nogo
            app.audio_tone_pitch_nogo = uidropdown(app.StimulusPanel_2);
            app.audio_tone_pitch_nogo.Items = {'2', '4', '6', '8', '12', '16', '24', '32'};
            app.audio_tone_pitch_nogo.ItemsData = {'1', '2', '3', '4', '6', '8', '12', '16'};
            app.audio_tone_pitch_nogo.Tag = 'Tone Pitch NOGO Auditory';
            app.audio_tone_pitch_nogo.Position = [168 196 50 22];
            app.audio_tone_pitch_nogo.Value = '1';

            % Create auditorystimtypeDropDown_2Label
            app.auditorystimtypeDropDown_2Label = uilabel(app.StimulusPanel_2);
            app.auditorystimtypeDropDown_2Label.HorizontalAlignment = 'right';
            app.auditorystimtypeDropDown_2Label.FontWeight = 'bold';
            app.auditorystimtypeDropDown_2Label.Position = [34 105 109 22];
            app.auditorystimtypeDropDown_2Label.Text = 'auditory stim type';

            % Create audio_stimulus_type_nogo
            app.audio_stimulus_type_nogo = uidropdown(app.StimulusPanel_2);
            app.audio_stimulus_type_nogo.Items = {'tone', 'white noise'};
            app.audio_stimulus_type_nogo.Tag = 'Stimulation Type NOGO Auditory';
            app.audio_stimulus_type_nogo.FontWeight = 'bold';
            app.audio_stimulus_type_nogo.Position = [158 105 156 22];
            app.audio_stimulus_type_nogo.Value = 'tone';

            % Create StimulussideButtonGroup_4
            app.StimulussideButtonGroup_4 = uibuttongroup(app.StimulusPanel_2);
            app.StimulussideButtonGroup_4.Title = 'Stimulus side';
            app.StimulussideButtonGroup_4.FontWeight = 'bold';
            app.StimulussideButtonGroup_4.Position = [17 23 287 62];

            % Create stimulus_side_left_nogo
            app.stimulus_side_left_nogo = uiradiobutton(app.StimulussideButtonGroup_4);
            app.stimulus_side_left_nogo.Tag = 'Stimulus Side Left NOGO';
            app.stimulus_side_left_nogo.Text = 'Left';
            app.stimulus_side_left_nogo.FontWeight = 'bold';
            app.stimulus_side_left_nogo.Position = [15 12 58 22];
            app.stimulus_side_left_nogo.Value = true;

            % Create stimulus_side_right_nogo
            app.stimulus_side_right_nogo = uiradiobutton(app.StimulussideButtonGroup_4);
            app.stimulus_side_right_nogo.Tag = 'Stimulus Side Right  NOGO';
            app.stimulus_side_right_nogo.Text = 'Right';
            app.stimulus_side_right_nogo.FontWeight = 'bold';
            app.stimulus_side_right_nogo.Position = [83 12 65 22];

            % Create StripeBarThicknessDropDownLabel_2
            app.StripeBarThicknessDropDownLabel_2 = uilabel(app.StimulusPanel_2);
            app.StripeBarThicknessDropDownLabel_2.FontWeight = 'bold';
            app.StripeBarThicknessDropDownLabel_2.Position = [31 291 132 22];
            app.StripeBarThicknessDropDownLabel_2.Text = 'Stripe / Bar Thickness';

            % Create stripe_bar_thickness_nogo
            app.stripe_bar_thickness_nogo = uidropdown(app.StimulusPanel_2);
            app.stripe_bar_thickness_nogo.Items = {'1', '2', '3'};
            app.stripe_bar_thickness_nogo.ItemsData = {'1', '2', '3'};
            app.stripe_bar_thickness_nogo.Tag = 'Stripe/Bar Thickness Type NOGO Visual';
            app.stripe_bar_thickness_nogo.Position = [174 291 50 22];
            app.stripe_bar_thickness_nogo.Value = '1';

            % Create uipanel3_2
            app.uipanel3_2 = uipanel(app.figure1);
            app.uipanel3_2.Title = 'Spout Control';
            app.uipanel3_2.FontWeight = 'bold';
            app.uipanel3_2.FontSize = 13;
            app.uipanel3_2.Position = [1013 227 188 398];

            % Create rest
            app.rest = uibutton(app.uipanel3_2, 'push');
            app.rest.ButtonPushedFcn = createCallbackFcn(app, @restButtonPushed, true);
            app.rest.FontSize = 13;
            app.rest.FontWeight = 'bold';
            app.rest.Position = [7 210 63 35];
            app.rest.Text = 'Rest';

            % Create full_retract
            app.full_retract = uibutton(app.uipanel3_2, 'push');
            app.full_retract.ButtonPushedFcn = createCallbackFcn(app, @full_retractButtonPushed, true);
            app.full_retract.FontSize = 13;
            app.full_retract.FontWeight = 'bold';
            app.full_retract.Position = [8 252 62 35];
            app.full_retract.Text = 'Full Rct';

            % Create full_out
            app.full_out = uibutton(app.uipanel3_2, 'push');
            app.full_out.ButtonPushedFcn = createCallbackFcn(app, @full_outButtonPushed, true);
            app.full_out.FontSize = 13;
            app.full_out.FontWeight = 'bold';
            app.full_out.Position = [7 169 63 35];
            app.full_out.Text = 'Full out';

            % Create sp1rest
            app.sp1rest = uieditfield(app.uipanel3_2, 'numeric');
            app.sp1rest.Tag = 'Spout Location Rest Center';
            app.sp1rest.Position = [107 210 68 20];

            % Create sp1ext
            app.sp1ext = uieditfield(app.uipanel3_2, 'numeric');
            app.sp1ext.Tag = 'Spout Location Full Out  Center';
            app.sp1ext.Position = [107 174 68 20];

            % Create locationLabel
            app.locationLabel = uilabel(app.uipanel3_2);
            app.locationLabel.FontWeight = 'bold';
            app.locationLabel.Position = [114 235 52 22];
            app.locationLabel.Text = 'location';

            % Create linear
            app.linear = uicheckbox(app.uipanel3_2);
            app.linear.ValueChangedFcn = createCallbackFcn(app, @linearValueChanged, true);
            app.linear.Tag = 'Spout Control Linear';
            app.linear.Text = 'Linear';
            app.linear.FontSize = 13;
            app.linear.FontWeight = 'bold';
            app.linear.Position = [7 346 71 25];

            % Create servo
            app.servo = uicheckbox(app.uipanel3_2);
            app.servo.ValueChangedFcn = createCallbackFcn(app, @servoValueChanged, true);
            app.servo.Tag = 'Spout Control Servo';
            app.servo.Text = 'Servo';
            app.servo.FontSize = 13;
            app.servo.FontWeight = 'bold';
            app.servo.Position = [104 346 71 25];

            % Create SpoutCLabel
            app.SpoutCLabel = uilabel(app.uipanel3_2);
            app.SpoutCLabel.FontSize = 16;
            app.SpoutCLabel.FontWeight = 'bold';
            app.SpoutCLabel.Position = [99 265 67 22];
            app.SpoutCLabel.Text = 'Spout C';

            % Create full_retract_2
            app.full_retract_2 = uibutton(app.uipanel3_2, 'push');
            app.full_retract_2.ButtonPushedFcn = createCallbackFcn(app, @full_retract_2ButtonPushed, true);
            app.full_retract_2.FontSize = 13;
            app.full_retract_2.FontWeight = 'bold';
            app.full_retract_2.Position = [12 92 62 35];
            app.full_retract_2.Text = 'Full Rct';

            % Create SpoutsLRLabel
            app.SpoutsLRLabel = uilabel(app.uipanel3_2);
            app.SpoutsLRLabel.FontSize = 16;
            app.SpoutsLRLabel.FontWeight = 'bold';
            app.SpoutsLRLabel.Position = [101 105 85 22];
            app.SpoutsLRLabel.Text = 'Spouts LR';

            % Create rest_2
            app.rest_2 = uibutton(app.uipanel3_2, 'push');
            app.rest_2.ButtonPushedFcn = createCallbackFcn(app, @rest_2ButtonPushed, true);
            app.rest_2.FontSize = 13;
            app.rest_2.FontWeight = 'bold';
            app.rest_2.Position = [11 50 63 35];
            app.rest_2.Text = 'Rest';

            % Create full_out_2
            app.full_out_2 = uibutton(app.uipanel3_2, 'push');
            app.full_out_2.ButtonPushedFcn = createCallbackFcn(app, @full_out_2ButtonPushed, true);
            app.full_out_2.FontSize = 13;
            app.full_out_2.FontWeight = 'bold';
            app.full_out_2.Position = [11 9 63 35];
            app.full_out_2.Text = 'Full out';

            % Create locationLabel_2
            app.locationLabel_2 = uilabel(app.uipanel3_2);
            app.locationLabel_2.FontWeight = 'bold';
            app.locationLabel_2.Position = [118 75 52 22];
            app.locationLabel_2.Text = 'location';

            % Create sp2rest
            app.sp2rest = uieditfield(app.uipanel3_2, 'numeric');
            app.sp2rest.Tag = 'Spout Location Rest Left/Right';
            app.sp2rest.Position = [111 50 68 20];

            % Create sp2ext
            app.sp2ext = uieditfield(app.uipanel3_2, 'numeric');
            app.sp2ext.Tag = 'Spout Location Full Out  Left/Right';
            app.sp2ext.Position = [111 14 68 20];

            % Create disable_center_spout
            app.disable_center_spout = uicheckbox(app.uipanel3_2);
            app.disable_center_spout.Tag = 'Disable Center Spout';
            app.disable_center_spout.Text = 'Disable Center Spout';
            app.disable_center_spout.FontSize = 13;
            app.disable_center_spout.FontWeight = 'bold';
            app.disable_center_spout.Position = [9 312 166 25];

            % Create uipanel3_3
            app.uipanel3_3 = uipanel(app.figure1);
            app.uipanel3_3.Title = 'Valve Control';
            app.uipanel3_3.FontWeight = 'bold';
            app.uipanel3_3.FontSize = 13;
            app.uipanel3_3.Position = [1013 69 188 117];

            % Create reward
            app.reward = uibutton(app.uipanel3_3, 'push');
            app.reward.ButtonPushedFcn = createCallbackFcn(app, @rewardButtonPushed, true);
            app.reward.FontSize = 13;
            app.reward.FontWeight = 'bold';
            app.reward.Position = [7 55 63 35];
            app.reward.Text = 'reward';

            % Create valve_on_off
            app.valve_on_off = uibutton(app.uipanel3_3, 'push');
            app.valve_on_off.ButtonPushedFcn = createCallbackFcn(app, @valve_on_offButtonPushed, true);
            app.valve_on_off.FontSize = 13;
            app.valve_on_off.FontWeight = 'bold';
            app.valve_on_off.Position = [7 12 63 35];
            app.valve_on_off.Text = 'Open';

            % Create reward_pulse_C
            app.reward_pulse_C = uieditfield(app.uipanel3_3, 'numeric');
            app.reward_pulse_C.ValueChangedFcn = createCallbackFcn(app, @reward_pulse_CValueChanged, true);
            app.reward_pulse_C.Tag = 'Reward Duration';
            app.reward_pulse_C.Position = [92 18 44 20];

            % Create timemsLabel
            app.timemsLabel = uilabel(app.uipanel3_3);
            app.timemsLabel.FontWeight = 'bold';
            app.timemsLabel.Position = [92 61 59 22];
            app.timemsLabel.Text = 'time (ms)';

            % Create HITLabel
            app.HITLabel = uilabel(app.figure1);
            app.HITLabel.FontWeight = 'bold';
            app.HITLabel.Position = [333 751 75 22];
            app.HITLabel.Text = 'HIT';

            % Create MISSLabel
            app.MISSLabel = uilabel(app.figure1);
            app.MISSLabel.FontWeight = 'bold';
            app.MISSLabel.Position = [328 715 75 22];
            app.MISSLabel.Text = 'MISS';

            % Create CRLabel
            app.CRLabel = uilabel(app.figure1);
            app.CRLabel.FontWeight = 'bold';
            app.CRLabel.Position = [425 751 75 22];
            app.CRLabel.Text = 'CR';

            % Create FALabel
            app.FALabel = uilabel(app.figure1);
            app.FALabel.FontWeight = 'bold';
            app.FALabel.Position = [427 715 75 22];
            app.FALabel.Text = 'FA';

            % Create statetext
            app.statetext = uilabel(app.figure1);
            app.statetext.HorizontalAlignment = 'center';
            app.statetext.VerticalAlignment = 'top';
            app.statetext.FontSize = 20;
            app.statetext.FontWeight = 'bold';
            app.statetext.Position = [24 702 183 35];
            app.statetext.Text = '';

            % Create trial_text
            app.trial_text = uilabel(app.figure1);
            app.trial_text.HorizontalAlignment = 'center';
            app.trial_text.VerticalAlignment = 'top';
            app.trial_text.FontSize = 20;
            app.trial_text.FontWeight = 'bold';
            app.trial_text.Position = [23 749 183 35];
            app.trial_text.Text = '';

            % Create BrightnessLabel
            app.BrightnessLabel = uilabel(app.figure1);
            app.BrightnessLabel.FontWeight = 'bold';
            app.BrightnessLabel.Position = [1014 669 65 22];
            app.BrightnessLabel.Text = 'Brightness';

            % Create brightness
            app.brightness = uieditfield(app.figure1, 'numeric');
            app.brightness.ValueChangedFcn = createCallbackFcn(app, @brightnessValueChanged, true);
            app.brightness.Tag = 'Brightness';
            app.brightness.HorizontalAlignment = 'center';
            app.brightness.Position = [1126 669 26 20];
            app.brightness.Value = 4;

            % Show the figure after all components are created
            app.figure1.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = HERBs_GoNoGo

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