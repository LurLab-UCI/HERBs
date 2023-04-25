function init_DM(app)
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
global dac_val_table;

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

run = 0;

audio_volume = 0;
sdata  ={'test'};
reward_denied = 0;
write_index = 1;

% set_backgrounds(app);

tic;

d = uiprogressdlg(app.figure1,'Title','Please Wait', 'Message','Opening the application');
imaqreset;

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
spout2pos.init = 0;
spout2pos.rest = app.sp2rest.Value;
spout2pos.ext = app.sp2ext.Value;

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

comstr = ['COM' num2str(n)]; % ,'Mega'];

arduino = [];

% arduino=serial(comstr,'BaudRate',115200); % create serial communication object on port COM4
% arduino.BytesAvailableFcnCount = 3;
% arduino.BytesAvailableFcnMode = 'byte';
% fopen(arduino); % initiate arduino communication

arduino=serialport(comstr,115200); % create serial communication object on port COM4
arduino.Timeout = 0.05;

% wait until data from arduino
while 1
    bav = get(arduino,'BytesAvailable');
    
    if bav > 0
        sdata = read(arduino,bav,"uint8");    
%         fprintf('init %4.3f %s \n',toc,sdata);   %GL edit added \n to string
    end

    if contains(char(sdata),'Rset')
        break
    end
end


configureCallback(arduino,"byte",3,@(src,evnt)read_serial(src,evnt))

% sdata = fread(arduino,bav);    
% make sure 'Rset' received
% if ~contains(char(sdata'),'Rset')
%     return;
% end

% start serial reads in background
% arduino.BytesAvailableFcn = {'read_serial'};

if isempty(app.animalid.Value)
        app.animalid.Value =  'animalid';
end

% fprintf(' %s \n',sdata);   %GL edit added \n to string

% initialize the reward pulse and air puff durations
write(arduino,'q',"uint8");
write(arduino,round(str2double(app.reward_pulse_C.Value)),"uint8");
pause(0.05);
write(arduino,'v',"uint8");
write(arduino,round(str2double(app.reward_pulse_L.Value)),"uint8");
pause(0.05);
write(arduino,'w',"uint8");
write(arduino,round(str2double(app.reward_pulse_R.Value)),"uint8");
pause(0.05);
write(arduino,'u',"uint8");
write(arduino,round((app.airpuff_duration.Value)),"uint8");


% set audio volume to 0
write(arduino,'t',"uint8");

close(d);

% init_camera(hObject, eventdata, handles);
