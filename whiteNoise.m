function whiteNoise()

    Left = 1000;
    Right = 2000;
    Time = 1;
    Fs = 44100;
    var = 10;
    t = 0:1/Fs:Time;
    x = randn(size(t))*sqrt(var);
    y = bandstop(x,[Left Right],Fs);
    %%en = computeEnergy(y, Fs, [1000 2000]);
end