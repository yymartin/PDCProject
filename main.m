disp('Send text');
textToSpeechWithNumber('text.txt');
disp('Transmission');

pause(5);
signal = audioread('sound.wav');
signal = signal(:,1);

Fs = 44100;
test_sample = signal(1:4410);
energy_1000_2000 = bandpower(test_sample,Fs,[1000 2000]);
energy_2000_3000 = bandpower(test_sample,Fs,[2000 3000]);
disp(energy_1000_2000);
disp(energy_2000_3000);
start_value = 0;
if energy_1000_2000 < energy_2000_3000
    signal = bandpass(signal,[1000 2000], Fs);
    start_value = 1010;
else
    signal = bandpass(signal,[2000 3000], Fs);
    start_value = 2010;
end

M = generate_dictionary(start_value);
%barker = [doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750)];
barker = [doSin() doSin() doSin() doCos() doCos() doSin() doCos()];
figure;plot(signal);
signal_synchronised = synchronise(signal, barker);
figure;plot(signal_synchronised);
getBinaryFromSound(signal_synchronised,0.1, M, start_value);


%%
function a = doSin()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin(2*pi*1200*values) + amp*sin(2*pi*2200*values);
end

function a = doCos()
    amp=1; 
    fs=44100;  % sampling frequency
    values=0:1/fs:0.1;
    a=amp*sin((2*pi*1700*values)) + amp*sin((2*pi*2700*values));
end

%% Function which generates the receiver dictionary
function M = generate_dictionary(start_value)
    keys = {}; 
    for i = 0:15
        keys = [keys dec2bin(i,4)];
    end

    value = [];
    for i = 1:16
        value = [value start_value+i*60];
    end

    M = containers.Map(value,keys);
end



