%% Test asciiToText
ascii = textToSpeechWithNumber('text.txt');
expected = "Hello, I am a test file";
assert(asciiToText(ascii) == expected);

%% Test getMaxFrequency()
% Test with perfect sound
for freq = 1010:60:1970 
    signal = doSinWithFrequency(0.1,freq);
    max_freq = getMaxFrequency(signal);
    assert(abs(max_freq-freq) < 1);
end

% Test with silence before and after
for freq = 1010:60:1970 
    for i = 0.1:0.1:1
        signal = [zeros(1,round(i*44100)) doSinWithFrequency(0.1,freq) zeros(1,round(i*44100))];
        max_freq = getMaxFrequency(signal);
        assert(abs(max_freq-freq) < 3)
    end
end

% Test with noise before and after
for freq = 1010:60:1970 
    signal = [whiteNoise(1,1000,0.5) doSinWithFrequency(0.1,freq) whiteNoise(1,1000,0.5)];
    plot(signal);
    max_freq = getMaxFrequency(signal);
    assert(abs(max_freq-freq) < 30,strcat(num2str(max_freq),',' ,num2str(freq)))
end

% Test with noise during transmission
for freq = 1010:60:1970 
    signal = normalNoise(1,1000,0.1)+doSinWithFrequency(0.1,freq);
    max_freq = getMaxFrequency(signal);
    assert(abs(max_freq-freq) < 10,strcat(num2str(max_freq),',' ,num2str(freq)))
end

%Test with noise before, after and during transmission
for freq = 1010:60:1970 
    signal = [normalNoise(1,1000,0.1) normalNoise(1,1000,0.1)+doSinWithFrequency(0.1,freq) normalNoise(1,1000,0.1)];
    max_freq = getMaxFrequency(signal);
    assert(abs(max_freq-freq) < 10,strcat(num2str(max_freq),',' ,num2str(freq)))
end


%Test if incomplete sound
for freq = 1010:60:1970 
    signal = doSinWithFrequency(0.1,freq);
    % signal = signal(1:2205); Fail if number of samples not multiple of
    % 4410
    max_freq = getMaxFrequency(signal);
    assert(abs(max_freq-freq) < 10,strcat(num2str(max_freq),',' ,num2str(freq)))
end

%% Test keepBinary
for freq = 1010:60:1070
    signal = [normalNoise(1,1000,0.2) doSinWithFrequency(0.1,freq) normalNoise(1,1000,0.1)];
    signal = keepBinary(signal, 0.5);
    max_freq = getMaxFrequency(signal);
    assert(abs(max_freq-freq) < 10);
    assert(mod(length(signal),4410) == 0);
end

%% Test synchronise
barker = [doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750)];
signal = [whiteNoise(100,200,0.5) barker doSinWithFrequency(0.1,1230) doSinWithFrequency(0.1, 1970) doSinWithFrequency(0.1,1500) doSinWithFrequency(0.1,1250) barker whiteNoise(100,200,0.5)];

subplot(2,1,1); plot(signal);
subplot(2,1,2); plot(synchronise(signal,barker));

function y = normalNoise(minband, maxband, Time)
    Fs = 44100;
    var = 0.01;
    t = 0:1/Fs:Time;
    x = randn(size(t))*sqrt(var);
    y = bandstop(x,[minband maxband],Fs);
end


