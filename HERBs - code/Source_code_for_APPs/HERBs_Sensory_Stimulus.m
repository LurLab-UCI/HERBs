classdef HERBs_Sensory_Stimulus < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure1                        matlab.ui.Figure
        StimulusPanel_4                matlab.ui.container.Panel
        number_of_presentations        matlab.ui.control.NumericEditField
        numberofpresentationsLabel_2   matlab.ui.control.Label
        Interval_max                   matlab.ui.control.NumericEditField
        Interval_maxLabel_2            matlab.ui.control.Label
        Interval_min                   matlab.ui.control.NumericEditField
        Interval_minLabel_2            matlab.ui.control.Label
        StimulustimersLabel            matlab.ui.control.Label
        StimulussideButtonGroup        matlab.ui.container.ButtonGroup
        LeftRightLabel_2               matlab.ui.control.Label
        simultaneous                   matlab.ui.control.RadioButton
        alternating                    matlab.ui.control.RadioButton
        right                          matlab.ui.control.RadioButton
        left                           matlab.ui.control.RadioButton
        ExperimentsettingsLabel        matlab.ui.control.Label
        StimulusPanel_3                matlab.ui.container.Panel
        visual_first                   matlab.ui.control.CheckBox
        visual_and_auditory            matlab.ui.control.CheckBox
        auditory_only                  matlab.ui.control.CheckBox
        visual_only                    matlab.ui.control.CheckBox
        ExperimenttypeLabel            matlab.ui.control.Label
        delay_between                  matlab.ui.control.NumericEditField
        delaybetweenmsLabel            matlab.ui.control.Label
        StimulusPanel_2                matlab.ui.container.Panel
        TonePitchkHzDropDown           matlab.ui.control.DropDown
        TonePitchkHzDropDownLabel      matlab.ui.control.Label
        tone                           matlab.ui.control.CheckBox
        white_noise                    matlab.ui.control.CheckBox
        stimulustypeLabel_2            matlab.ui.control.Label
        AuditorystimulussettingsLabel  matlab.ui.control.Label
        StimulusdurationmsLabel        matlab.ui.control.Label
        stimulus_duration_audio        matlab.ui.control.NumericEditField
        stimulation_frequency_audio    matlab.ui.control.NumericEditField
        StimulationfreqHzLabel         matlab.ui.control.Label
        audio_volume                   matlab.ui.control.NumericEditField
        VolumeLabel_3                  matlab.ui.control.Label
        SaveSettingsButton             matlab.ui.control.Button
        LoadSettingsButton             matlab.ui.control.Button
        StimulusPanel                  matlab.ui.container.Panel
        combo                          matlab.ui.control.CheckBox
        StripeThicknessDropDown        matlab.ui.control.DropDown
        StripeThicknessDropDownLabel   matlab.ui.control.Label
        vert                           matlab.ui.control.CheckBox
        horz                           matlab.ui.control.CheckBox
        StimulationfreqHzLabel_2       matlab.ui.control.Label
        stimulation_frequency_visual   matlab.ui.control.NumericEditField
        stimulus_duration_visual       matlab.ui.control.NumericEditField
        StimulusdurationmsLabel_2      matlab.ui.control.Label
        double                         matlab.ui.control.CheckBox
        single                         matlab.ui.control.CheckBox
        full                           matlab.ui.control.CheckBox
        small                          matlab.ui.control.CheckBox
        line_delay                     matlab.ui.control.NumericEditField
        SpeedlinedelaymsLabel          matlab.ui.control.Label
        VisualstimulussettingsLabel    matlab.ui.control.Label
        stimulustypeLabel              matlab.ui.control.Label
        brightness                     matlab.ui.control.NumericEditField
        BrightnessLabel                matlab.ui.control.Label
        uipanel4                       matlab.ui.container.Panel
        allleds                        matlab.ui.control.CheckBox
        test                           matlab.ui.control.Button
        flashc                         matlab.ui.control.Button
        flashr                         matlab.ui.control.Button
        flashl                         matlab.ui.control.Button
        uipanel3                       matlab.ui.container.Panel
        vol_2                          matlab.ui.control.Button
        vol                            matlab.ui.control.Button
        tonel                          matlab.ui.control.Button
        toner                          matlab.ui.control.Button
        text36                         matlab.ui.control.Label
        p_count                        matlab.ui.control.Label
        start                          matlab.ui.control.Button
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function main_OpeningFcn(app)
            
               global excelfn;
              addpath(genpath(['.' filesep 'general' filesep]));
              addpath(genpath(['.' filesep 'DM' filesep]));
              addpath(genpath(['.' filesep 'SS' filesep]));
                
              if isfile([pwd filesep 'gui_settings_SS.mat'])
                    excelfn = [pwd filesep 'gui_settings_SS.mat'];
              else
                    excelfn  =[pwd filesep 'gui_default_settings_SS.mat'];
              end

               loadStatus(app,excelfn);

              app.figure1.Name = 'HERBs - Sensory Stimulus';
              app.start.Visible = 'off';
              init_SS(app);
              app.start.Visible = 'on';
              app.start.Enable = 'on';

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

        % Callback function
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
            if  app.allleds.Value
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
               write(arduino,['=' tf 'e' 1 0 0],"uint8");
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
               write(arduino,['=' tf 'e' 2 0 0],"uint8");
                app.toner.Text = 'R ON';
            end
        end

        % Callback function
        function torest_Callback(app, event)
            global spout1pos spout2pos;
            global current_servo_position;
            % set bit spouts to rest position
            control_spouts(spout1pos.rest,spout2pos.rest,app);
            current_servo_position = [spout1pos.rest,spout2pos.rest];
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

        % Callback function
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
            
            Start_SS(app);                
            app.start.Text = 'Start';
            run = 0;

        end

        % Value changed function: line_delay
        function line_delayValueChanged(app, event)
            global arduino;
            
            write(arduino,['{' round(app.line_delay.Value)],"uint8");
            
        end

        % Close request function: figure1
        function figure1CloseRequest(app, event)
            
              saveStatus(app,[pwd filesep 'gui_settings_SS.mat']);
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
            saveStatus(app,[pn fn]);

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
            loadStatus(app,[pn fn]);
            
        end

        % Value changed function: small
        function smallValueChanged(app, event)
            app.small.Value = 1;
            app.full.Value = 0;
            app.single.Value = 0;
            app.double.Value = 0;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.combo.Value = 0;

        end

        % Value changed function: full
        function fullValueChanged(app, event)
            app.full.Value = 1;
            app.small.Value = 0;
            app.single.Value = 0;
            app.double.Value = 0;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.combo.Value = 0;
           
        end

        % Value changed function: single
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

        % Value changed function: double
        function doubleValueChanged(app, event)
            app.double.Value = 1;
            app.small.Value = 0;
            app.full.Value = 0;
            app.single.Value = 0;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.combo.Value = 0;
            
        end

        % Value changed function: white_noise
        function white_noiseValueChanged(app, event)
            app.white_noise.Value = 1;
            app.tone.Value = 0;
            
        end

        % Value changed function: tone
        function toneValueChanged(app, event)
            app.tone.Value = 1;
            app.white_noise.Value = 0;
            
        end

        % Value changed function: visual_only
        function visual_onlyValueChanged(app, event)
            app.visual_only.Value = 1;
            app.auditory_only.Value = 0;
            app.visual_and_auditory.Value = 0;
            
        end

        % Value changed function: auditory_only
        function auditory_onlyValueChanged(app, event)
            app.auditory_only.Value = 1;
            app.visual_only.Value = 0;
            app.visual_and_auditory.Value = 0;
            
        end

        % Value changed function: visual_and_auditory
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

        % Value changed function: horz
        function horzValueChanged(app, event)
            app.horz.Value = 1;
            app.double.Value = 0;
            app.small.Value = 0;
            app.full.Value = 0;
            app.single.Value = 0;
            app.vert.Value = 0;
            app.combo.Value = 0;
            
        end

        % Value changed function: vert
        function vertValueChanged(app, event)
            app.vert.Value = 1;
            app.horz.Value = 0;
            app.double.Value = 0;
            app.small.Value = 0;
            app.full.Value = 0;
            app.single.Value = 0;
            app.combo.Value = 0;
            
            
        end

        % Value changed function: combo
        function comboValueChanged(app, event)
            app.combo.Value = 1;
            app.vert.Value = 0;
            app.horz.Value = 0;
            app.double.Value = 0;
            app.small.Value = 0;
            app.full.Value = 0;
            app.single.Value = 0;
            
        end

        % Callback function
        function sendButtonPushed(app, event)
       
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure1 and hide until all components are created
            app.figure1 = uifigure('Visible', 'off');
            app.figure1.Position = [100 100 1050 550];
            app.figure1.Name = 'main';
            app.figure1.CloseRequestFcn = createCallbackFcn(app, @figure1CloseRequest, true);

            % Create start
            app.start = uibutton(app.figure1, 'push');
            app.start.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);
            app.start.FontSize = 21;
            app.start.FontWeight = 'bold';
            app.start.Position = [744 84 125 46];
            app.start.Text = 'Start';

            % Create p_count
            app.p_count = uilabel(app.figure1);
            app.p_count.HorizontalAlignment = 'center';
            app.p_count.VerticalAlignment = 'top';
            app.p_count.FontSize = 27;
            app.p_count.FontWeight = 'bold';
            app.p_count.Position = [896 87 60 32];
            app.p_count.Text = '0';

            % Create text36
            app.text36 = uilabel(app.figure1);
            app.text36.VerticalAlignment = 'top';
            app.text36.FontSize = 13;
            app.text36.FontWeight = 'bold';
            app.text36.Position = [888 118 94 22];
            app.text36.Text = 'presentation #';

            % Create uipanel3
            app.uipanel3 = uipanel(app.figure1);
            app.uipanel3.Title = 'Tone Test';
            app.uipanel3.FontWeight = 'bold';
            app.uipanel3.FontSize = 13;
            app.uipanel3.Position = [365 24 128 124];

            % Create toner
            app.toner = uibutton(app.uipanel3, 'push');
            app.toner.ButtonPushedFcn = createCallbackFcn(app, @toner_Callback, true);
            app.toner.FontSize = 13;
            app.toner.FontWeight = 'bold';
            app.toner.Position = [66 62 50 35];
            app.toner.Text = 'R ON';

            % Create tonel
            app.tonel = uibutton(app.uipanel3, 'push');
            app.tonel.ButtonPushedFcn = createCallbackFcn(app, @tonel_Callback, true);
            app.tonel.FontSize = 13;
            app.tonel.FontWeight = 'bold';
            app.tonel.Position = [9 62 50 35];
            app.tonel.Text = 'L  ON ';

            % Create vol
            app.vol = uibutton(app.uipanel3, 'push');
            app.vol.ButtonPushedFcn = createCallbackFcn(app, @vol_Callback, true);
            app.vol.FontSize = 13;
            app.vol.FontWeight = 'bold';
            app.vol.Position = [9 20 53 35];
            app.vol.Text = 'VOL +';

            % Create vol_2
            app.vol_2 = uibutton(app.uipanel3, 'push');
            app.vol_2.ButtonPushedFcn = createCallbackFcn(app, @vol_2ButtonPushed, true);
            app.vol_2.FontSize = 13;
            app.vol_2.FontWeight = 'bold';
            app.vol_2.Position = [66 20 53 35];
            app.vol_2.Text = 'VOL -';

            % Create uipanel4
            app.uipanel4 = uipanel(app.figure1);
            app.uipanel4.Title = 'Light Test';
            app.uipanel4.FontWeight = 'bold';
            app.uipanel4.FontSize = 13;
            app.uipanel4.Position = [517 25 190 121];

            % Create flashl
            app.flashl = uibutton(app.uipanel4, 'push');
            app.flashl.ButtonPushedFcn = createCallbackFcn(app, @flashl_Callback, true);
            app.flashl.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashl.FontSize = 13;
            app.flashl.FontWeight = 'bold';
            app.flashl.Position = [11 59 55 35];
            app.flashl.Text = 'Flash L';

            % Create flashr
            app.flashr = uibutton(app.uipanel4, 'push');
            app.flashr.ButtonPushedFcn = createCallbackFcn(app, @flashr_Callback, true);
            app.flashr.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashr.FontSize = 13;
            app.flashr.FontWeight = 'bold';
            app.flashr.Position = [125 59 55 35];
            app.flashr.Text = 'Flash R';

            % Create flashc
            app.flashc = uibutton(app.uipanel4, 'push');
            app.flashc.ButtonPushedFcn = createCallbackFcn(app, @flashc_Callback, true);
            app.flashc.BackgroundColor = [0.9608 0.9608 0.9608];
            app.flashc.FontSize = 13;
            app.flashc.FontWeight = 'bold';
            app.flashc.Position = [67 59 55 35];
            app.flashc.Text = 'Flash C';

            % Create test
            app.test = uibutton(app.uipanel4, 'push');
            app.test.ButtonPushedFcn = createCallbackFcn(app, @test_Callback, true);
            app.test.FontSize = 13;
            app.test.FontWeight = 'bold';
            app.test.Position = [13 26 164 30];
            app.test.Text = 'Light Sequence';

            % Create allleds
            app.allleds = uicheckbox(app.uipanel4);
            app.allleds.Text = 'All LED Pattern';
            app.allleds.FontSize = 13;
            app.allleds.FontWeight = 'bold';
            app.allleds.Position = [22 2 164 25];

            % Create StimulusPanel
            app.StimulusPanel = uipanel(app.figure1);
            app.StimulusPanel.FontWeight = 'bold';
            app.StimulusPanel.Position = [369 158 327 333];

            % Create BrightnessLabel
            app.BrightnessLabel = uilabel(app.StimulusPanel);
            app.BrightnessLabel.FontWeight = 'bold';
            app.BrightnessLabel.Position = [24 276 65 22];
            app.BrightnessLabel.Text = 'Brightness';

            % Create brightness
            app.brightness = uieditfield(app.StimulusPanel, 'numeric');
            app.brightness.ValueChangedFcn = createCallbackFcn(app, @brightnessValueChanged, true);
            app.brightness.Tag = 'stimulus brightness';
            app.brightness.HorizontalAlignment = 'center';
            app.brightness.Position = [157 276 50 20];
            app.brightness.Value = 4;

            % Create stimulustypeLabel
            app.stimulustypeLabel = uilabel(app.StimulusPanel);
            app.stimulustypeLabel.FontWeight = 'bold';
            app.stimulustypeLabel.Position = [21 158 86 22];
            app.stimulustypeLabel.Text = 'stimulus type';

            % Create VisualstimulussettingsLabel
            app.VisualstimulussettingsLabel = uilabel(app.StimulusPanel);
            app.VisualstimulussettingsLabel.FontSize = 16;
            app.VisualstimulussettingsLabel.FontWeight = 'bold';
            app.VisualstimulussettingsLabel.Position = [12 303 188 22];
            app.VisualstimulussettingsLabel.Text = 'Visual stimulus settings';

            % Create SpeedlinedelaymsLabel
            app.SpeedlinedelaymsLabel = uilabel(app.StimulusPanel);
            app.SpeedlinedelaymsLabel.FontWeight = 'bold';
            app.SpeedlinedelaymsLabel.Position = [24 247 130 22];
            app.SpeedlinedelaymsLabel.Text = 'Speed (line delay, ms)';

            % Create line_delay
            app.line_delay = uieditfield(app.StimulusPanel, 'numeric');
            app.line_delay.ValueChangedFcn = createCallbackFcn(app, @line_delayValueChanged, true);
            app.line_delay.Tag = 'stimulus speed visual';
            app.line_delay.HorizontalAlignment = 'center';
            app.line_delay.FontWeight = 'bold';
            app.line_delay.Position = [157 247 50 20];
            app.line_delay.Value = 2;

            % Create small
            app.small = uicheckbox(app.StimulusPanel);
            app.small.ValueChangedFcn = createCallbackFcn(app, @smallValueChanged, true);
            app.small.Tag = 'small panel';
            app.small.Text = 'Small Panel';
            app.small.FontWeight = 'bold';
            app.small.Position = [35 131 89 22];

            % Create full
            app.full = uicheckbox(app.StimulusPanel);
            app.full.ValueChangedFcn = createCallbackFcn(app, @fullValueChanged, true);
            app.full.Tag = 'full panel';
            app.full.Text = 'Full panel';
            app.full.FontWeight = 'bold';
            app.full.Position = [144 131 78 22];

            % Create single
            app.single = uicheckbox(app.StimulusPanel);
            app.single.ValueChangedFcn = createCallbackFcn(app, @singleValueChanged, true);
            app.single.Tag = 'single bars';
            app.single.Text = 'Single bars';
            app.single.FontWeight = 'bold';
            app.single.Position = [33 68 86 22];

            % Create double
            app.double = uicheckbox(app.StimulusPanel);
            app.double.ValueChangedFcn = createCallbackFcn(app, @doubleValueChanged, true);
            app.double.Tag = 'double bars';
            app.double.Text = 'Double bars';
            app.double.FontWeight = 'bold';
            app.double.Position = [143 68 91 22];

            % Create StimulusdurationmsLabel_2
            app.StimulusdurationmsLabel_2 = uilabel(app.StimulusPanel);
            app.StimulusdurationmsLabel_2.FontWeight = 'bold';
            app.StimulusdurationmsLabel_2.Position = [11 186 136 22];
            app.StimulusdurationmsLabel_2.Text = 'Stimulus duration (ms)';

            % Create stimulus_duration_visual
            app.stimulus_duration_visual = uieditfield(app.StimulusPanel, 'numeric');
            app.stimulus_duration_visual.Tag = 'stimulus_duration_visual';
            app.stimulus_duration_visual.HorizontalAlignment = 'center';
            app.stimulus_duration_visual.Position = [157 186 50 22];
            app.stimulus_duration_visual.Value = 1000;

            % Create stimulation_frequency_visual
            app.stimulation_frequency_visual = uieditfield(app.StimulusPanel, 'numeric');
            app.stimulation_frequency_visual.Tag = 'stimulation frequency visual';
            app.stimulation_frequency_visual.HorizontalAlignment = 'center';
            app.stimulation_frequency_visual.FontWeight = 'bold';
            app.stimulation_frequency_visual.Position = [157 214 50 20];
            app.stimulation_frequency_visual.Value = 2;

            % Create StimulationfreqHzLabel_2
            app.StimulationfreqHzLabel_2 = uilabel(app.StimulusPanel);
            app.StimulationfreqHzLabel_2.FontWeight = 'bold';
            app.StimulationfreqHzLabel_2.Position = [11 213 126 22];
            app.StimulationfreqHzLabel_2.Text = 'Stimulation freq. (Hz)';

            % Create horz
            app.horz = uicheckbox(app.StimulusPanel);
            app.horz.ValueChangedFcn = createCallbackFcn(app, @horzValueChanged, true);
            app.horz.Tag = 'horizontal stripes';
            app.horz.Text = 'Horz Stripes';
            app.horz.FontWeight = 'bold';
            app.horz.Position = [35 100 93 22];

            % Create vert
            app.vert = uicheckbox(app.StimulusPanel);
            app.vert.ValueChangedFcn = createCallbackFcn(app, @vertValueChanged, true);
            app.vert.Tag = 'vertical stripes';
            app.vert.Text = 'Vert Stripes';
            app.vert.FontWeight = 'bold';
            app.vert.Position = [143 99 89 22];

            % Create StripeThicknessDropDownLabel
            app.StripeThicknessDropDownLabel = uilabel(app.StimulusPanel);
            app.StripeThicknessDropDownLabel.FontWeight = 'bold';
            app.StripeThicknessDropDownLabel.Position = [35 10 114 22];
            app.StripeThicknessDropDownLabel.Text = 'Stripe Thickness';

            % Create StripeThicknessDropDown
            app.StripeThicknessDropDown = uidropdown(app.StimulusPanel);
            app.StripeThicknessDropDown.Items = {'1', '2', '3'};
            app.StripeThicknessDropDown.ItemsData = {'1', '2', '3'};
            app.StripeThicknessDropDown.Tag = 'stripe thickness';
            app.StripeThicknessDropDown.Position = [178 10 50 22];
            app.StripeThicknessDropDown.Value = '1';

            % Create combo
            app.combo = uicheckbox(app.StimulusPanel);
            app.combo.ValueChangedFcn = createCallbackFcn(app, @comboValueChanged, true);
            app.combo.Tag = 'combination';
            app.combo.Text = 'Combination';
            app.combo.FontWeight = 'bold';
            app.combo.Position = [33 39 95 22];

            % Create LoadSettingsButton
            app.LoadSettingsButton = uibutton(app.figure1, 'push');
            app.LoadSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @LoadSettingsButtonPushed, true);
            app.LoadSettingsButton.FontWeight = 'bold';
            app.LoadSettingsButton.Position = [879 173 94 38];
            app.LoadSettingsButton.Text = 'Load Settings';

            % Create SaveSettingsButton
            app.SaveSettingsButton = uibutton(app.figure1, 'push');
            app.SaveSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveSettingsButtonPushed, true);
            app.SaveSettingsButton.FontWeight = 'bold';
            app.SaveSettingsButton.Position = [768 173 94 38];
            app.SaveSettingsButton.Text = 'Save Settings';

            % Create StimulusPanel_2
            app.StimulusPanel_2 = uipanel(app.figure1);
            app.StimulusPanel_2.FontWeight = 'bold';
            app.StimulusPanel_2.Position = [706 229 327 262];

            % Create VolumeLabel_3
            app.VolumeLabel_3 = uilabel(app.StimulusPanel_2);
            app.VolumeLabel_3.FontWeight = 'bold';
            app.VolumeLabel_3.Position = [21 200 65 22];
            app.VolumeLabel_3.Text = 'Volume';

            % Create audio_volume
            app.audio_volume = uieditfield(app.StimulusPanel_2, 'numeric');
            app.audio_volume.Tag = 'audio volume';
            app.audio_volume.HorizontalAlignment = 'center';
            app.audio_volume.Position = [167 201 50 20];
            app.audio_volume.Value = 4;

            % Create StimulationfreqHzLabel
            app.StimulationfreqHzLabel = uilabel(app.StimulusPanel_2);
            app.StimulationfreqHzLabel.FontWeight = 'bold';
            app.StimulationfreqHzLabel.Position = [21 142 126 22];
            app.StimulationfreqHzLabel.Text = 'Stimulation freq. (Hz)';

            % Create stimulation_frequency_audio
            app.stimulation_frequency_audio = uieditfield(app.StimulusPanel_2, 'numeric');
            app.stimulation_frequency_audio.Tag = 'stimulation frrequency audio';
            app.stimulation_frequency_audio.HorizontalAlignment = 'center';
            app.stimulation_frequency_audio.FontWeight = 'bold';
            app.stimulation_frequency_audio.Position = [167 143 50 20];
            app.stimulation_frequency_audio.Value = 2;

            % Create stimulus_duration_audio
            app.stimulus_duration_audio = uieditfield(app.StimulusPanel_2, 'numeric');
            app.stimulus_duration_audio.Tag = 'stimulus duration audio';
            app.stimulus_duration_audio.HorizontalAlignment = 'center';
            app.stimulus_duration_audio.Position = [167 115 50 22];
            app.stimulus_duration_audio.Value = 1000;

            % Create StimulusdurationmsLabel
            app.StimulusdurationmsLabel = uilabel(app.StimulusPanel_2);
            app.StimulusdurationmsLabel.FontWeight = 'bold';
            app.StimulusdurationmsLabel.Position = [21 115 136 22];
            app.StimulusdurationmsLabel.Text = 'Stimulus duration (ms)';

            % Create AuditorystimulussettingsLabel
            app.AuditorystimulussettingsLabel = uilabel(app.StimulusPanel_2);
            app.AuditorystimulussettingsLabel.FontSize = 16;
            app.AuditorystimulussettingsLabel.FontWeight = 'bold';
            app.AuditorystimulussettingsLabel.Position = [9 227 208 22];
            app.AuditorystimulussettingsLabel.Text = 'Auditory stimulus settings';

            % Create stimulustypeLabel_2
            app.stimulustypeLabel_2 = uilabel(app.StimulusPanel_2);
            app.stimulustypeLabel_2.FontWeight = 'bold';
            app.stimulustypeLabel_2.Position = [21 78 86 22];
            app.stimulustypeLabel_2.Text = 'stimulus type';

            % Create white_noise
            app.white_noise = uicheckbox(app.StimulusPanel_2);
            app.white_noise.ValueChangedFcn = createCallbackFcn(app, @white_noiseValueChanged, true);
            app.white_noise.Tag = 'white noise';
            app.white_noise.Text = 'White noise';
            app.white_noise.FontWeight = 'bold';
            app.white_noise.Position = [40 53 89 22];

            % Create tone
            app.tone = uicheckbox(app.StimulusPanel_2);
            app.tone.ValueChangedFcn = createCallbackFcn(app, @toneValueChanged, true);
            app.tone.Tag = 'tone';
            app.tone.Text = 'Tone';
            app.tone.FontWeight = 'bold';
            app.tone.Position = [40 31 78 22];

            % Create TonePitchkHzDropDownLabel
            app.TonePitchkHzDropDownLabel = uilabel(app.StimulusPanel_2);
            app.TonePitchkHzDropDownLabel.FontWeight = 'bold';
            app.TonePitchkHzDropDownLabel.Position = [21 174 114 22];
            app.TonePitchkHzDropDownLabel.Text = 'Tone Pitch (kHz)';

            % Create TonePitchkHzDropDown
            app.TonePitchkHzDropDown = uidropdown(app.StimulusPanel_2);
            app.TonePitchkHzDropDown.Items = {'2', '4', '6', '8', '12', '16', '24', '32'};
            app.TonePitchkHzDropDown.ItemsData = {'1', '2', '3', '4', '6', '8', '12', '16'};
            app.TonePitchkHzDropDown.Tag = 'tone pitch';
            app.TonePitchkHzDropDown.Position = [164 174 50 22];
            app.TonePitchkHzDropDown.Value = '1';

            % Create StimulusPanel_3
            app.StimulusPanel_3 = uipanel(app.figure1);
            app.StimulusPanel_3.FontWeight = 'bold';
            app.StimulusPanel_3.Position = [22 299 327 193];

            % Create delaybetweenmsLabel
            app.delaybetweenmsLabel = uilabel(app.StimulusPanel_3);
            app.delaybetweenmsLabel.FontWeight = 'bold';
            app.delaybetweenmsLabel.Position = [64 24 116 22];
            app.delaybetweenmsLabel.Text = 'delay between (ms)';

            % Create delay_between
            app.delay_between = uieditfield(app.StimulusPanel_3, 'numeric');
            app.delay_between.Tag = 'delay between visual and auditory';
            app.delay_between.HorizontalAlignment = 'center';
            app.delay_between.Position = [210 25 50 20];
            app.delay_between.Value = 4;

            % Create ExperimenttypeLabel
            app.ExperimenttypeLabel = uilabel(app.StimulusPanel_3);
            app.ExperimenttypeLabel.FontSize = 16;
            app.ExperimenttypeLabel.FontWeight = 'bold';
            app.ExperimenttypeLabel.Position = [13 164 130 22];
            app.ExperimenttypeLabel.Text = 'Experiment type';

            % Create visual_only
            app.visual_only = uicheckbox(app.StimulusPanel_3);
            app.visual_only.ValueChangedFcn = createCallbackFcn(app, @visual_onlyValueChanged, true);
            app.visual_only.Tag = 'visual only';
            app.visual_only.Text = 'Visual only';
            app.visual_only.FontWeight = 'bold';
            app.visual_only.Position = [27 126 85 22];

            % Create auditory_only
            app.auditory_only = uicheckbox(app.StimulusPanel_3);
            app.auditory_only.ValueChangedFcn = createCallbackFcn(app, @auditory_onlyValueChanged, true);
            app.auditory_only.Tag = 'auditory only';
            app.auditory_only.Text = 'Auditory only';
            app.auditory_only.FontWeight = 'bold';
            app.auditory_only.Position = [27 101 99 22];

            % Create visual_and_auditory
            app.visual_and_auditory = uicheckbox(app.StimulusPanel_3);
            app.visual_and_auditory.ValueChangedFcn = createCallbackFcn(app, @visual_and_auditoryValueChanged, true);
            app.visual_and_auditory.Tag = 'visual and auditory';
            app.visual_and_auditory.Text = 'Visual + auditory';
            app.visual_and_auditory.FontWeight = 'bold';
            app.visual_and_auditory.Position = [27 76 118 22];

            % Create visual_first
            app.visual_first = uicheckbox(app.StimulusPanel_3);
            app.visual_first.Tag = 'visual first';
            app.visual_first.Text = 'Visual first';
            app.visual_first.FontWeight = 'bold';
            app.visual_first.Position = [61 51 83 22];

            % Create StimulusPanel_4
            app.StimulusPanel_4 = uipanel(app.figure1);
            app.StimulusPanel_4.FontWeight = 'bold';
            app.StimulusPanel_4.Position = [22 23 327 265];

            % Create ExperimentsettingsLabel
            app.ExperimentsettingsLabel = uilabel(app.StimulusPanel_4);
            app.ExperimentsettingsLabel.FontSize = 16;
            app.ExperimentsettingsLabel.FontWeight = 'bold';
            app.ExperimentsettingsLabel.Position = [12 235 158 22];
            app.ExperimentsettingsLabel.Text = 'Experiment settings';

            % Create StimulussideButtonGroup
            app.StimulussideButtonGroup = uibuttongroup(app.StimulusPanel_4);
            app.StimulussideButtonGroup.Title = 'Stimulus side';
            app.StimulussideButtonGroup.FontWeight = 'bold';
            app.StimulussideButtonGroup.Position = [20 130 287 86];

            % Create left
            app.left = uiradiobutton(app.StimulussideButtonGroup);
            app.left.Tag = 'stimulus side left';
            app.left.Text = 'Left';
            app.left.FontWeight = 'bold';
            app.left.Position = [15 36 58 22];
            app.left.Value = true;

            % Create right
            app.right = uiradiobutton(app.StimulussideButtonGroup);
            app.right.Tag = 'stimulus side right';
            app.right.Text = 'Right';
            app.right.FontWeight = 'bold';
            app.right.Position = [113 36 65 22];

            % Create alternating
            app.alternating = uiradiobutton(app.StimulussideButtonGroup);
            app.alternating.Tag = 'stimulus side alternating';
            app.alternating.Text = 'Alternating';
            app.alternating.FontWeight = 'bold';
            app.alternating.Position = [90 7 85 22];

            % Create simultaneous
            app.simultaneous = uiradiobutton(app.StimulussideButtonGroup);
            app.simultaneous.Tag = 'stimulus side simultaneous';
            app.simultaneous.Text = 'Simultaneous';
            app.simultaneous.FontWeight = 'bold';
            app.simultaneous.Position = [181 7 101 22];

            % Create LeftRightLabel_2
            app.LeftRightLabel_2 = uilabel(app.StimulussideButtonGroup);
            app.LeftRightLabel_2.Position = [16 7 71 22];
            app.LeftRightLabel_2.Text = 'Left + Right:';

            % Create StimulustimersLabel
            app.StimulustimersLabel = uilabel(app.StimulusPanel_4);
            app.StimulustimersLabel.FontWeight = 'bold';
            app.StimulustimersLabel.Position = [23 84 95 22];
            app.StimulustimersLabel.Text = 'Stimulus timers';

            % Create Interval_minLabel_2
            app.Interval_minLabel_2 = uilabel(app.StimulusPanel_4);
            app.Interval_minLabel_2.FontWeight = 'bold';
            app.Interval_minLabel_2.Position = [42 60 86 22];
            app.Interval_minLabel_2.Text = 'Interval_min';

            % Create Interval_min
            app.Interval_min = uieditfield(app.StimulusPanel_4, 'numeric');
            app.Interval_min.Tag = 'stimulus Interval min';
            app.Interval_min.HorizontalAlignment = 'center';
            app.Interval_min.FontWeight = 'bold';
            app.Interval_min.Position = [191 61 50 20];
            app.Interval_min.Value = 1;

            % Create Interval_maxLabel_2
            app.Interval_maxLabel_2 = uilabel(app.StimulusPanel_4);
            app.Interval_maxLabel_2.FontWeight = 'bold';
            app.Interval_maxLabel_2.Position = [42 33 86 22];
            app.Interval_maxLabel_2.Text = 'Interval_max';

            % Create Interval_max
            app.Interval_max = uieditfield(app.StimulusPanel_4, 'numeric');
            app.Interval_max.Tag = 'stimulus Interval max';
            app.Interval_max.HorizontalAlignment = 'center';
            app.Interval_max.Position = [191 34 50 20];
            app.Interval_max.Value = 4;

            % Create numberofpresentationsLabel_2
            app.numberofpresentationsLabel_2 = uilabel(app.StimulusPanel_4);
            app.numberofpresentationsLabel_2.FontWeight = 'bold';
            app.numberofpresentationsLabel_2.Position = [42 6 146 22];
            app.numberofpresentationsLabel_2.Text = 'number of presentations';

            % Create number_of_presentations
            app.number_of_presentations = uieditfield(app.StimulusPanel_4, 'numeric');
            app.number_of_presentations.Tag = 'stimulus number of presentations';
            app.number_of_presentations.HorizontalAlignment = 'center';
            app.number_of_presentations.Position = [191 7 50 20];
            app.number_of_presentations.Value = 10;

            % Show the figure after all components are created
            app.figure1.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = HERBs_Sensory_Stimulus

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