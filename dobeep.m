%% Function which creates a sound from an ascii string

function dobeep(ascii, sound_time, pause_time)
    toEmit = [];
    for e = ascii
        if (e == '0')
            toEmit = [toEmit do0(sound_time) zeros(1,pause_time*44100)];
        end

        if (e == '1')
            toEmit = [toEmit do1(sound_time) zeros(1,pause_time*44100)];
        end
    end

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

