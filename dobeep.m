%% Function which creates a sound from an ascii string
function dobeep(ascii, sound_time, pause_time)
    if(nargin < 3)
        ascii = '11111000001111100000';
        sound_time = 0.1;
        pause_time = 0.2;
    end
    
    M = generate_dictionary();
    
    toEmit = [];
    for e = 1:4:length(ascii)
       % Add to the sound the sinus and zeros corresponding to silence
       toEmit = [toEmit doSinWithFrequencies(sound_time,M(ascii(e:e+3))) zeros(1,pause_time*44100)];
    end
    %audiowrite('sound.wav',toEmit,44100);
    sound(toEmit,44100,16);
end

%% Function which generate a sin given a frequency and a duration
function a = doSinWithFrequencies(sound_time,freq1)
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:sound_time;
    a=amp*sin(2*pi*freq1*values);
end

%% Function which generate the emitter dictionary
function M = generate_dictionary()
    keys = {}; 
    for i = 0:15
        keys = [keys dec2bin(i,4)];
    end

    value = [];
    for i = 1:16
        value = [value 1010+i*60];
    end

    M = containers.Map(keys,value);
end

