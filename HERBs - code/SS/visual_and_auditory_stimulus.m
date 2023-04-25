function   visual_and_auditory_stimulus(app,lrflag,page)
global arduino run sdata;   
global counter;

rand_table = [2 3 5 6];
rand_idx = 1;
randptr = randperm(4);

tf = round(str2double(app.TonePitchkHzDropDown.Value));

%noise/tone
if app.white_noise.Value
        mbank = 2;
        if lrflag.a == 3
            dac_val = 0;
        else
            dac_val = 20+10*lrflag.a; 
        end
        
else
        mbank = 1;
        if lrflag.a == 3
            dac_val = 0;
        else
            dac_val = 10*lrflag.a ;
        end
end

write(arduino,['=' tf],"uint8");  % skip

if app.visual_first.Value
     delay_visual = 0;
     delay_auditory =  round(app.delay_between.Value);
else
     delay_visual =  round(app.delay_between.Value);
     delay_auditory = 0;
end
     

for i = 1:app.number_of_presentations.Value
    counter = i;
    app.p_count.Text = num2str(counter);
    
    fprintf('sequence %d \n',i);
    
    if app.combo.Value
          page = rand_table(randptr(rand_idx));
          rand_idx = rand_idx + 1;
          if rand_idx > 4
                rand_idx = 1;
                randptr = randperm(4);
          end
    end
    
    

%     tone pars
%     write(arduino,'l'); % 
    on_time = round(1000*0.5/app.stimulation_frequency_audio.Value);
    nbs = round(app.stimulus_duration_audio.Value*app.stimulation_frequency_audio.Value/1000);
    btl = mod(on_time,256); 
    bth = floor(on_time/256);
    atl = mod(delay_auditory,256); 
    ath = floor(delay_auditory/256);
    sdata = [];
    write(arduino,['l' btl bth atl ath nbs lrflag.a mbank dac_val],"uint8");
    
%     pause(0.135);
%     %     visual pars
%       on_time = round(0.5*app.stimulus_duration_visual.Value*(1/app.stimulation_frequency_visual.Value));
     on_time = round(1000*0.5/app.stimulation_frequency_visual.Value);
     nbs = round(app.stimulus_duration_visual.Value*app.stimulation_frequency_visual.Value/1000);
     btl = mod(on_time,256); 
     bth = floor(on_time/256);
     vtl = mod(delay_visual,256); 
     vth = floor(delay_visual/256);
%      write(arduino,'-'); % 
      wait_for_ack()
                 
         write(arduino,['-' btl bth vtl vth nbs lrflag.v page],"uint8");
         
       if app.alternating.Value
            lrflag.a = bitxor(lrflag.a,3);
            lrflag.v = bitxor(lrflag.v,3);
       end
    

    if run == 0 
        break;
    end
  pause(app.Interval_min.Value + rand*(app.Interval_max.Value - app.Interval_min.Value));
end
