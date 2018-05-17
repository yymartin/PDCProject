function getBinaryFromSound(filename,sound_time)
    if(nargin < 2)
        filename = 'sound.wav';
        sound_time = 0.1;
    end
    [y,Fs] = audioread(filename);

    iter = 1:Fs*sound_time:length(y)-(Fs*sound_time);
    text = '';
    for i = iter
        temp = y(i:i+(Fs*sound_time));
        frequency = detectMaxFreq(temp,Fs);
            if (frequency ~= 0) 
                if (abs(1800-frequency) < abs(frequency-1200))
                    text = strcat(text,'1');
                else 
                    text = strcat(text,'0');
                end
            end
    end
    disp('Text found: ');
    disp(text);
end

function max_freq = detectMaxFreq(signal,Fs)
    ydft = fft(signal);
    freq = 0:Fs/length(ydft):Fs/2;    
    [~,idx] = max(abs(ydft));
    max_freq = freq(idx);
end

function silence = is_silence(signal, threshold)
    %%TODO
end