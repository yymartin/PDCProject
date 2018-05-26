%% Function which creates a sound from an ascii string
function dobeep(ascii, sound_time, pause_time)
    if(nargin < 3)
        ascii = '11111000001111100000';
        sound_time = 0.1;
        pause_time = 0.2;
    end
    
    M1000 = generate_dictionary(1010);
    M2000 = generate_dictionary(2010);
    
    %barker = [doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750)];
    barker = [doSin() doSin() doSin() doCos() doCos() doSin() doCos()];
    barker2 = [doSin2() doSin2() doSin2() doCos2() doCos2() doSin2() doCos2()];
    toEmit = [];
    count = 1;
    for e = 1:4:length(ascii)
       count = count + 1;
       disp([count M2000(ascii(e:e+3))]);
       % Add to the sound the sinus and zeros corresponding to silence
       s = doSinWithFrequency(sound_time,M1000(ascii(e:e+3)))+doSinWithFrequency(sound_time,M2000(ascii(e:e+3)));
       toEmit = [toEmit s zeros(1,pause_time*44100)];
    end
    %% Only for testing on single computer
    toEmit = [barker toEmit barker2];
    %toEmit = awgn(toEmit,10);
    %audiowrite('sound.wav',toEmit,44100);
    
    
    sound(toEmit,44100,16);
end

%% Function which generate the emitter dictionary
function M = generate_dictionary(start_value)
    keys = {}; 
    for i = 0:15
        keys = [keys dec2bin(i,4)];
    end

    value = [];
    for i = 1:16
        value = [value start_value+i*48];
    end

    M = containers.Map(keys,value);
end

%%
function a = doSin()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin(2*pi*1850*values) + amp*sin(2*pi*2850*values);
end

function a = doCos()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin((2*pi*1850*values)+pi) + amp*sin((2*pi*2850*values)+pi);
end

function a = doSin2()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin(2*pi*1950*values) + amp*sin(2*pi*2950*values);
end

function a = doCos2()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin((2*pi*1950*values)+pi) + amp*sin((2*pi*2950*values)+pi);
end

