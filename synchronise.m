function signal = synchronise(signal, barker, barker2)
    %[acor,lag] = xcorr(signal,barker);
    % Get first 2 maximum and sort them
    %[~,I] = maxk(abs(acor),2);
    %lagDiff = sort(lag(I));
    % Smallest is the start point and biggest is the end point
    %begin = lagDiff(1);
    %the_end = lagDiff(2);
    %signal = signal(begin + length(barker) + 1 : the_end);
    
    [acor,lag] = xcorr(signal,barker);
    [~,I] = max(abs(acor));
    lagDiff = lag(I);
    
    [acor2,lag2] = xcorr(signal,barker2);
    [~,I2] = max(abs(acor2));
    lagDiff2 = lag2(I2);
    
    display(lagDiff);
    display(lagDiff2);
    
    signal = signal(lagDiff + length(barker) + 1 : lagDiff2);
    
    
    
end