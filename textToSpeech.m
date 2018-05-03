function textToSpeech(filename)
 
%Open .txt file
A = fileread(filename);

%Create system command to read file
sentence = "say -r 100 -v 'Karen' "+A;

%Execute system command
system(sentence);
    
    