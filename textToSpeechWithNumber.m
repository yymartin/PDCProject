%% This function takes a file and transmits the text in binary
function toSend = textToSpeechWithNumber(filename)
    text = fileread(filename);
    toSend = '';
    for i = text
        %convert text to binary
        decimal = unicode2native(i);
        toSend = strcat(toSend,dec2bin(decimal,8));
    end
    %make corresponding sound
    disp(toSend);
    dobeep(toSend,0.1,0.1);
end

