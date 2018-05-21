function y = whiteNoise(minband, maxband, Time)
    Fs = 44100;
    var = 10;
    t = 0:1/Fs:Time;
    x = randn(size(t))*sqrt(var);
    y = bandstop(x,[minband maxband],Fs);
end