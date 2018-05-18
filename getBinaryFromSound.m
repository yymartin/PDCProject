%% Function which recovers a wav file into the corresponding binary
function getBinaryFromSound(filename,sound_time)
    if(nargin < 2)
        filename = 'sound.wav';
        sound_time = 0.1;
    end
    [y,Fs] = audioread(filename);
    y = keepBinary(y,0.1); 
    iter = 1:Fs*sound_time:length(y)-(Fs*sound_time);
    text = '';
    for i = iter
        temp = y(i:i+(Fs*sound_time));
        frequency = detectMaxFreq(temp,Fs);
        disp(frequency);
            if (~is_silence(temp,0.1)) 
                if (abs(1800-frequency) < abs(frequency-1200))
                    text = strcat(text,'1');
                else 
                    text = strcat(text,'0');
                end
            end
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