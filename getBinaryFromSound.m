%% Function which recovers a wav file into the corresponding binary
function getBinaryFromSound(filename,sound_time)
    if(nargin < 2)
        filename = 'sound.wav';
        sound_time = 0.1;
    end
    
    M = generate_dictionary();
    
    % Read audio file
    [y,Fs] = audioread(filename);
    % Remove before and after silence
    %y = keepBinary(y,-1); 
    % Create an array to iterate over the sound
    % Typically if sound_time = 0.1, array = [0 0.1 0.2 ...] 
    iter = 1:Fs*sound_time:length(y)-(Fs*sound_time);
    text = '';
    for i = iter
        % Get sound of length sound_time 
        temp = y(i:i+(Fs*sound_time));
        
        % Check if temp is silence, retrieve closest frequency using the
        % dictionary and concatenate the corresponding text
        frequency = detectMaxFreq(temp,Fs);
        closest = find_closest(frequency);
        text = strcat(text,M(closest));
        
    end
    disp('Text found: ');
    disp(text);
    asciiToText(text);
end


%% Function which return the maximum frequency of a signal
function max_freq = detectMaxFreq(signal,Fs)
    ydft = fft(signal);
    freq = 0:Fs/length(ydft):Fs/2;    
    [~,idx] = max(abs(ydft));
    max_freq = freq(idx);
end



%% Function which determines if a signal is a beep or a silence regarding a given threshold
function silence = is_silence(signal, threshold)
    count_silence = 0;
    count_noise = 0;
    for i = 1:length(signal)
        if(abs(signal(i)) > threshold)
            count_noise = count_noise + 1;
        else
            count_silence = count_silence + 1;
        end
    end
    silence = count_silence > count_noise;
end

%% Function which find the closest frequency
function max_freq = find_closest(freq)
    value = [];
    for i = 1:16
        value = [value 1010+i*60];
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
function M = generate_dictionary()
    keys = {}; 
    for i = 0:15
        keys = [keys dec2bin(i,4)];
    end

    value = [];
    for i = 1:16
        value = [value 1010+i*60];
    end

    M = containers.Map(value,keys);
end