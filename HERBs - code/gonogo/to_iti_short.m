function to_iti_short(app)
global statetimer state arduino;

stop(statetimer);
dl = (app.short_iti_min.Value + rand*(app.short_iti_max.Value - app.short_iti_min.Value));
dl = round(1000*dl)/1000;
statetimer.StartDelay = dl;
start(statetimer);
state = 'iti';
app.statetext.Text = state; 
fprintf('%4.3f starting iti short       %4.3f \n',toc,dl);




