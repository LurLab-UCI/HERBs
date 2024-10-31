function update_stim_guis(app)

app.visual_stimulus_duration_go_vl = (app.visual_stimulation_pulse_width_go.Value)*(2*app.visual_stimulation_number_of_pulses_go.Value - 1);
app.visual_stimulus_duration_nogo_vl = (app.visual_stimulation_pulse_width_nogo.Value)*(2*app.visual_stimulation_number_of_pulses_nogo.Value - 1);
app.audio_stimulus_duration_go_vl = (app.audio_stimulation_pulse_width_go.Value)*(2*app.audio_stimulation_number_of_pulses_go.Value - 1);
app.audio_stimulus_duration_nogo_vl = (app.audio_stimulation_pulse_width_nogo.Value)*(2*app.audio_stimulation_number_of_pulses_nogo.Value - 1);

app.visual_stimulus_duration_go.Text = num2str(app.visual_stimulus_duration_go_vl ,'%4.0f');
app.visual_stimulus_duration_nogo.Text = num2str( app.visual_stimulus_duration_nogo_vl ,'%4.0f');

app.audio_stimulus_duration_go.Text = num2str(app.audio_stimulus_duration_go_vl ,'%4.0f');
app.audio_stimulus_duration_nogo.Text = num2str(app.audio_stimulus_duration_nogo_vl ,'%4.0f');
 
app.visual_stimulus_duration_go_vl = app.visual_stimulus_duration_go_vl/1000;
app.visual_stimulus_duration_nogo_vl = app.visual_stimulus_duration_nogo_vl/1000;
app.audio_stimulus_duration_go_vl = app.audio_stimulus_duration_go_vl/1000;
app.audio_stimulus_duration_nogo_vl = app.audio_stimulus_duration_nogo_vl/1000;