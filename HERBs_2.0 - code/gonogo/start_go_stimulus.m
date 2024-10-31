function     duration =     start_go_stimulus(app)

global dacvoltage;

if app.visual_active_go.Value
    
%     visual stimulus

  duration =   start_light_sequence_go(app,dacvoltage.visual.go);

else
% auditory  stimulus

  duration =  start_audio_sequence_go(app);

end

