%******BASSDRUM**********
fileNameBassdrum = 'C:\Users\Julius\Desktop\Violin Persussion\bassdrum\bass-drum__1_fortissimo_struck-singly.mp3';
[audioBassdrum,fs] = audioread(fileNameBassdrum);

% plot the waveform BASSDRUM
figure();
ax1 = subplot(2,3,1);

timeLine= linspace( 0,length(audioBassdrum)/fs,length(audioBassdrum));
plot(ax1, timeLine,audioBassdrum);
ylabel('Amplitude')
% xlabel('Zeit(Sec)')



% spectrogram BASSdRUM
x = audioBassdrum(:, 1);            % get the first channel
xmax = max(abs(x));                 % find the maximum abs value
x = x/xmax;                         % scalling the signal

% define analysis parameters
xlen = length(x);                   % length of the signal
wlen = 1024;                        % window length (recomended to be power of 2)
h = wlen/2;                         % hop size (recomended to be power of 2)
nfft = 4096;                        % number of fft points (recomended to be power of 2)

% define the coherent amplification of the window
K = sum(hamming(wlen, 'periodic'))/wlen;

% perform STFT
[s, f, t] = stft(x, wlen, h, nfft, fs);

% take the amplitude of fft(x) and scale it, so not to be a
% function of the length of the window and its coherent amplification
s = abs(s)/wlen/K;

% correction of the DC & Nyquist component
if rem(nfft, 2)                     % odd nfft excludes Nyquist point
    st(2:end, :) = s(2:end, :).*2;
else                                % even nfft includes Nyquist point
    s(2:end-1, :) = s(2:end-1, :).*2;
end

% convert amplitude spectrum to dB (min = -120 dB)
s = 20*log10(s + 1e-6);




% plot the spectrogram BASSDRUM

ax1 = subplot(2,3,4);
imagesc(t, f, s)
set(gca,'YDir','normal')
% set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)

xlabel('Zeit(Sec)')
ylabel('Frequenz(Hz)')










% *****VIOLIN***********
fileNameViolin = 'C:\Users\Julius\Desktop\Violin Persussion\violin_Gs6_025_fortissimo_arco-normal.mp3';
[audioViolin,Fs] = audioread(fileNameViolin);



% plot the violine waveform
ax2 = subplot(2,3,2);
timeLineV= linspace( 0,length(audioViolin)/Fs,length(audioViolin));
plot(ax2,timeLineV, audioViolin);
% xlabel('Zeit(Sec)')
ylabel('Amplitude')

axis([ax2],[ min(timeLineV) max(timeLineV) -0.4 0.4  ]);


% spectrogram VIOLIN
x = audioViolin(:, 1);            % get the first channel
xmax = max(abs(x));                 % find the maximum abs value
x = x/xmax;                         % scalling the signal

% define analysis parameters
xlen = length(x);                   % length of the signal
wlen = 1024;                        % window length (recomended to be power of 2)
h = wlen/2;                         % hop size (recomended to be power of 2)
nfft = 4096;                        % number of fft points (recomended to be power of 2)

% define the coherent amplification of the window
K = sum(hamming(wlen, 'periodic'))/wlen;

% perform STFT
[s, f, t] = stft(x, wlen, h, nfft, fs);

% take the amplitude of fft(x) and scale it, so not to be a
% function of the length of the window and its coherent amplification
s = abs(s)/wlen/K;

% correction of the DC & Nyquist component
if rem(nfft, 2)                     % odd nfft excludes Nyquist point
    st(2:end, :) = s(2:end, :).*2;
else                                % even nfft includes Nyquist point
    s(2:end-1, :) = s(2:end-1, :).*2;
end

% convert amplitude spectrum to dB (min = -120 dB)
s = 20*log10(s + 1e-6);




% plot the spectrogram VIOLIN

ax2 = subplot(2,3,5);
imagesc(t, f, s)
set(gca,'YDir','normal')
% set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)

xlabel('Zeit(Sec)')
ylabel('Frequenz(Hz)')





