%% Function which creates a sound from an ascii string

function dobeep(ascii)
    for e = ascii
        if (e == '0')
            do0()
            pause(0.5);
        end

        if (e == '1')
            do1()
            pause(0.5);
        end
        
    end

end

%% Function with a beep representing 1 (frequency 18000)
function do1()
amp=1; 
fs=44100;  % sampling frequency
duration=0.1;
freq=18000;
values=0:1/fs:duration;
a=amp*sin(2*pi* freq*values);
sound(a);
end

%% Function with a beep representing 0 (frequency 12000)

function do0()
amp=1; 
fs=44100;  % sampling frequency
duration=0.1;
freq=12000;
values=0:1/fs:duration;
a=amp*sin(2*pi* freq*values);
sound(a);
end