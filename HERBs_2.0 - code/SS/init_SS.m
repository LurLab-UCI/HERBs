function init_SS(app)
global state;
global arduino;
global light_value;
global randtable;
global lightval;
global preview_active;
global write_index;
global reward_denied;
global sdata;
global audio_volume;
global run;
global dac_val_table;



% delete(serialportlist);
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
% imaqreset;

preview_active = 0;
% randtable = [0 0 ; 0 1; 1 0; 1 1 ; 1 2; 1 3; 2 0 ; 2 1];
randtable = [0 0 ; 0 1; 1 0; 1 1; 2 0 ; 2 1];

lightval = 1;
light_value = 3;

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
% arduino=serial(comstr,'BaudRate',115200); % create serial communication object on port COM4
% arduino.BytesAvailableFcnCount = 3;
% arduino.BytesAvailableFcnMode = 'byte';
% fopen(arduino); % initiate arduino communication

arduino = serialport(comstr,115200); % create serial communication object on port COM4
arduino.Timeout = 0.05;
% configureCallback(app.arduino,"terminator",@rdser,1);
% configureCallback(app.arduino,"terminator",@(src,evnt)rdser(src,evnt,app))

configureTerminator(arduino,"CR/LF");
configureCallback(arduino,"terminator",@(src,evnt)read_serial_SS(src,evnt,app))


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

% sdata = fread(arduino,bav);    
% make sure 'Rset' received
% if ~contains(char(sdata'),'Rset')
%     return;
% end

% start serial reads in background
% arduino.BytesAvailableFcn = {'read_serial'};
% configureCallback(arduino,"byte",3,@(src,evnt)read_serial(src,evnt));

% fprintf(' %s \n',sdata);   %GL edit added \n to string
if 0
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
% write(arduino,'u');
% write(arduino,round((app.airpuff_duration.Value)));
end

% set audio volume to 0
write(arduino,'t',"uint8");

close(d);

% init_camera(hObject, eventdata, handles);
