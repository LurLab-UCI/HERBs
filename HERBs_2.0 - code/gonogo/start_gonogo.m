function start_gonogo(app)

global next_trial_type;
global false_alarm_count hit_count correct_reject_count  miss_count;
global number_of_presentations_count;
global randbuf randptr randbuf_seed;
global arduino sdata;
global write_index;
global previous_trial number_of_consecutive_alternating_trials number_of_consecutive_identical_trials;
global stim_startd_buf  stim_startd_ptr  stim_startd_buf_seed
global notestime notes;

% check and make sure that  both Stim Start Delay and Delay Period do not have non-zero entered  entries
if min(app.delay_period_number_of_steps.Value,app.stim_start_delay_number_of_steps.Value) > 1
     errordlg('Number of Steps in either Delay Period or Stim Start Delay must be 0 ','Settings  Error');    
     return;
end

hwt = waitbar(0,'Please Wait ...');

false_alarm_count = 0;
hit_count = 0;
correct_reject_count = 0;
miss_count =0;
number_of_presentations_count = 0;

number_of_consecutive_alternating_trials  = 0;
number_of_consecutive_identical_trials = 0;
previous_trial = '';

rng('shuffle');

app.presentation_number.Text = num2str(number_of_presentations_count);

app.CRLabel.Text = ['CR ' num2str(correct_reject_count)];
app.MISSLabel.Text = ['MISS ' num2str(miss_count)];
app.FALabel.Text = ['FA ' num2str(false_alarm_count)];
app.HITLabel.Text = ['HIT ' num2str(hit_count)];

randbuf_seed = [];
randptr = [];
randbuf = [];
randbuf_seed.g =  linspace(app.delay_period_min.Value , app.delay_period_max.Value,app.delay_period_number_of_steps.Value);
randbuf_seed.g = round(1000*randbuf_seed.g)/1000;
randbuf.g = randbuf_seed.g(randperm(length(randbuf_seed.g)));
randptr.g = 1;

randbuf_seed.n =  linspace(app.delay_period_min.Value , app.delay_period_max.Value,app.delay_period_number_of_steps.Value);
randbuf_seed.n = round(1000*randbuf_seed.n)/1000;
randbuf.n = randbuf_seed.n(randperm(length(randbuf_seed.n)));
randptr.n = 1;

randbuf_seed.c =  linspace(app.delay_period_min.Value , app.delay_period_max.Value,app.delay_period_number_of_steps.Value);
randbuf_seed.c = round(1000*randbuf_seed.c)/1000;
randbuf.c = randbuf_seed.c(randperm(length(randbuf_seed.c)));
randptr.c = 1;


stim_startd_buf_seed = [];
stim_startd_buf_seed.g =  linspace(app.stim_start_delay_min.Value , app.stim_start_delay_max.Value,app.stim_start_delay_number_of_steps.Value);
stim_startd_buf_seed.g = round(1000*stim_startd_buf_seed.g)/1000;
stim_startd_buf.g = stim_startd_buf_seed.g(randperm(length(stim_startd_buf_seed.g)));
stim_startd_ptr.g = 1;

stim_startd_buf_seed.n =  linspace(app.stim_start_delay_min.Value , app.stim_start_delay_max.Value,app.stim_start_delay_number_of_steps.Value);
stim_startd_buf_seed.n = round(1000*stim_startd_buf_seed.n)/1000;
stim_startd_buf.n = stim_startd_buf_seed.n(randperm(length(stim_startd_buf_seed.n)));
stim_startd_ptr.n = 1;

stim_startd_buf_seed.c =  linspace(app.stim_start_delay_min.Value , app.stim_start_delay_max.Value,app.stim_start_delay_number_of_steps.Value);
stim_startd_buf_seed.c = round(1000*stim_startd_buf_seed.c)/1000;
stim_startd_buf.c = stim_startd_buf_seed.c(randperm(length(stim_startd_buf_seed.c)));
stim_startd_ptr.c = 1;

dirname = app.animalid.Value;
if (exist(dirname,'dir') ~= 7)
   mkdir(dirname);
end

fn = [dirname '/'  datestr(now,'mm_dd_yyyy___HH_MM_SS') ];
diary([fn  '.txt']);

print_settings_gonogo(app);
state = saveStatus(app,'gui_settings_gonogo.mat');
write_excel_file(state,[fn '.xls']);

fprintf(' \n');
fprintf('-------------------------------------------------- ');
fprintf(' \n');

next_trial_type = 'gonogo';
bav = arduino.BytesAvailable;
if bav > 0
    temp = read(arduino,bav,"uint8");    
end

sdata = [];
tic;
b1 = str2double(app.stimulation_type_visual_go.Value);
b2 = str2double(app.stripe_bar_thickness_go.Value);
b3 = str2double(app.stimulation_type_visual_nogo.Value);
b4 = str2double(app.stripe_bar_thickness_nogo.Value);
write(arduino,['"'  b1 b2 b3 b4],"uint8");
wait_for_ack();

% % ---------------------------------------------------
% % initialize volume
% write(arduino,'a');
% audio_volume = app.volume.Value;
% write(arduino,audio_volume);
% fprintf('%4.3 audio volume = %d \n',toc,audio_volume);


% for experiment duration
runtimer = timer;
runtimer.ExecutionMode ='singleshot';
% runtimer.TimerFcn = {@stoprun,app};
runtimer.TimerFcn = {@stoprun};
runtimer.StartDelay = (app.ex_duration.Value);
start(runtimer);
delete(hwt);

% =======================================
state_machine(app);
% =======================================

control_spouts_gonogo(0,0,app);
fprintf('%4.3f  state machine exited   \n ',toc);
app.statetext.Text = ''; 

stop(timerfindall);
delete(timerfindall);

fprintf('\n\n');
fprintf('edit: ');
for i = 1:write_index-1
    fprintf('%4.3f  %s \n',notestime{i},char(notes(i)));
end
   
diary off;
stop_all_stims();


