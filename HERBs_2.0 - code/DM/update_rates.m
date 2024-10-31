 function  update_rates(app) 

global rate_table boundary_frequency number_of_difficulty_levels;

% number_of_difficulty_levels =str2double( app.mixed_rates_number_of_steps.Value);
number_of_difficulty_levels = 4;
rate_table = [];
logbase = sqrt(app.high_rate.Value/app.low_rate.Value);
boundary_frequency = app.high_rate.Value/logbase;
idx = 1;
for e = -number_of_difficulty_levels:number_of_difficulty_levels
    rate_table(idx)  = boundary_frequency * logbase^(e/number_of_difficulty_levels);
    idx = idx + 1;
end
carr = num2str(rate_table','%2.2f');
app.RatesTextArea.Value = cellstr(carr);
