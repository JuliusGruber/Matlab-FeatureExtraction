% script3.m
% Recording of audio signals using the Matlab Acquisition Toolbox

% Create soundcard object:
ai = analoginput('winsound');

% Add channel:
addchannel(ai,1);

% Recording properties configuration:
Fs = 16000;                     % sampling frequency
duration = 1.0;                 % duration of each BLOCK
nBlocks = 20;                   % number of BLOCKS to be processed
set (ai, 'SampleRate', Fs);     % set Fs
set(ai, 'SamplesPerTrigger', duration*Fs); % set block duration
set(ai,'TriggerType','Manual')

Xall = [];                      % Overall buffer initilization:

% start recording loop:
for (i=1:nBlocks)    
    start(ai); trigger(ai);     % Start recodring process:   
    time = (i-1)*duration+1/Fs: 1/Fs :i*duration;   % Compute time vector:        
    if (i>1)                    % If at least one block has been read        
        x(x>0.9999) = 0.9999;   % clip current audio block:
        x(x<-0.9999) = -0.9999;        
        Xall = [Xall;x];        % Append the last block:
        
        % PLOT THE CURRENT BLOCK:
        subplot(1,2,1); plot(time, x);
        str = sprintf('Current block: %d of %d',i, nBlocks);
        title(str); xlabel('Time (sec)')
        axis([min(time) max(time) -1 1]);
        
        % COMPUTE AND PLOT THE SIGNAL LEVEL:
        subplot(1,2,2);
        
        % define minimum signal level (in dB):
        MIN_DB = -40;
        % minimum signal level has to be negative and a multiple of -10:
        if (MIN_DB>0) MIN_DB = - MIN_DB; end
        MIN_DB = MIN_DB - mod(MIN_DB,10);
        
        % compute signal level (in dB):
        Level  = 10*log10(mean(x.^2)); LevelN = Level - MIN_DB;
        
        % plot normalized signal level
        B = bar(LevelN); set(B, 'BarWidth', 1);
        axis([0.5 1.5 0 -MIN_DB]);
        % set y tick labels:
        set(gca, 'YTick', 0:10:-MIN_DB); set(gca, 'XTickLabel', '');
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
    end
    
    % check if recording process is still on
    if (strcmp(get(ai,'Running'),'On')==1) 
        % GET CURRENT BLOCK:
        x = getdata(ai, duration * Fs);                
    else
        x = zeros(duration*Fs,1);
        fprintf('Problem reading input!!!!!!\n');
    end            
end

% clear acquisition handler:
delete(ai); clear ai

% Save the whole recorded signal:
wavwrite(Xall, Fs, 16, 'recordedFile.wav');
