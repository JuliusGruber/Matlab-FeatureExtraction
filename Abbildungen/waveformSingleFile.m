%******BASSDRUM**********
fileNameBassdrum = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\TSD-RGS-001.wav';
[audioBassdrum,fs] = audioread(fileNameBassdrum);

% plot the waveform BASSDRUM
figure();
ax1 = subplot(2,3,1);

timeLine= linspace( 0,length(audioBassdrum)/fs,length(audioBassdrum));
plot(ax1, timeLine,audioBassdrum);
% ylabel('Amplitude')
% xlabel('Zeit(Sec)')