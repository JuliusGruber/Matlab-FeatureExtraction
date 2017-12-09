% script2.m
% Generation, representation and playback of STEREO signals in Matlab

Fs = 16000; Ts = 1/Fs;          % Sampling freq, period
time = 0:Ts:0.1;                % Define time vector (0.1 secs duration)

% Signal computation:
xLeft  = cos(2*pi*250*time)';   % Left channel
xRight = cos(2*pi*450*time)';   % Right channel
x = [xLeft xRight];             % Compose STEREO signal

% Plot x:
figure;
subplot(2,1,1); plot(time, x(:,1)); xlabel('Time (sec)'); title('Left Channel');
subplot(2,1,2); plot(time, x(:,2)); xlabel('Time (sec)'); title('Right Channel');
sound(x,Fs);                    % Play x:
