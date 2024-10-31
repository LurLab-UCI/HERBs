function     [left_rate, right_rate,single_panel_rate ] = pick_rates(app,difficulty,next_spout)

global rate_table number_of_difficulty_levels;

single_panel_rate = [];
left_rate = [];
right_rate = [];

ctr = ceil(length(rate_table)/2);
lvl = ctr - difficulty;  

if ~app.single_panel.Value
    %                pick on difficulty level
        if next_spout == 0  % left
           if app.higher_rate_correct.Value 
               left_rate = rate_table(ctr+lvl);
               right_rate = rate_table(ctr-lvl);
           else
               left_rate = rate_table(ctr-lvl);
               right_rate = rate_table(ctr+lvl);
           end
        else  % right
           if app.higher_rate_correct.Value 
               left_rate = rate_table(ctr-lvl);
               right_rate = rate_table(ctr+lvl);
           else
               left_rate = rate_table(ctr+lvl);
               right_rate = rate_table(ctr-lvl);
           end
        end
else

        if next_spout == 0  % left
           if app.higher_rate_correct.Value 
               single_panel_rate = rate_table(ctr-lvl);
           else
               single_panel_rate = rate_table(ctr+lvl);
           end
        else  % right
           if app.higher_rate_correct.Value 
               single_panel_rate = rate_table(ctr+lvl);
           else
               single_panel_rate = rate_table(ctr-lvl);
           end
        end

end
