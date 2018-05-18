function result = getMaxFrequencyFromWav(filename, minband, maxband, desired)
    [y,Fs] = audioread(filename);
    ydft = fft(y);
    
    P2 = abs(ydft/Fs);
    P1 = P2(1:Fs/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    
    plot(P1);
    freq = 0:Fs/length(ydft):Fs/2;
    ydft = ydft(minband:maxband);
    [~,idx] = max(abs(ydft));
    max_freq = freq(idx);
    if max_freq == desired
        result = true;
    else 
        result = false;
    end
end