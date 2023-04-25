function stop_all_stims()

global arduino;
write(arduino,[':' ],"uint8");  % stops all lights and audio
