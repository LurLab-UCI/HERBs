function tcsa = get_time_center_spout_available(app)
global delay_rand_buffer delay_randptr;
global previous_tcsa;
global wrong_spout;


if app.Stable_Delays.Value
% stable delays read from gui    
    tcsa = app.time_center_spout_available.Value;
elseif ~app.Variable_TCSA.Value
%     not variable tcsa read from gui
    tcsa = app.time_center_spout_available_fixed.Value;
else
%     variable tcsa 
% if wrong  spout  and retrain mode then use old value
        if app.retrial_mode.Value && ~isempty(previous_tcsa) && wrong_spout
            disp('previous tcsa used');
            tcsa = previous_tcsa;
            wrong_spout = 0;
        else   
              % read delay from table
           tcsa = delay_rand_buffer(delay_randptr);
            delay_randptr = 1 + mod(delay_randptr,numel(delay_rand_buffer));
            if delay_randptr == 1
                delay_rand_buffer = delay_rand_buffer(randperm(numel(delay_rand_buffer)));
            end
        end
        fprintf('%4.3f tcsa = %4.3f \n',toc,tcsa);
end
previous_tcsa = tcsa;
