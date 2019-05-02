%% Audio Device
%info = audiodevinfo; % Struct that contains internal audio device info and ID
%% Init
Fs = 44100; %Sample Rate
timeStep = 0.001; %Window Time step
blockSize = round(Fs * timeStep); %Blocksize
SNR = .1;
duration = 5;
%% Create music input using audiorecorder
[music,Fs] = audioread('po35.wav'); %temporary music file load
%plot(music) %plot waveform
%% Create recording objects
ambientRec = audiorecorder(44100,16,1,0); % Records Noise from Internal microphone
musicRec = audiorecorder(44100,16,1,2); % Records muisc from AudioInterface

recordblocking(musicRec,duration);
musicBlock = getaudiodata(musicRec)';

%% Create audio block (1ms)
%while (~isempty(musicBlock))
  % get blocks
    recordblocking(ambientRec,duration);
  % turn to data
    ambientBlock = getaudiodata(ambientRec)';
  % check isempty
    
  % create noise
    Noise = generateNoise(length(musicBlock),'pink',1);
  % preNoise: versions
    preNoise = ambientBlock + Noise;
    %preNoise = conv(ambientBlock,Noise);
    %preNoise = preNoise(1:2:end);
    %preNoise = ambientBlock;
    
  % preSignal
    preSignal = preNoise + musicBlock;
  % postNoise
  
    postNoise = wiener(Noise,musicBlock);    
   
  % postSignal
    postSignal = preSignal - (preNoise + postNoise);
  
  % Test plots

  % inputs
    figure 
    subplot(2,1,1)
    plot(ambientBlock)
    title('ambient noise')
    subplot(2,1,2)
    plot(musicBlock)
    title('music block')
    
  % noise  
    figure
    subplot(2,1,1)
    plot(preNoise)
    title('pre noise')
    subplot(2,1,2)
    plot(postNoise)
    title('post noise')
    
  % signals
    figure
    subplot(2,1,1)
    plot(preSignal)
    title('preSignal')
    subplot(2,1,2)
    plot(postSignal)
    title('postSignal')
    
  % playback
    soundsc(postSignal, Fs);
  % create new block
    recordblocking(musicRec,duration);
    musicBlock = getaudiodata(musicRec)';
%end
   
%{
    Sxy = abs(cpsd(preNoise,preSignal,[],[],(length(preNoise) * 2) - 1));
    [Sxx,~] = periodogram(preNoise',[],(length(Sxy) * 2) - 1);

    figure
    subplot(2,1,1)
    plot(Sxy)
    subplot(2,1,2)
    plot(Sxx)


    postNoise = (Sxy')./(Sxx');
    plot(postNoise);
%}

