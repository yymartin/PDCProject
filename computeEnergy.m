function energy = computeEnergy(signal, fs, rangeFreq)
    if(nargin < 3)
        fs = 44100;
        t = 0:1/fs:1;
        signal = sin(1200*2*pi*t);
        rangeFreq = [1000 2000];
    end
    F = fft(signal);
    energy = bandpower(F, fs, rangeFreq);
    %pow = F.*conj(F);
    %energy = sum(pow);
end
