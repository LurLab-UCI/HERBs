function to_delay_period(app)

global state statetimer;
global trial_type next_trial_type;
global randbuf randptr randbuf_seed;
global arduino dacvoltage;


fprintf('%4.3f stim_start_delay expired    \n',toc);

% decide between catch trial vs go or nogo trial
stop(statetimer);

switch trial_type
    case 'go'
                %     go trial
                        start_go_stimulus(app);
                        % next state is delay period
                        dl =  randbuf.g(randptr.g);
                        statetimer.StartDelay =  dl;
                        %    update pointers for future use
                        randptr.g = 1 + mod(randptr.g,length(randbuf.g));
                        if randptr.g == 1
                               randbuf.g = randbuf_seed.g(randperm(length(randbuf_seed.g)));
                        end

    case 'nogo'
               %     nogo trial
                        start_nogo_stimulus(app);
                        % next state is delay period
                        dl =  randbuf.n(randptr.n);
                        statetimer.StartDelay =  dl;
                        %    update pointers for future use
                        randptr.n = 1 + mod(randptr.n,length(randbuf.n));
                        if randptr.n == 1
                               randbuf.n = randbuf_seed.n(randperm(length(randbuf_seed.n)));
                        end

    case 'catch'
                        % next state is delay period
                        dl =  randbuf.c(randptr.c);
                        statetimer.StartDelay =  dl;
                        %    update pointers for future use
                        randptr.c = 1 + mod(randptr.c,length(randbuf.c));
                        if randptr.c == 1
                               randbuf.c = randbuf_seed.c(randperm(length(randbuf_seed.c)));
                        end
                        
                         tm = app.audio_stimulus_duration_go.Value/1000;
                        
                        % if a catch trial do not start stimulus
    %                 if go stimulus set to visual use quad dac
    %                     otherwise use single dac
                        if app.visual_active_go.Value
        %                 write  to  quad dac ch C
                            l =  mod(100*dacvoltage.visual.catch,256); 
                            h =  floor(100*dacvoltage.visual.catch/256); 
                            write(arduino,['c' 2  l h],"uint8");
                        else
        %                 write 10 to single dac
                              write(arduino,['g' 30],"uint8");
                        end

                        dac_timer = timer;
                        dac_timer.ExecutionMode ='singleshot';
                        dac_timer.TimerFcn = {@dac_to_zero,app};
                        dac_timer.StartDelay  = tm;
                        start(dac_timer);
end

start(statetimer);
state = 'delay_period';
app.statetext.Text = state; 
fprintf('%4.3f starting delay period    %4.3f\n',toc,dl);
