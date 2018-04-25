function speechToWav()

%CD Quality record
recObj = audiorecorder(44100, 16, 2);

disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

%Save recorder audio to wave file in same directory
y = getaudiodata(recObj);
audiowrite('sound.wav',y,44100);