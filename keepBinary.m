%% Function which delete useless parts of a sound (typically before and after transmission)
function y = keepBinary(y, threshold)
    % Remove first boom
    y = y(2000:length(y));
    
    % Remove silence after transmission
    for i = 1:length(y)
       if(y(i) > threshold)
           y = y(i:length(y));
           break;
       end
    end
    
    % Remove silence before transmission
    for j = length(y):-1:1
        if(y(j) > threshold)
            y = y(1:j);
            break;
        end
    end
end