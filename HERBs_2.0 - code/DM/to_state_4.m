function to_state_4(app)
global state rtimer;
global reward_spout   % GL edit 9.3.19
global correct_L correct_R bias_ptr;
global correct_count_L correct_count_R;
global from_retrial

state  = '4';
app.statenumber.Text = state;
stop(rtimer);
rtimer.StartDelay = app.wait24.Value;   % GL edit 190903: wait for GUI set time
start(rtimer);

% correct side
if reward_spout == 0  % left
    correct_L(bias_ptr) =    1;
    if ~from_retrial
        correct_count_L = correct_count_L + 1;
        app.LCorrect.Text = num2str(correct_count_L);
    end
else
    correct_R(bias_ptr) =    1;
    if ~from_retrial  
        correct_count_R = correct_count_R + 1;
        app.RCorrect.Text = num2str(correct_count_R);
    end
end

from_retrial = 0;
bias_ptr =  1 + bias_ptr;

fprintf('%4.3f to_state_4\n',toc);
