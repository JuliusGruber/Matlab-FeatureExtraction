fileName = 'C:\Users\Julius\Desktop\Violin Persussion\bass drum\bass-drum__1_fortissimo_struck-singly.mp3';
[y,Fs] = audioread(fileName)

% plot the whole signal
% t= linspace( 0,length(y)/Fs,length(y));
% figure();
% plot(t, y);


% calculate frame Lenght in ms if a frame is 1024 samples 
% numSamplesFrame = Fs * dur/1000


frameLength = 1024; % if Fs = 44100 then the frame is ~ 23 ms long


% extract a frame at 0.1 sec

sampleNumberAt01 = 0.1*Fs;
frame = y(sampleNumberAt01: sampleNumberAt01+frameLength-1);


% plot again to test the result
% tFrame= linspace(1,length(frame), length(frame));
% figure();
% plot(tFrame, frame);
% plot( frame);


L =1024;
hannWindow = hann(L);
sampleNumbers = linspace(1, 1024, 1024)

% figure();
% plot( w)



% combine frame and hannWindow
windowedSignal = frame.*hannWindow;

% figure();
% plot(windowedSignal);


% plot all three curves
figure();
x1 = transpose(linspace(0,1024,1024));
y1 = frame;
ax1 = subplot(3,1,1);

plot(ax1,x1,y1)
% line(x1, linspace(0, 0, 1024), 'color', 'k')
ylabel('Amplitude');



y2 = hannWindow;
ax2 = subplot(3,1,2);
plot(ax2,x1,y2)
ylabel('Gewicht: w(p)');

ax3 = subplot(3,1,3);
plot(ax3,x1,windowedSignal);
% line(x1, linspace(0, 0, 1024), 'color', 'k')
ylabel('Amplitude');
xlabel('Position p der Abtastwerte (innerhalb des Frames)');

maxFrame = max(frame);
minFrame = min(frame);

axisValue = 0;
if maxFrame > abs(minFrame)
    axisValue = maxFrame;
else
    axisValue  = abs(minFrame);
end

axis([ax1],[0 1024, -axisValue, axisValue]);
axis([ax2], [0 1024, 0, 1.2]);
axis([ax3],[0 1024, -axisValue,axisValue]);





