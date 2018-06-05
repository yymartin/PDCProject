%% Function which generate a sin given a frequency and a duration
function a = doSinWithFrequency(sound_time,freq1)
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:sound_time;
    a=amp*sin(2*pi*freq1*values);
end