%% Function which delete useless parts of a sound (typically before and after transmission)
function y = keepBinary(y, threshold)
    % Remove first boom
    %y = y(2000:length(y));

    temp = y;
    start_temp = 1;
    end_temp = length(y);
    
    % Remove silence after transmission
    for j = length(temp):-1:1
        if(temp(j) > threshold)
            temp = temp(1:j);
            end_temp = j;
            break;
        end
    end
    
    % Remove silence before transmission
    for i = 1:length(temp)
       if(temp(i) > threshold)
           temp = temp(i:length(temp));
           start_temp = i;
           break;
       end
    end
    
    if(length(temp) >= 4410)
        
        % Reduce to a length of m*4410
        count = 0;
        while(mod(length(temp),4410) ~= 0)
            if(mod(count,2) == 0)
                temp = temp(2:length(temp));
                count = count + 1;
            else
                temp = temp(1:length(temp)-1);
                count = count + 1;
            end
        end  
    else
        % Expand to a length of m*4410
        count = 0;
        while(mod(length(temp),4410) ~= 0)
            if(mod(count,2) == 0)
                temp = y(start_temp-1:end_temp);
                start_temp = start_temp-1;
                count = count + 1;
            else
                temp = y(start_temp:end_temp+1);
                end_temp = end_temp + 1;
                count = count + 1;
            end
        end 
    end
    
    y = temp;
    
end