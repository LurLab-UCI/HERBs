 function [next_spout] = get_next_rates(app) 
 %  this function  for rate disc only
global randbuf randptr;
global rate single_panel_rate;
global training_rate_selected;
global difficulty_selected;
global rate_table number_of_difficulty_levels;
global randbuf_seed;

% training_rate_selected = 0;
% nrates = str2double(app.mixed_rates_number_of_steps.Value) ;
nrates = 4;

if app.two_rates_only.Value
    rr =rand;
    if rr  >  (app.per_R.Value)/100
       next_spout = 0;    % left
    else
       next_spout = 1;    % right
    end
%        look at consecutice spouts number and flip if needed
        next_spout = verify_next_spout(app,next_spout);

        training_rate_selected = 1;
        difficulty_selected = 1;
        [rate.l rate.r,single_panel_rate] = pick_rates(app,difficulty_selected,next_spout);
    
else   % ---------------------------------------------------------------
 %     mixed rates  case
 
      if  rand < app.percentage_of_training_trials.Value/100
              %       training trial case
            rr =rand;
            if rr  >  (app.per_R.Value)/100
               next_spout = 0;    % left
            else
               next_spout = 1;    % right
            end
%        look at consecutice spouts number and flip if needed
               next_spout = verify_next_spout(app,next_spout);
              training_rate_selected = 1;
              difficulty_selected = 1;
%                difficulty_selected =  str2double(app.mixed_rates_number_of_steps.Value)  ;
              [rate.l rate.r,single_panel_rate] = pick_rates(app,difficulty_selected,next_spout);
           
      else    % non training case
                training_rate_selected = 0;
                difficulty_selected  =randbuf(randptr);
                if difficulty_selected > nrates
                     difficulty_selected = difficulty_selected - nrates;
                    next_spout = 1;
                else
                    next_spout = 0;
                end
%                update pointers for future use
                  randptr = 1 + mod(randptr,length(randbuf));
                  if randptr == 1
%                          randbuf = randperm(length(randbuf));
                        randbuf = randbuf_seed(randperm(length(randbuf_seed)));
                  end
      end
      [rate.l rate.r,single_panel_rate] = pick_rates(app,difficulty_selected,next_spout);
end

% fprintf('%4.3f  blink rates  l = %2.1f    r = %2.1f   \n',toc,rate.l,rate.r);