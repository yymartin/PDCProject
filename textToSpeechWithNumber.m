%% This function takes a file and transmits the text in binary
function toSend = textToSpeechWithNumber(filename)
    text = fileread(filename);
    toSend = '';
    for i = text
        decimal = unicode2native(i);
        %convert text to binary
        toSend = strcat(toSend,dec2bin(decimal,8));
    end
    %make corresponding sound
    dobeep(toSend,0.1,0);
end

