function clear_licks_gonogo(~,~)
global  sdata lick_counter licktimer;

sdata = [];
lick_counter = 0;
stop(licktimer);
start(licktimer);


