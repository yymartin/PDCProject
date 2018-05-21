%% Function which creates a sound from an ascii string

function dobeep(ascii, sound_time, pause_time)
    if(nargin < 3)
        ascii = '11111000001111100000';
        sound_time = 0.1;
        pause_time = 0.2;
    end
    
    keys = {}; 
    for i = 0:31
        keys = [keys dec2bin(i,5)];
    end

    value = [];
    for i = 1:32
        value = [value 1010+i*30];
    end

    M = containers.Map(keys,value);
    
    toEmit = [];
    for e = 1:5:length(ascii)
       toEmit = [toEmit doSinWithFrequencies(sound_time,M(ascii(e:e+4))) zeros(1,pause_time*44100)];
    end
    %audiowrite('sound.wav',toEmit,44100);
    sound(toEmit,44100,16);
end

%% Function with a beep representing 1 (frequency 1800)
function a = do1(sound_time)
amp=1; 
fs=44100;  % sampling frequency
freq=1800;
values=0:1/fs:sound_time;
a=amp*sin(2*pi* freq*values);
end

%% Function with a beep representing 0 (frequency 1200)

function a = do0(sound_time)
amp=1; 
fs=44100;  % sampling frequency
freq=1200;
values=0:1/fs:sound_time;
a=amp*sin(2*pi* freq*values);
end

function a = doSinWithFrequencies(sound_time,freq1)
amp=1; 
fs=44100;  % sampling frequency
values=0:1/fs:sound_time;

a=amp*sin(2*pi* freq1*values);
end

