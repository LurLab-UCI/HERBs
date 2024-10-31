function Start_SS(app)
global arduino ack;
global run;
global lrflag;
global ack sdata;
global counter;
global excelfn;

fn = [datestr(now,'mm_dd_yyyy___HH_MM_SS') '.xls'];

state = saveStatus(app,'gui_settings_SS.mat');
write_excel_file(state,fn)

lrflag = [];
ack = 0;
% write(arduino,'?');
if app.left.Value
%     write(arduino,0); % left
    lrflag.a = 1;
    lrflag.v = 1;
elseif app.right.Value
%     write(arduino,1); % right 
    lrflag.a = 2;
    lrflag.v = 2;
elseif app.simultaneous.Value
%     write(arduino,3); % all panels
    lrflag.a = 3;
    lrflag.v = 3;
else
    lrflag.a = 1;   % alternating start with ;left
    lrflag.v = 1;   % alternating start with ;left
end
   
run = 1;

%                 volume here ???
write(arduino,'a',"uint8");
audio_volume = app.audio_volume.Value;
write(arduino,audio_volume,"uint8");
fprintf('audio volume = %d \n',audio_volume);

 write(arduino,['}' round(app.brightness.Value) 0],"uint8");
page = 0;
l  = str2double(app.StripeThicknessDropDown.Value);

%  panel mode
if app.full.Value
%     write(arduino,['+' 4]); %  full panel
    page = 4;
    reinit_light(0);
elseif app.small.Value
%     write(arduino,['+' 5]); %  small panel
    page = 5;
    reinit_light(0);
elseif app.vert.Value
%     write(arduino,['+' 2]); %  vert panel
    page = 2;
    reinit_light(l);
elseif app.horz.Value
%     write(arduino,['+' 6]); %  horz panel
    page = 3;
     reinit_light(l);
elseif app.combo.Value
    reinit_light(l);
    
%     sdata = [];
%     write(arduino,[';'  l]);
%     t = toc;
%     while ~contains(char(sdata)','ack')
%         pause(0.1);
%                 fprintf('ack = %s \n',sdata);
%     end
%     t-toc
    page = 0;
end
%======= restart counter:
counter = '0';
app.p_count.Text = num2str(counter);


% ====================
if app.visual_only.Value   % Visual only
    visual_only_stimulus(app,lrflag.v,page);
elseif  app.auditory_only.Value   % auditory only
    auditory_only_stimulus(app,lrflag.a);
else
    visual_and_auditory_stimulus(app,lrflag,page);
end
%         clear page 6
 write(arduino,'@',"uint8");
            
 
 
function      reinit_light(fl)
 global sdata arduino; 
sdata = [];
write(arduino,[';'  fl],"uint8");
t = toc;
while ~contains(char(sdata),'ack')
    pause(0.01);
   % fprintf('ack = %s \n',sdata);
end
t-toc;
    
