%% Function which takes a signal and return the sound containing the text transmitted
function signal = synchronise(signal, barker, barker2)    
    [acor,lag] = xcorr(signal,barker);
    [~,I] = max(abs(acor));
    lagDiff = lag(I);
    
    [acor2,lag2] = xcorr(signal,barker2);
    [~,I2] = max(abs(acor2));
    lagDiff2 = lag2(I2);
    
    display(lagDiff);
    display(lagDiff2);
    
    signal = signal(lagDiff + length(barker) + 4410 : lagDiff2);  
end