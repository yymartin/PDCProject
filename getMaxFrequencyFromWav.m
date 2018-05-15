function result = getMaxFrequencyFromWav(filename)
    [y,Fs] = audioread(filename);
    
    ydft = fft(y,Fs);
    freq = 0:fs/length(x):Fs/2;
    ydft = ydft(1:length(x)/2+1);
    
    [~,idx] = max(abs(ydft));
    result = freq(idx); 
end