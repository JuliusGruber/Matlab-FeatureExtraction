function script4

% Recording audio signals using the  audiorecorder() Matlab function

% audio recording format:
Fs = 16000;                     % sampling frequency
nBits = 16;                     % sample resolution
nChannels = 1;                  % number of chanels (mono)
nBlocks = 10;                   % number of blocks to be processed

% start audio recording objects:
recObj1 = audiorecorder(Fs, nBits, nChannels);
BlockSize = 1.0;                % analysis block size (in seconds)
record(recObj1, BlockSize);     % start recording
countBlocks = 0;                % number of blocks analysed
T1 = cputime;

while (1)    
    T2 = cputime;
    
    if T2-T1>BlockSize         
        time = (countBlocks-1)*BlockSize+1/Fs: 1/Fs :countBlocks*BlockSize;                
        stop(recObj1);                  % stop recording data
        x = getaudiodata(recObj1);      % get the current block data        
        T1 = cputime;
        record(recObj1, BlockSize);     % start recording buffer                
        x(length(time)) = 0;        
        countBlocks = countBlocks + 1;            
        if (countBlocks>nBlocks) break;  end;
        plotSignal(x, time, countBlocks, nBlocks);       
    end    
end


function plotSignal(x, time, countBlocks, nBlocks)
% function plotSignal(x, time, countBlocks, nBlocks)
% This function plots the given block and the respective signal level


% clip current audio block:
x(x>0.9999) = 0.9999; x(x<-0.9999) = -0.9999;

% PLOT THE CURRENT BLOCK:      
subplot(1,2,1);
plot(time, x);
str = sprintf('Current block: %d of %d',countBlocks, nBlocks);
title(str);
xlabel('Time (sec)')
axis([min(time) max(time) -1 1]);

% COMPUTE AND PLOT THE SIGNAL LEVEL:
subplot(1,2,2);

% define minimum signal level (in dB):
MIN_DB = -60;
% minimum signal level has to be negative and a multiple of -10:
if (MIN_DB>0) MIN_DB = - MIN_DB; end
MIN_DB = MIN_DB - mod(MIN_DB,10);

% compute signal level (in dB):
Level  = 10*log10(mean(x.^2));
LevelN = Level - MIN_DB;

% plot normalized signal level
B = bar(LevelN);
set(B, 'BarWidth', 1);
axis([0.5 1.5 0 -MIN_DB]);
% set y tick labels:
set(gca, 'YTick', 0:10:-MIN_DB);
set(gca, 'XTickLabel', '');
% set YTick labels:
for (LL=1:length(get(gca, 'YTick')))
    Labels{LL} = sprintf('%d', -MIN_DB - (LL-1) * 10);
end
set(gca, 'YTickLabel', Labels);
% plot text of the extact signal level value (in dB):
T = text(0.90, 5, sprintf('%.3f dB', Level));
set(T, 'FontSize', 12);
set(T, 'Color', [1 0.60 0.20]);
title('Signal Level (dB)')
drawnow;
