function y = whiteNoise(minband, maxband, Time)
    if nargin < 3
        minband = 1000;
        maxband = 2000;
        Time = 10;
    end
    fs = 44100;
    var = 10;
    t = 0:1/fs:Time;
    x = randn(size(t))*sqrt(var);
    y = bandstop(x,[minband maxband], fs);
end