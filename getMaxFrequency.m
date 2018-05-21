%% Function which return the max frequency of the signal
function max_freq = getMaxFrequency(signal)
    Fs = 44100;
    ydft = fft(signal);
    freq = 0:Fs/length(ydft):Fs/2;
    [~,idx] = max(abs(ydft));
    max_freq = freq(idx);
end