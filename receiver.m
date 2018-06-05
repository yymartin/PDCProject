speechToWav();
pause(5);
signal = audioread('sound.wav');
signal = signal(:,1);
disp(length(signal));

Fs = 44100;
test_sample = signal(1:44100);
energy_1000_2000 = bandpower(test_sample,Fs,[1000 2000]);
energy_2000_3000 = bandpower(test_sample,Fs,[2000 3000]);
disp(energy_1000_2000);
disp(energy_2000_3000);
start_value = 0;
if energy_1000_2000 < energy_2000_3000
    signal = bandpass(signal,[1110 1890], Fs);
    start_value = 1020;
else
    signal = bandpass(signal,[2110 2890], Fs);
    start_value = 2020;
end

M = generate_dictionary(start_value);
barker = [doSin() doSin() doSin() doCos() doCos() doSin() doCos()];
barker2 = [doSin2() doSin2() doSin2() doCos2() doCos2() doSin2() doCos2()];
subplot(2,1,1);plot(signal);
signal_synchronised = synchronise(signal, barker, barker2);

subplot(2,1,2);plot(signal_synchronised);

getBinaryFromSound(signal_synchronised,0.1, M, start_value);


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
    a=amp*sin(2*pi*1250*values + pi) + amp*sin(2*pi*2250*values + pi);
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
    a=amp*sin((2*pi*1750*values) + pi) + amp*sin((2*pi*2750*values)+pi);
end

%% Function which generates the receiver dictionary
function M = generate_dictionary(start_value)
    keys = {}; 
    for i = 0:15
        keys = [keys dec2bin(i,4)];
    end

    value = [];
    for i = 0:15
        value = [value start_value+i*60];
    end

    M = containers.Map(value,keys);
end



