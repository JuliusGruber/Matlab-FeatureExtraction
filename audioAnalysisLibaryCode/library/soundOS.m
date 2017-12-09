function soundOS(x, fs, nBits)

% function soundOS(x, fs, nBits)
% 
% This funciton is an alternative to the Matlab sound() function for 
% playing sounds in both the WINDOWS and UBUNTU operating systems
% (c) 2014 T. Giannakopoulos, A. Pikrakis

if nargin==1
    fs = 8000;  % define default sampling rate
    nBits = 16; % define default value for bits/sample
end
if nargin==2    % if fs has been provided by the user
    nBits = 16; % define default value for bits/sample
end

if isunix
    % generate a random file name for a temporary .wav file
    wavFileNameTemp = sprintf('temp_sound_%d.wav', round(rand(1)*100));
    % store the sound in the temporary wav file
    wavwrite(x, fs, nBits, wavFileNameTemp);
    % playback the file using the aplay ubuntu command
    system(['aplay ' wavFileNameTemp]);
    % delete the temporary file:
    system(['rm ' wavFileNameTemp]);
else
    % otherwise use the default sound() command:
    sound(x, fs, nBits);
end
