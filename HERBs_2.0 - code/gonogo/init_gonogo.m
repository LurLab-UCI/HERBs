function init_gonogo(app)
global state;
global arduino;
global spout1pos spout2pos;
global light_value;
global previous_spout;
global rest_pause;
global randtable;
global lightval;
global vobj preview_active;
global write_index;
global reward_denied;
global sdata;
global audio_volume;
global run;
global dac_val_table dac_val_audio;
global no_response_timer;
global dacvoltage;

dacvoltage.visual.go = 10;
dacvoltage.visual.nogo = 20;
dacvoltage.visual.catch = 30;


%                   left panel view from led side
%     --------------------------------------
%     |           |           |           |           |           |
%     |    1     |           |     0    |           |    5     |          connector side 
%     |           |           |           |           |           |
%     --------------------------------------

%                   right panel view from led side
%     --------------------------------------
%     |           |           |           |           |           |
%     |    0     |           |     1    |           |    5     |          connector side 
%     |           |           |           |           |           |
%     --------------------------------------

%                   center panel view from led side
%     --------------------------------------
%     |        |           |                |           |        |
%     |        |     1    |                |    0     |        |          connector side 
%     |        |           |                |           |        |
%     --------------------------------------

% each panel has 8 pages ( from 0 to 7)
%  page 4 (all panels) turns on all leds
%  page 7 (all panels) turns off all leds
% the other  patterns are shown above  with page numbers on the active(leds  on) areas

% values to dac,   10 equals 1.0 Volts 
dac_val_table = [10  15  0  0  05  05  0   0  ; ...     % Left Panel 0     pages 0 - 7
                            20  25  0  0  10  0    0   0; ...        %Center Panel 1      pages 0 - 7
                            30  35  0  0  40  40  0   0 ];         % Right Panel 2     pages 0 - 7

                        
% init single dac 4725
% 10 corresponds to roughly 1 V
dac_val_audio.go_L =  10;                       %left
dac_val_audio.go_R =  10;                       %right
dac_val_audio.nogo_L =  20;                   %left    
dac_val_audio.nogo_R =  20;                    %right   
dac_val_audio.punish =  05;                       

run = 0;

audio_volume = 0;
sdata  ={'test'};
reward_denied = 0;
write_index = 1;

% set_backgrounds(app);

tic;
d = uiprogressdlg(app.figure1,'Title','Please Wait', 'Message','Opening the application');
% imaqreset;

preview_active = 0;
% randtable = [0 0 ; 0 1; 1 0; 1 1 ; 1 2; 1 3; 2 0 ; 2 1];
randtable = [0 0 ; 0 1; 1 0; 1 1; 2 0 ; 2 1];

lightval = 1;
rest_pause = 1.0;
previous_spout = 0;

light_value = 3;

spout1pos.init = 0;
spout1pos.rest = app.sp1rest.Value;
spout1pos.ext = app.sp1ext.Value;
% spout2pos.init = 0;
% spout2pos.rest = app.sp2rest.Value;
% spout2pos.ext = app.sp2ext.Value;

state = '0';
% delete(instrfindall);

devs = fcom();
[r,c] = size(devs);

for i = 1:r
    [str,n] =  devs{i,:};
    if ~isempty(str)
        if contains(string(str),'Arduino') &&  contains(string(str),'Mega')
            break;
        end
    end
end


if isempty(n)
    fg = uifigure;
    msg = 'No Arduino Detected, Connnect Arduino and try again!';
    title = 'No Arduino Detected';
    an = uiconfirm(fg,msg,title,'Options',{'OK'});
    delete(fg);
    return;
end


comstr = ['COM' num2str(n)]; % ,'Mega'];

arduino = [];

arduino=serialport(comstr,115200); % create serial communication object on port COM4
arduino.Timeout = 0.05;

configureTerminator(arduino,"CR/LF");
configureCallback(arduino,"terminator",@(src,evnt)read_serial_gonogo(src,evnt,app))

if isempty(app.animalid.Value)
        app.animalid.Value =  'animalid';
end

% initialize the reward pulse and air puff durations
write(arduino,'q',"uint8");
write(arduino,round(str2double(app.reward_pulse_C.Value)),"uint8");
pause(0.05);

app.line_delay_go.Enable = 'off';
app.line_delay_nogo.Enable = 'off';

% init rewrad pulse width

value = app.reward_pulse_C.Value;
write(arduino,['q' value],"uint8");



% set audio volume to 0
write(arduino,'t',"uint8");

close(d);

no_response_timer = timer;
no_response_timer.ExecutionMode ='singleshot';
no_response_timer.TimerFcn = {@stop_gonogo,app};
no_response_timer.StartDelay = app.max_window_of_no_responses.Value;


% init_camera(hObject, eventdata, handles);
