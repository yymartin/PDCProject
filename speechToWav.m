function speechToWav()

%CD Quality record
recObj = audiorecorder(44100, 16, 2);
disp('Start speaking.')
recordblocking(recObj, 3);
disp('End of Recording.');
Fs = 44100;
%Save recorder audio to wave file in same directory
y = getaudiodata(recObj);

audiowrite('sound.wav',y,44100);
