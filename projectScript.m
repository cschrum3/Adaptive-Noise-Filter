%% Init
Fs = 44100;
timeStep = 0.001; 
blockSize = round(Fs * timeStep);
%% Create music input using audiorecorder
[music,Fs] = audioread('po35.wav'); %temporary
%% Create ambient noise input using audiorecorder
r = audiorecorder(44100,16,1);

recordblocking(r,10);
play(r);
%% generate noise
Noise = NoiseGeneration(Symbols, SNR);
%% Sum

%% Weiner

%% Desum

