function Noise = NoiseGeneration(Symbols, SNR)
z = 10^(SNR/10); % Linearize SNR from dB value 
No = 1; 
T = 2; % Chosen so that var = N0*T/2 = 1
% SNR linear = ((A^2)*T)/No 
A =  abs(sqrt(No*z/T)); 
Noise = A*rand(1,length(Symbols));
end