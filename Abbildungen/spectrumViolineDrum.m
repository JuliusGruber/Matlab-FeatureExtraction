fileNameBassdrum = 'C:\Users\Julius\Desktop\Violin Persussion\bassdrum\bass-drum__1_fortissimo_struck-singly.mp3';
[x,Fs] = audioread(fileNameBassdrum);

s = spectrogram(x, 1024)



spectrogram(x)