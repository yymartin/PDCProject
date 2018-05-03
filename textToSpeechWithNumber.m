%% This function takes a file and transmits the text in binary
function textToSpeechWithNumber(filename)
text = fileread(filename);

for i = text
    %convert text to binary
    toSend = dec2bin(i);
    
    %make corresponding sound
    dobeep(toSend);
end