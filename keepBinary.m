function y = keepBinary(y, threshold)
    y = y(1000:length(y));
    for i = 1:length(y)
       if(y(i) > threshold)
           y = y(i:length(y));
           break;
       end
    end

    for j = length(y):-1:1
        if(y(j) > threshold)
            y = y(1:j);
            break;
        end
    end
end