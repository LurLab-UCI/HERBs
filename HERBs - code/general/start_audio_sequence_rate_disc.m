function start_audio_sequence_rate_disc(app)
global arduino reward_spout;
global rate;
global  single_panel_rate;


write(arduino,'a',"uint8");
audio_volume = app.volume.Value;
write(arduino,audio_volume,"uint8");

% fprintf('audio volume = %d \n',audio_volume);

tf = round(str2double(app.TonePitchkHzDropDown.Value));

if app.white_noise.Value
     mbank = 2;
else
    mbank = 1;
end
write(arduino,['=' tf],"uint8");  % skip (for frequency)

if app.single_panel.Value == 0

    % get rates
    % left
    ncyc  = round(rate.l * app.stim_duration_rate_disc.Value);
    up_ms  = round(1000/rate.l/2);
    low_ms = up_ms;
    up_l=  mod(up_ms,256); 
    up_h =  floor(up_ms/256); 
    low_l =  mod(low_ms,256); 
    low_h =  floor(low_ms/256); 
    
    ncycles_l = mod(ncyc,256);
    ncycles_h = floor(ncyc/256);

    write(arduino,['m'  up_l up_h low_l low_h ncycles_l ncycles_h mbank 20 ],"uint8");

    % right
    ncyc  = round(rate.r * app.stim_duration_rate_disc.Value);
    up_ms  = round(1000/rate.r/2);
    low_ms = up_ms;
    up_l=  mod(up_ms,256); 
    up_h =  floor(up_ms/256); 
    low_l =  mod(low_ms,256); 
    low_h =  floor(low_ms/256); 
    
    ncycles_l = mod(ncyc,256);
    ncycles_h = floor(ncyc/256);
    
    write(arduino,['n'  up_l up_h low_l low_h ncycles_l ncycles_h mbank  20],"uint8");
    fprintf('%3.3f   stim rates   l = %2.1f   r = %2.1f\n',toc,rate.l ,rate.r);
else
%     single panel

%     if app.higher_rate_correct.Value
%             if reward_spout == 0 % left
%                 rte = app.low_rate.Value;
%             else
%                 rte = app.high_rate.Value;
%             end
%     else
%             if reward_spout == 0 % left
%                 rte = app.high_rate.Value;
%             else
%                 rte = app.low_rate.Value;
%             end
%     end
    
    rte =  single_panel_rate;

    ncyc  = round(rte * app.stim_duration_rate_disc.Value);
    up_ms  = round(1000/rte/2);
    low_ms = up_ms;
    up_l=  mod(up_ms,256); 
    up_h =  floor(up_ms/256); 
    low_l =  mod(low_ms,256); 
    low_h =  floor(low_ms/256); 
    
    ncycles_l = mod(ncyc,256);
    ncycles_h = floor(ncyc/256);

    write(arduino,['m'  up_l up_h low_l low_h ncycles_l ncycles_h mbank  20],"uint8");
    write(arduino,['n'  up_l up_h low_l low_h ncycles_l ncycles_h mbank  20],"uint8");
    fprintf('%3.3f   stim rate  = %2.1f \n',toc,rte);

end
