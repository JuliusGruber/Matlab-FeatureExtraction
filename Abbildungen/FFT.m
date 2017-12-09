fileNameBassdrum = 'C:\Users\Julius\Desktop\Violin Persussion\bassdrum\bass-drum__1_fortissimo_struck-singly.mp3';
[x,Fs] = audioread(fileNameBassdrum);



Y = fft(x);
Z = fft(x,2056);

L = length(x);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = Fs*(0:(L/2))/L;

figure();
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('Frequenz (Hz)')
ylabel('|P1(f)|')


fileNameViolin = 'C:\Users\Julius\Desktop\Violin Persussion\violin_Gs6_025_fortissimo_arco-normal.mp3';

[x,Fs] = audioread(fileNameViolin);



Y = fft(x);

L = length(x);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = Fs*(0:(L/2))/L;

figure();
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

