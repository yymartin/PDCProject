%% Test asciiToText
ascii = textToSpeechWithNumber('text.txt');
expected = "Hello, I am a test file";
assert(asciiToText(ascii) == expected);