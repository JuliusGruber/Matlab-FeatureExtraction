fileNameBassdrum = 'C:\Users\Julius\Desktop\Violin Persussion\bassdrum\bass-drum__1_fortissimo_struck-singly.mp3';
fileNameViolin = 'C:\Users\Julius\Desktop\Violin Persussion\violin_Gs6_025_fortissimo_arco-normal.mp3';

% Default value for sr: 44100 Hz
mirAudio = miraudio(fileNameViolin);

extract = miraudio(mirAudio,'Extract',0.2,0.4,'s');

mirframe(extract, 'Length', 1024, 'sp') % ~ 23 ms
