function         next_trial = verify_next_trial_type(next_trial)

global previous_trial number_of_consecutive_alternating_trials number_of_consecutive_identical_trials;

% fprintf(' =========== before %d %d \n',number_of_consecutive_alternating_trials,number_of_consecutive_identical_trials);


% if app.override.Value == 0
    if strcmp(next_trial,previous_trial)
        number_of_consecutive_alternating_trials  =  0;    
        number_of_consecutive_identical_trials = number_of_consecutive_identical_trials  + 1;
        if number_of_consecutive_identical_trials >2
            number_of_consecutive_identical_trials  =  0;
            
%             disp('flip----------ident-------------');
%             next_trial = xor(next_trial,1);
            if strcmp(next_trial,'go')
                next_trial = 'nogo';
            else
                next_trial = 'go';
            end
        end
    else
        number_of_consecutive_identical_trials  =  0;
        number_of_consecutive_alternating_trials = number_of_consecutive_alternating_trials + 1;
        if number_of_consecutive_alternating_trials >= 4
            number_of_consecutive_alternating_trials  =  0;
            number_of_consecutive_identical_trials = number_of_consecutive_identical_trials  + 1;
%             disp('flip----------alt-------------');
%             next_trial = xor(next_trial,1);
            if strcmp(next_trial,'go')
                next_trial = 'nogo';
            else
                next_trial = 'go';
            end
        end
    end
% fprintf('=========== after   %d %d \n',number_of_consecutive_alternating_trials,number_of_consecutive_identical_trials);

% end 
