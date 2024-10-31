function update_stim_guis(app)

app.visual_stimulus_duration.Text = num2str((app.visual_stimulation_pulse_width.Value)*(2*app.visual_stimulation_number_of_pulses.Value - 1),'%4.0f');
app.audio_stimulus_duration.Text = num2str((app.audio_stimulation_pulse_width.Value)*(2*app.audio_stimulation_number_of_pulses.Value - 1),'%4.0f');
