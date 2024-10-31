function     duration  =     start_nogo_stimulus(app)
global dacvoltage;

if app.visual_active_nogo.Value
    
%     visual stimulus
   duration =  start_light_sequence_nogo(app,dacvoltage.visual.nogo);

else
% auditory  stimulus
   duration=  start_audio_sequence_nogo(app);

end

