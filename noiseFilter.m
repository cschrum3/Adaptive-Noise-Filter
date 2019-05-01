%% Audio Device
info = audiodevinfo; % Struct that contains internal audio device info and ID
%% Init
Fs = 44100; %Sample Rate
timeStep = 0.001; %Window Time step
blockSize = round(Fs * timeStep); %Blocksize
SNR = 1;
%% Create music input using audiorecorder
[music,Fs] = audioread('po35.wav'); %temporary music file load
plot(music) %plot waveform
%% Create recording objects
ambientRec = audiorecorder(44100,16,1,0); % Records Noise from Internal microphone
musicRec = audiorecorder(44100,16,1,2); % Records muisc from AudioInterface

%% Create audio block (1ms)
while (musicRec.isrecording)
  % get blocks
    recordblocking(musicRec,.1);
    recordblocking(ambientRec, .1);
  % turn to data
    musicBlock = getaudiodata(musicRec)';
    ambientBlock = gataudiodata(ambientRec)';
  % create noise
    Noise = generateNoise(length(musicBlock),'white',1);
  % preNoise
    preNoise = ambientBlock + Noise;
  % preSignal
    preSignal = preNoise + musicBlock;
  % postNoise
    [postNoise] = wiener2(preNoise,[1,44100]);
  % postSignal
    postSignal = preSignal - postNoise;
  % playback
    soundsc(postSignal, Fs);
end
