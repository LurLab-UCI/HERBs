function to_iti_long(app)
global statetimer state arduino;
global spout1pos;
global lick_detected;
stop(statetimer);

lick_detected = 0;
% added 4/2/2021
control_spouts_gonogo(spout1pos.rest,0,app);

dl = (app.iti_min.Value + rand*(app.iti_max.Value - app.iti_min.Value));
dl = round(1000*dl)/1000;
statetimer.StartDelay = dl;
start(statetimer);
state = 'iti';
app.statetext.Text = state; 
fprintf('%4.3f starting iti    %4.3f  \n',toc,dl);





