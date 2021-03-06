function [postNoise] = wiener(preNoise,musicBlock)

%Sxy = abs(cpsd(preNoise,preSignal,[],[],(length(preNoise) * 2) - 1));
[Ss,~] = periodogram(musicBlock',[],(length(musicBlock) * 2) - 1);
[Sxx,~] = periodogram(preNoise',[],(length(musicBlock) * 2) - 1);



figure
subplot(2,1,1)
plot(Ss')
title('Spectral Power Density of Music Signal')
subplot(2,1,2)
plot(Sxx')
title('Spectral Power Density of Pre-Noise Signal')

postNoise = Ss./(Ss + Sxx);
postNoise = postNoise';
end