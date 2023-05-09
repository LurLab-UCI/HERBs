function stop_gonogo(a,b,app)

global run;
app.start.Text = 'Start';
run = 0;
app.trial_text.Text = '';
fprintf('%3.3f  stopping no response timer\n',toc);

