%% Function which creates a sound from an ascii string
function dobeep(ascii, sound_time, pause_time)
    if(nargin < 3)
        ascii = '11111000001111100000';
        sound_time = 0.1;
        pause_time = 0.2;
    end
    
    M1000 = generate_dictionary(1010);
    M2000 = generate_dictionary(2010);
    
    toEmit = [];
    for e = 1:4:length(ascii)
       % Add to the sound the sinus and zeros corresponding to silence
       s = doSinWithFrequency(sound_time,M1000(ascii(e:e+3)))+doSinWithFrequency(sound_time,M2000(ascii(e:e+3)))+whiteNoise(2000,3000,sound_time);
       toEmit = [toEmit s zeros(1,pause_time*44100)];
    end
    audiowrite('sound.wav',toEmit,44100);
    %sound(toEmit,44100,16);
end

%% Function which generate the emitter dictionary
function M = generate_dictionary(start_value)
    keys = {}; 
    for i = 0:15
        keys = [keys dec2bin(i,4)];
    end

    value = [];
    for i = 1:16
        value = [value start_value+i*60];
    end

    M = containers.Map(keys,value);
end

