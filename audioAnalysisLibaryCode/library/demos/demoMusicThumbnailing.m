songPath = '../song.wav';
% read the WAV data:
[x,fs] = wavread(songPath);
% get the thumbnail limits:
sWin = 0.25; sStep = 0.25; thumbnailSize = 30.0;
t = musicThumbnailing(x, fs, sWin, sStep, thumbnailSize, 3, 0);
% read the 1st couple of thumbnails:
[x1, fs] = wavread(songPath, round([t(1,1) t(1,2)] * fs));
[x2, fs] = wavread(songPath, round([t(1,3) t(1,4)] * fs));
% play the two thumbnails:
fprintf('Playing the 1st segment\n');
sound(x1, fs);
fprintf('Press any key to play the 2nd segment...\n');pause
fprintf('Playing the 2nd segment\n');
sound(x2, fs);
