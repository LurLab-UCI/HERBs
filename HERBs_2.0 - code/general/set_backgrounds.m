function set_backgrounds(app)
ac = [0.75 1 1];
dc =  [0.94 0.94 0.94] ;

if app.DM.Value
    app.Panel_DM.BackgroundColor  = ac;
    app.ButtonGroup_DM.BackgroundColor = ac;
    app.StimulusPanel.BackgroundColor  =dc;
    app.ButtonGroup_SS.BackgroundColor = dc;
    app.LeftRightButtonGroup.BackgroundColor = dc;
    app.NoiseToneButtonGroup.BackgroundColor = dc;
    
else
    app.Panel_DM.BackgroundColor  = dc;
    app.ButtonGroup_DM.BackgroundColor = dc;
    app.StimulusPanel.BackgroundColor  =ac;
    app.ButtonGroup_SS.BackgroundColor = ac;
    app.LeftRightButtonGroup.BackgroundColor = ac;
    app.NoiseToneButtonGroup.BackgroundColor = ac;
end
