%% Function which convert a binary string into text
function text = asciiToText(ascii)
    if(nargin < 1)
        ascii = strcat(dec2bin('a'),dec2bin('b'),dec2bin('c'));
    end
    text = '';
    while (mod(length(ascii),8) ~= 0)
        ascii = strcat(ascii,'0');
    end
    for i = 1:8:length(ascii)
        temp = extractBetween(ascii,i,i+7);
        number = bin2dec(temp);
        c = native2unicode(number);
        text = [text, c];
    end
    disp(text);
end