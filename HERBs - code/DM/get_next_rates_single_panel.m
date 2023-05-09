 function [next_spout] = get_next_rates_single_panel(app) 
 %  this function  for rate disc only
global randbuf randptr;
global rate;
global training_rate_selected;
global difficulty_selected;
global  single_panel_rate;
global rate_table number_of_difficulty_levels;
% training_rate_selected = 0;
rr =rand;
if rr  >  (app.per_R.Value)/100
   next_spout = 0;    % left
% fprintf('---------------left---------\n');
else
   next_spout = 1;    % right
% fprintf('---------------right---------\n');
end

%        look at consecutice spouts number and flip if needed
next_spout = verify_next_spout(app,next_spout);

if app.two_rates_only.Value
    difficulty_selected = 0;
    training_rate_selected = 1;
else   % ---------------------------------------------------------------
 %     mixed rates  case
 
      if  rand < app.percentage_of_training_trials.Value/100
              %       training trial case
               training_rate_selected = 1;
               difficulty_selected = 0;
           
      else    % non training case
%           use table
                training_rate_selected = 0;
                single_panel_rate  = rate_table(randbuf(randptr));
                difficulty_selected = randbuf(randptr);
%                update pointers for future use
                  randptr = 1 + mod(randptr,length(randbuf));
                  if randptr == 1
                         randbuf = randperm(length(randbuf));
                  end
      end
end

% single_panel_rate

ctr = ceil(length(rate_table)/2);
lvl = number_of_difficulty_levels - difficulty_selected;  

if next_spout == 0  % left
   if app.higher_rate_correct.Value 
       single_panel_rate = rate_table(ctr-lvl);
   else
       single_panel_rate = rate_table(ctr+lvl);
   end
else  % right
   if app.higher_rate_correct.Value 
       single_panel_rate = rate_table(ctr+lvl);
   else
       single_panel_rate = rate_table(ctr-lvl);
   end
end



