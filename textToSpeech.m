function textToSpeech(filename)
 
%Open .txt file
fid = fopen(filename,'r');
A = fscanf(fid,'%s');
fclose(fid);

%Create system command to read file
sentence = "say "+A;

%Execute system command
system(sentence);
    
    