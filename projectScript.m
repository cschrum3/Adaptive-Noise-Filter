%% Audio Device
info = audiodevinfo;
%% Init
Fs = 44100;
timeStep = 0.001; 
blockSize = round(Fs * timeStep);
SNR = 1;
%% Create music input using audiorecorder
[music,Fs] = audioread('po35.wav'); %temporary
plot(music)
%% Create ambient noise input using audiorecorder
noiseRecorder = audiorecorder(44100,16,1,0);
musicRecorder = audiorecorder(44100,16,1,2);
%recordblocking(r2,10);
%recordblocking(r,10);
%ambientData = getaudiodata(r)';
%soundData = getaudiodata(r2)';
%plot(ambientData);
%% generate noise
Noise = NoiseGeneration(ambientData, SNR);
preNoise = Noise + ambientData;
%% Plot & Play
plot(preNoise);
soundsc(preNoise,Fs);
%soundsc(preNoise,44100);
%% Algorithm
coeff = fft(preNoise);
plot(coeff);
%% Weiner
[data,postNoise] = wiener2(preNoise,[1,44100]);
%% Desum

