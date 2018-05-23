%% Function which recovers a wav file into the corresponding binary
function getBinaryFromSound(signal,sound_time)
    if(nargin < 2)
        signal = doSinWithFrequency(1,1200);
        sound_time = 0.1;
    end
     
    Fs = 44100;
    test_sample = signal(1:4410);
    energy_1000_2000 = bandpower(test_sample,Fs,[1000 2000]);
    energy_2000_3000 = bandpower(test_sample,Fs,[2000 3000]);
    start_value = 0;
    if energy_1000_2000 < energy_2000_3000
        signal = bandstop(signal,[2000 3000], Fs);
        start_value = 1010;
    else
        signal = bandstop(signal,[1000 2000], Fs);
        start_value = 2010;
    end
    
    M = generate_dictionary(start_value);
    

    % Create an array to iterate over the sound
    % Typically if sound_time = 0.1, array = [0 0.1 0.2 ...] 
    iter = 1:Fs*sound_time:length(signal)-(Fs*sound_time);
    text = '';
    for i = iter
        % Get sound of length sound_time 
        temp = signal(i:i+(Fs*sound_time));
        
        % Check if temp is silence, retrieve closest frequency using the
        % dictionary and concatenate the corresponding text
        frequency = detectMaxFreq(temp,Fs);
        closest = find_closest(frequency,start_value);
        text = strcat(text,M(closest));
        
    end
    disp('Text found: ');
    asciiToText(text);
end


%% Function which return the maximum frequency of a signal
function max_freq = detectMaxFreq(signal,Fs)
    ydft = fft(signal);
    freq = 0:Fs/length(ydft):Fs/2;    
    [~,idx] = max(abs(ydft));
    max_freq = freq(idx);
end

%% Function which find the closest frequency
function max_freq = find_closest(freq, start_value)
    value = [];
    for i = 1:16
        value = [value start_value+i*60];
    end

    max_freq = 0;
    min_diff = 10000;
    for i = value
        diff = abs(freq-i);
        if (diff < min_diff)
            max_freq = i;
            min_diff = diff;
        end
    end
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