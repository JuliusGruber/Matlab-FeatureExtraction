% script1.m
% Demonstrates the generation of synthetic tones

Fs = 16000; Ts = 1/Fs;          % Sampling frequency, sampling period
time = 0:Ts:0.1;                % Define when sampling occurs 
                                % (sampling lasts for 0.1 secs):
Freqs = [250 550 900];          % These are the frequencies of the signals
Xs = zeros(length(Freqs), length(time));
                                
for i=1:length(Freqs)           % Create one audio signal (tone) per frequency
    Xs(i,:) = cos(2*pi*Freqs(i)*time); 
end

x = sum(Xs);                    % The final sum of tones
x = x ./ max(abs(x));           % Normalize x

figure; plot(time, x); axis([0 time(end) -1 1]); % Plot x:
xlabel('Time (sec)'); ylabel('Signal Ampl.'); 
title('A simple audio signal')
