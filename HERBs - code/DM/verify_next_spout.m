function         next_spout = verify_next_spout(app,next_spout)

global previous_spout number_of_consecutive_alternating_spouts number_of_consecutive_identical_spouts;

if app.override.Value == 0
    if next_spout == previous_spout
        number_of_consecutive_alternating_spouts  =  0;    
        number_of_consecutive_identical_spouts = number_of_consecutive_identical_spouts  + 1;
        if number_of_consecutive_identical_spouts >= 2
            number_of_consecutive_identical_spouts  =  0;
            next_spout = xor(next_spout,1);
        end
    else
        number_of_consecutive_identical_spouts  =  0;
        number_of_consecutive_alternating_spouts = number_of_consecutive_alternating_spouts + 1;
        if number_of_consecutive_alternating_spouts >= 4
            number_of_consecutive_alternating_spouts  =  0;
            number_of_consecutive_identical_spouts = number_of_consecutive_identical_spouts  + 1;
            next_spout = xor(next_spout,1);
        end
    end
end 
