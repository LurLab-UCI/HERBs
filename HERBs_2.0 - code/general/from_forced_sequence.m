function [next_spout] = from_forced_sequence(app)

global forced_left_count  forced_right_count; 


if forced_left_count > 0
    next_spout = 0;
    forced_left_count = forced_left_count - 1;
    if forced_left_count == 0
       forced_right_count = app.number_of_rights.Value;
    end
else
    next_spout = 1;
    forced_right_count = forced_right_count - 1;
    if forced_right_count == 0
       forced_left_count = app.number_of_lefts.Value;
    end
end
