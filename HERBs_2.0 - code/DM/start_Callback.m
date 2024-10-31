function start_Callback(app)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global run newchar;
global number_of_entries;
global state;
global arduino;
global rtimer stimtimer
global spout1pos spout2pos;
global reward_spout;
global number_of_consecutive_identical_spouts;
global sdata;
global randbuf_left randbuf_right  randptr delay_randptr;
global scount;
global reward_denied;
global vlpair;
global runtimer;
global write_index;
global correct_L correct_R bias_ptr bias_buffer_size;
global stim_duration_value;
global delay_rand_buffer;
global previous_ssd previous_tcsa;
global wrong_spout;
global correct_count_L correct_count_R;
global incorrect_count_L incorrect_count_R;
global number_of_left_trials number_of_right_trials;
global number_of_left_retrials number_of_right_retrials;
global from_retrial;
global fidtxt;
global from_file_count;
global forced_left_count  forced_right_count; 
global notes notestime;



% wrong_spout = 0;  % to be used later for ssd and tcsa

hwt = waitbar(0,'Please Wait ...');
correct_count_L = 0;
correct_count_R = 0;
incorrect_count_L = 0;
incorrect_count_R = 0;
number_of_left_trials = 0;
number_of_right_trials = 0;
number_of_left_retrials= 0;
number_of_right_retrials=0;
from_retrial = 0;

app.LCorrect.Text = num2str(correct_count_L);
app.RCorrect.Text = num2str(correct_count_R);
app.LTrials.Text = num2str(number_of_left_trials);
app.RTrials.Text = num2str(number_of_right_trials);
app.LReTrials.Text = num2str(number_of_left_retrials);
app.RReTrials.Text = num2str(number_of_right_retrials);

previous_ssd = [];
previous_tcsa = [];

stim_duration_value = app.stim_duration.Value;

write_index = 1;
% bias parms
bias_buffer_size = (app.bias_buffer.Value);
correct_L  = zeros(10000,1); % good for 10000 points
correct_R  = zeros(10000,1);
bias_ptr  =  1;

vlpair(1) = 0;
reward_denied = 0;
scount = 0;
app.state1_count.Text = '0';
rng('shuffle');

% --------------------------------
% init delay buffers
delay_rand_buffer =  linspace(app.min_delay.Value, app.max_delay.Value,app.numberofsteps.Value);
delay_rand_buffer = round(delay_rand_buffer,3); % to 1 ms resolution
delay_randptr = 1;
delay_rand_buffer = delay_rand_buffer(randperm(numel(delay_rand_buffer)));
% --------------------------------
% init timers

delete(timerfindall);

rtimer = timer;
rtimer.ExecutionMode ='singleshot';
rtimer.TimerFcn = {@next_state};
rtimer.StartFcn = {@start_state};
rtimer.StartDelay = 2;

% for stim control
stimtimer = timer;
stimtimer.ExecutionMode ='singleshot';
stimtimer.TimerFcn = {@stim_start,app};
stimtimer.StartDelay = (app.stim_start_delay.Value);

% --------------------------------

randbuf_left = randperm(3);
randbuf_right = 3 + randperm(3);
randptr = 1;

% --------------------------------
if app.RateDiscrimination.Value 
    if app.two_rates_only.Value
        create_2rates_table(app);
    else
        create_mixed_rates_table(app);
    end
    update_rates(app);
end
% --------------------------------

dirname = app.animalid.Value;
if (exist(dirname,'dir') ~= 7)
   mkdir(dirname);
end

% light_Callback(0,7);
% pause(0.1);
% light_Callback(1,7);
% pause(0.1);
% light_Callback(2,7);
stop_all_stims();

% if get(app.retrial_mode,'value')
%     set(app.punishment_active,'value',0);
%     set(app.timeout_punishment,'value',0);
% end
fn = [dirname '/'  datestr(now,'mm_dd_yyyy___HH_MM_SS') ];
diary([fn  '.txt']);

