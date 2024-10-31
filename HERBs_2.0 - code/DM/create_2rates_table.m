 function  create_2rates_table(app) 

 global rate_pair;
return;
min_rate = app.low_rate.Value;
max_rate = app.high_rate.Value;
max_ratio = app.max_ratio.Value;
  

% app.ActiveRatesTextArea.Text = 'test';

if 0
k = min_rate;
l = round(k*max_ratio);
rate_pair = zeros(2,1)';
rate_pair(:,:) = [k l] ;

    while l<=max_rate
        k = k + 1;
        l = round(k*max_ratio);
        rate_pair = [rate_pair ;  [k l]];
    end
%     ignore the last
    rate_pair =  rate_pair(1:end-1,:);
aa=1;
end