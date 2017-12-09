fileNameBassdrum = 'C:\Users\Julius\Desktop\Violin Persussion\bassdrum\bass-drum__1_fortissimo_struck-singly.mp3';
[y,Fs] = audioread(fileNameBassdrum);

figure();
% plot the bassdrum waveform
t= linspace( 0,length(y)/Fs,length(y));
ax1 = subplot(2,2,1);
plot(ax1,t,y);
ylabel('Amplitude')
xlabel('Zeit(Sec)')

%plot the fft bassdrum
Y = fft(y);

L = length(y);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = Fs*(0:(L/2))/L;

ax2 = subplot(2,2,2);
plot(ax2, f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('Frequenz (Hz)')
% ylabel('|P1(f)|')




fileNameViolin = 'C:\Users\Julius\Desktop\Violin Persussion\violin_Gs6_025_fortissimo_arco-normal.mp3';
[yV,Fs] = audioread(fileNameViolin);

% pad violine samples with zeros to have the same length
diff =  length(y)-length(yV);
zeroPad  =zeros(diff,1);
ViolinePad= cat(1, yV, zeroPad);

% plot the violine waveform
% t= linspace( 0,length(y)/Fs,length(y));

ax3 = subplot(2,2,3);
plot(ax3,t, ViolinePad);
xlabel('Zeit(Sec)')
ylabel('Amplitude')

% plot the fft violine
Y = fft(yV);

L = length(yV);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = Fs*(0:(L/2))/L;

ax4 = subplot(2,2,4);
plot(ax4, f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('Frequenz (Hz)')
% ylabel('|P1(f)|')



% axis([ax1],[t -0.4 0.4 ]);
axis([ax3],[ min(t) 1.4 -0.4 0.4  ]);