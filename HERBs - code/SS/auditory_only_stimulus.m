function   auditory_only_stimulus(app,lrflag)
global arduino run;   
global counter;

tf = round(str2double(app.TonePitchkHzDropDown.Value));

%noise/tone
if app.white_noise.Value
     mbank = 2;
        dac_val = 20+10*lrflag; 
else
      mbank = 1;
      dac_val = 10*lrflag ;
end

write(arduino,['=' tf],"uint8");  % skip
 delay = 0;  

for i = 1:app.number_of_presentations.Value
    counter = i;
    app.p_count.Text = num2str(counter);
    
    fprintf('sequence %d \n',i);
%      write(arduino,'l'); % 
    
    on_time = round(1000*0.5/app.stimulation_frequency_audio.Value);
    nbs = round(app.stimulus_duration_audio.Value*app.stimulation_frequency_audio.Value/1000);
    btl = mod(on_time,256); 
    bth = floor(on_time/256);
   atl = mod(delay,256); 
    ath = floor(delay/256);
    
    %simultaneous aud does not work.
    if lrflag == 3
        dac_val = 0;
    end
    
    write(arduino,[ 'l' btl bth atl ath nbs lrflag mbank dac_val],"uint8");

     if app.alternating.Value
         lrflag = bitxor(lrflag,3);
         
     end
    if run == 0 
        break;
    end
    wait_for_ack();
  pause(app.Interval_min.Value + rand*(app.Interval_max.Value - app.Interval_min.Value));
end
