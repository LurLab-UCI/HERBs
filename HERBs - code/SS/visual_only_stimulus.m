function     visual_only_stimulus(app,lrflag,page)
global arduino run;
global counter;

rand_table = [2 3 5 6];

if app.combo.Value

        rand_idx = 1;
        randptr = randperm(4);
        
        for i = 1:app.number_of_presentations.Value
                counter = i;
                app.p_count.Text = num2str(counter);
            
            page = rand_table(randptr(rand_idx));
            rand_idx = rand_idx + 1;
            if rand_idx > 4
                rand_idx = 1;
                randptr = randperm(4);
            end
           
            write(arduino,'-',"uint8"); % 
            on_time = round(1000*0.5/app.stimulation_frequency_visual.Value);
            nbs = round(app.stimulus_duration_visual.Value*app.stimulation_frequency_visual.Value/1000);
            btl = mod(on_time,256); 
            bth = floor(on_time/256);
            vth = 0; vtl = 0;
            write(arduino,[btl bth vtl vth nbs lrflag page],"uint8");
            if app.alternating.Value
                   lrflag = bitxor(lrflag,3);
            end
            if run == 0 
                break;
            end
            
            pause(app.Interval_min.Value + rand*(app.Interval_max.Value - app.Interval_min.Value));
        end
    
  
elseif app.single.Value || app.double.Value
%            moving bars

        if app.alternating.Value()
              lr_table = randperm(app.number_of_presentations.Value());
              %if the first value between 1-5: L
              if lr_table(1) > (app.number_of_presentations.Value()/2)
                  lr_assign = (-1).^(0:app.number_of_presentations.Value());
              else
                  lr_assign = (-1).^(1:app.number_of_presentations.Value()+1);
              end
                  
        end 
        
        for i = 1:app.number_of_presentations.Value
            counter = i;
            app.p_count.Text = num2str(counter);
          temp = randperm(4);
          if app.double.Value
              tempadd = 4; % double bars
          else
              tempadd = 0; % single bars
          end
          
          if app.alternating.Value()
             if lr_assign(i)>0
                 lrflag = 1;
             else
                 lrflag = 2;
             end

          end
          
          for j = 1:4
              fprintf('%4.3f sequence %d\n',toc,temp(j));
              write(arduino,[ '(' lrflag (tempadd+temp(j))],"uint8");
              pause(app.Interval_min.Value + rand*(app.Interval_max.Value - app.Interval_min.Value));
              if run == 0 
                  break;
              end
          end
          if run == 0
              break;
          end
        end
%         clear page 6
         write(arduino,'@',"uint8");
        return;

else  % small or full panel     

    for i = 1:app.number_of_presentations.Value

        counter = i;
        app.p_count.Text = num2str(counter);
        
        write(arduino,'-',"uint8"); % 
        on_time = round(1000*0.5/app.stimulation_frequency_visual.Value);
        nbs = round(app.stimulus_duration_visual.Value*app.stimulation_frequency_visual.Value/1000);
        btl = mod(on_time,256); 
        bth = floor(on_time/256);
        vth = 0; vtl = 0;
        write(arduino,[btl bth vtl vth nbs lrflag,page],"uint8");
        if app.alternating.Value
               lrflag = bitxor(lrflag,3);
        end
        if run == 0 
            break;
        end
        pause(app.Interval_min.Value + rand*(app.Interval_max.Value - app.Interval_min.Value));
    end
end
