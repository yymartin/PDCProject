%% Function which creates a sound from an ascii string
function dobeep(ascii, sound_time, pause_time)
    if(nargin < 3)
        ascii = '11111000001111100000';
        sound_time = 0.1;
        pause_time = 0.2;
    end
    
    M1000 = generate_dictionary(1020);
    M2000 = generate_dictionary(2020);
    
    barker = [doSin() doSin() doSin() doCos() doCos() doSin() doCos()];
    barker2 = [doSin2() doSin2() doSin2() doCos2() doCos2() doSin2() doCos2()];
    toEmit = [];
    for e = 1:4:length(ascii)
       % Add to the sound the sinus and zeros corresponding to silence
       s = doSinWithFrequency(sound_time,M1000(ascii(e:e+3)))+doSinWithFrequency(sound_time,M2000(ascii(e:e+3)));
       toEmit = [toEmit s zeros(1,pause_time*44100)];
    end

    toEmit = [barker zeros(1,pause_time*44100) toEmit barker2];       
    sound(toEmit,44100,16);
end

%% Function which generate the emitter dictionary
function M = generate_dictionary(start_value)
    keys = {}; 
    for i = 0:15
        keys = [keys dec2bin(i,4)];
    end

    value = [];
    for i = 0:15
        value = [value start_value+i*60];
    end

    M = containers.Map(keys,value);
end

%%
function a = doSin()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin(2*pi*1250*values) + amp*sin(2*pi*2250*values);
end

function a = doCos()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin((2*pi*1250*values)+pi) + amp*sin((2*pi*2250*values)+pi);
end

function a = doSin2()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin(2*pi*1750*values) + amp*sin(2*pi*2750*values);
end

function a = doCos2()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin((2*pi*1750*values)+pi) + amp*sin((2*pi*2750*values)+pi);
end

