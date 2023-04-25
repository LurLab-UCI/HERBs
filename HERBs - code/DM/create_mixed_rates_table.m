function create_mixed_rates_table(app)

global randbuf randptr;
global randbuf_seed;
if  0 %~app.single_panel.Value
    n = str2double(app.mixed_rates_number_of_steps.Value)  -1 ;
    randbuf = randperm(n);
else
    %  single panel modedifficulty_selected
%     m = str2double(app.mixed_rates_number_of_steps.Value) ;
    m = 4;
    randbuf_seed = [2:m   (2*m):-1:(m+2) ];
    randbuf = randbuf_seed(randperm(length(randbuf_seed)));
end
    
randptr = 1;

%   n = n(randperm(length(n)))