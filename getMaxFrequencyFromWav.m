function result = getMaxFrequencyFromWav(filename, minband, maxband, desired)
    [y,Fs] = audioread(filename);
    
    ydft = fft(y,Fs);
    freq = 0:fs/length(ydft):Fs/2;
    ydft = ydft(minband:maxband);
    
    [~,idx] = max(abs(ydft));
    max_freq = freq(idx);
    if max_freq == desired
        result = true;
    else 
        result = false;
    end
end