print_settings(app);
state = saveStatus(app,'gui_settings_Decision_Making.mat');
write_excel_file(state,[fn '.xls']);


fprintf(' \n');
fprintf('-------------------------------------------------- ');
fprintf(' \n');

spout1pos.rest = app.sp1rest.Value;
spout1pos.ext = app.sp1ext.Value;
spout2pos.init = 0;
spout2pos.rest = app.sp2rest.Value;
spout2pos.ext = app.sp2ext.Value;

write(arduino,['q' round(str2double(app.reward_pulse_C.Value))],"uint8");
pause(0.05);
write(arduino,['v' round(str2double(app.reward_pulse_L.Value))],"uint8");
pause(0.05);
write(arduino,['w' round(str2double(app.reward_pulse_R.Value))],"uint8");
pause(0.05);
write(arduino,['u' round((app.airpuff_duration.Value))],"uint8")

% ---------------------------------------------------
% initialize light panel
write(arduino,['}'  round(app.brightness.Value) 1],"uint8");   % do  initialize panels
wait_for_ack();
fprintf('%4.3f light panels initialized\n',toc);
% pause(1.5);
% ---------------------------------------------------
% initialize volume
write(arduino,'a',"uint8");
audio_volume = app.volume.Value;
write(arduino,audio_volume,"uint8");
fprintf('%4.3 audio volume = %d \n',toc,audio_volume);
    
% %     tone freq
% tf = app.DM_tone_freq.Value;
% btl = mod(tf,256); 
% bth = floor(tf/256);
% write(arduino,['=' btl bth]);
% ---------------------------------------------------


% for state control
rtimer.StartDelay = 2;

% for experiment duration
runtimer = timer;
runtimer.ExecutionMode ='singleshot';
% runtimer.TimerFcn = {@stoprun,app};
runtimer.TimerFcn = {@stoprun};
runtimer.StartDelay = (app.ex_duration.Value);

run = 1;
app.start.Text  = 'Stop';
% app.start.Enable  = 'off';

bav = get(arduino,'BytesAvailable');
if bav > 0
    a = fread(arduino,bav);    
    fprintf('%s',a)
end

enint_Callback( app);
newchar = 0;
number_of_entries = 0;

state = '0';
app.statenumber.Text  = state;
start(rtimer);
diary on;

number_of_consecutive_identical_spouts = 0;
% fprintf('%4.3f state 0\n',toc);

bav = get(arduino,'BytesAvailable');
if bav > 0
    sdata = fread(arduino,bav);    
    fprintf('%4.3f %s  \n',toc,sdata);
    sdata = [];
end

start(runtimer);
reward_spout = 0;
vlpair = [0 5];

if app.usefile.Value
    fn = app.input_filename.Value;
    fidtxt = fopen(fn,'r');
    from_file_count = 0;
end

% see if forced sequence active
% if so initialize the counters
if app.forced_sequence.Value
    if app.left_first.Value
          forced_left_count = app.number_of_lefts.Value;
          forced_right_count = 0;
    else
          forced_right_count = app.number_of_rights.Value;
          forced_left_count = 0;
    end
end

delete(hwt);
% -------------------------
tic;
state_machine_DM(app)
% -------------------------

stop(timerfindall);
% noise off
% write(arduino,'>');
write(arduino,['=' 0 'e' 3 0 0],"uint8");
fprintf('%4.3f noise_stop \n',toc);
pause(0.05);
% retract spouts at the end
control_spouts(0,0,app);
% stop(stimtimer);
stop_all_stims();

% light_off(0,0,app);          % GL edit 7.4.19 not perfect! (error if stopped before lights)
reward_denied = 0;                                  % GL edit 7.6.19

app.start.Text = 'Start';
state = '0';
app.statenumber.Text = state;
delete(timerfindall);

fprintf('\n\n');
fprintf('edit: ');
for i = 1:write_index-1
    fprintf('%4.3f  %s \n',notestime{i},char(notes(i)));
end
   
diary off;
stop_all_stims();
