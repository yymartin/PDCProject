disp('Send text');
textToSpeechWithNumber('text.txt');
disp('Transmission');


pause(10);
signal = audioread('sound.wav');
signal = signal(:,1);
barker = [doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1750) doSinWithFrequency(0.1,1250) doSinWithFrequency(0.1,1750)];
signal_synchronised = synchronise(signal, barker);
getBinaryFromSound(signal_synchronised,0.1);





