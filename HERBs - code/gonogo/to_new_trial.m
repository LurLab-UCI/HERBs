
function to_new_trial(app)

global state statetimer;
global lick_counter;
global arduino;
global next_trial_type trial_type;
global lick_detected;
global previous_trial number_of_consecutive_alternating_trials number_of_consecutive_identical_trials;
global stim_startd_buf  stim_startd_ptr  stim_startd_buf_seed



stop(statetimer);
% stop(timerfindall);


state = 'stim_start_delay';
app.statetext.Text = state; 


% if previous trial was catch the zero out
if strcmp(trial_type,'catch')
    number_of_consecutive_alternating_trials  = 0;
    number_of_consecutive_identical_trials = 0;
end

%   write 3000 to  quad dac ch C
 write(arduino,['c' 2  0 0],"uint8");


% --------------------------------
% determine the trial type
% trial type 'gonogo' means it can be either on

if strcmp(next_trial_type,'go')
         trial_type = 'go';
         app.trial_text.Text = 'Go Trial';
else
        if  rand > app.percentage_of_catch_trials.Value/100

        %         not a catch trial
                % determine what stimulus to use
                % start stimulus
                % decide between go and nogo
                
                if  rand < app.percentage_of_go_trials.Value/100
                %     go trial
                        trial_type = 'go';
                else
                %     nogo trial
                        trial_type = 'nogo';
                end
                
%                 only verify trial type  if cr rule not checked
                if app.cr_rule.Value == 0
%                 check for too many consecutive types
                    trial_type = verify_next_trial_type(trial_type);
                end
                 previous_trial = trial_type;
                
        else
                % if a catch trial do not start stimulus
                  trial_type = 'catch';
        end
end

switch trial_type
    case 'go'
             app.trial_text.Text = 'Go Trial';
    case 'nogo'
              app.trial_text.Text = 'NoGo Trial';
    case 'catch'
             app.trial_text.Text = 'Catch Trial';
end

fprintf('------------------------------------\n');
fprintf('%4.3f  starting new trial     %s\n',toc,trial_type);
fprintf('%4.3f  going  to  stim_start_delay  \n',toc);

% --------------------------------
% select start signal

duration =  app.start_signal_duration.Value;
ncyc = 1;
up_ms = duration*1000;  %from ms
low_ms = 1;  % only one up cycle
ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);
up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256); 
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 

lick_counter = 0;
lick_detected = 0;

switch app.trial_start_signal.Value
    case 'visual'
        %         start visual signal here

        dac_val = 1;
        panel = 5;

        write(arduino,['&'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val],"uint8");

    case 'tone'
        %         start tone signal here
        write(arduino,'a',"uint8");
        audio_volume = app.start_tone_volume.Value;
        write(arduino,audio_volume,"uint8");

        tf = round(str2double(app.start_tone_pitch.Value));

        mbank = 1;
        write(arduino,['=' tf],"uint8");  % skip (for frequency)

        write(arduino,['m'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  0],"uint8");
        write(arduino,['n'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  0],"uint8");
       
    case 'noise'
%          start noise  signal here
        
        write(arduino,'a',"uint8");
        audio_volume = app.audio_volume_go.Value;
        write(arduino,audio_volume,"uint8");

%         tf = round(str2double(app.start_tone_pitch.Value));
        tf = 1;

        mbank = 2;
        write(arduino,['=' tf],"uint8");  % skip (for frequency)

        write(arduino,['m'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  0],"uint8");
        write(arduino,['n'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  0],"uint8");

    case 'none'
%          do not start any start signal
                
end

%------------------------------------------------------------
% figure out new stim start delay

switch trial_type
    case 'go'
                %     go trial
                        % next state is delay period
                        dl =  stim_startd_buf.g(stim_startd_ptr.g);
                        %    update pointers for future use
                        stim_startd_ptr.g = 1 + mod(stim_startd_ptr.g,length(stim_startd_buf.g));
                        if stim_startd_ptr.g == 1
                               stim_startd_buf.g = stim_startd_buf_seed.g(randperm(length(stim_startd_buf_seed.g)));
                        end

    case 'nogo'
               %     nogo trial
                        % next state is delay period
                        dl =  stim_startd_buf.n(stim_startd_ptr.n);
                        %    update pointers for future use
                        stim_startd_ptr.n = 1 + mod(stim_startd_ptr.n,length(stim_startd_buf.n));
                        if stim_startd_ptr.n == 1
                               stim_startd_buf.n = stim_startd_buf_seed.n(randperm(length(stim_startd_buf_seed.n)));
                        end

    case 'catch'
                        % next state is delay period
                        dl =  stim_startd_buf.c(stim_startd_ptr.c);
                        %    update pointers for future use
                        stim_startd_ptr.c = 1 + mod(stim_startd_ptr.c,length(stim_startd_buf.c));
                        if stim_startd_ptr.c == 1
                               stim_startd_buf.c = stim_startd_buf_seed.c(randperm(length(stim_startd_buf_seed.c)));
                        end
end
%------------------------------------------------------------

% statetimer.StartDelay = app.stim_start_delay.Value;
statetimer.StartDelay = dl;
start(statetimer);
fprintf('%4.3f starting  stim_start_delay    %3.3f\n',toc,dl);

