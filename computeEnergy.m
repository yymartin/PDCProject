function energy = computeEnergy(signal)
    F = fft(signal); 
    pow = F.*conj(F);
    energy = sum(pow);
end