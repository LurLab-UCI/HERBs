function ssd = get_stim_start_delay(app)
global delay_rand_buffer delay_randptr;
global previous_ssd;
global wrong_spout;

if app.Stable_Delays.Value
% stable delays read from gui    
    ssd = app.stim_start_delay.Value;
elseif ~app.Variable_SSD.Value
%     not variable ssd read from gui
    ssd = app.stim_start_delay_fixed.Value;
else
%     variable sst 
% if wrong  spout  and retrain mode then use old value
        if app.retrial_mode.Value && ~isempty(previous_ssd) && wrong_spout
            disp('previous ssd used');
            ssd = previous_ssd;
            wrong_spout = 0;
        else   
              % read delay from table
           ssd = delay_rand_buffer(delay_randptr);
            delay_randptr = 1 + mod(delay_randptr,numel(delay_rand_buffer));
            if delay_randptr == 1
                delay_rand_buffer = delay_rand_buffer(randperm(numel(delay_rand_buffer)));
            end
        end
        fprintf('%4.3f SSD_delay = %4.3f \n',toc,ssd);
end
previous_ssd = ssd;
