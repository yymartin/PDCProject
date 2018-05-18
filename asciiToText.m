function asciiToText(ascii)
    if(nargin < 1)
        ascii = dec2bin('a');
    end
    text = '';
    for i = 1:7:length(ascii)
        temp = extractBetween(ascii,i,i+6);
        disp(temp);
        text = strcat(text,char(bin2dec(temp)));
    end
    disp(text);
end