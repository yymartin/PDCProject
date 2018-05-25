function signal = synchronise(signal, barker)
    [acor,lag] = xcorr(signal,barker);
    % Get first 2 maximum and sort them
    [~,I] = maxk(abs(acor),2);
    lagDiff = sort(lag(I));
    % Smallest is the start point and biggest is the end point
    begin = lagDiff(1);
    the_end = lagDiff(2);
    signal = signal(begin + length(barker) + 1 : the_end);
end