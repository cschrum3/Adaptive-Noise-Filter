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
%% Create ambient noise input using audiorecorder
noiseRecorder = audiorecorder(44100,16,1,0); % Records Noise from Internal microphone
musicRecorder = audiorecorder(44100,16,1,2); % Records muisc from AudioInterface
recordblocking(musicRecorder,.1);
play(musicRecorder);
%recordblocking(r,10);
%ambientData = getaudiodata(noiseRecorder)';
%soundData = getaudiodata(r2)';
%plot(ambientData);
%% generate noise
Noise = NoiseGeneration(ambientData, SNR);
preNoise = Noise + ambientData;

%% Windowing/recording

%% Window
for i = 1:round(N/2):(length(signal)-1)
    if (length(signal)-i >= M)
        tone = signal(i:i+(M-1)).* window;
    else
        noWindow = signal(i:end);
        tone = noWindow.*window(1:length(noWindow));
    end
    window_Coeffs = [];
    for j = 1:length(bins)
        window_Coeffs = [window_Coeffs abs(gfft(tone,N,bins(j)))];
        %obtain DFT coeffs for each bin for the windowed signal
    end
    coeffs = [coeffs; window_Coeffs]; 

end
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


