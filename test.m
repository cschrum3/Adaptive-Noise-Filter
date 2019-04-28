[y,Fs] = audioread('po35.wav');
r = audiorecorder(44100,16,1);
disp('Start speaking.')
record(r,10);
disp('End of Recording.');
pause(r);
play(r);


