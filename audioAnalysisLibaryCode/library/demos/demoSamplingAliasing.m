function demoSamplingAliasing

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% PART A: FIGURE OF SPECTRUM FOR THE SAMPLING PROCESS
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

B = 2;
nSpectrals = 8;

x = -B:0.1:B;
F = -x.^2 + B^2;

subplot(3,1,1); plot(x, F); title('Spectrum of the analog signal');
axis([-B*nSpectrals B*nSpectrals 0 max(F)]);
set(gca, 'XTick', [-B B]); set(gca, 'XTickLabel', {'-B' 'B'})
set(gca, 'YTick', [0]); set(gca, 'YTickLabel', {''});

subplot(3,1,2);
hold on;
fs = B * 2.5;
numOfPlots = round(nSpectrals * B / fs);
xTicks = [];
xTicksLabels = {};
for i=-numOfPlots:numOfPlots
    plot(x+i*fs, F);   
    xTicks = [xTicks i*fs];
    if i==0
        xTicksLabels{end+1} = '0';
    else
        if i==1 || i==-1
            xTicksLabels{end+1} = sprintf('fs');
        else
            xTicksLabels{end+1} = sprintf('%dfs',i);            
        end
    end
end
title('Spectrum of the sampled signal,  f_s > 2B');

axis([-B*nSpectrals B*nSpectrals 0 max(F)]);
set(gca, 'XTick', xTicks); 
set(gca, 'XTickLabel', xTicksLabels);
set(gca, 'YTick', [0]); set(gca, 'YTickLabel', {''});


subplot(3,1,3);
hold on;
fs = B * 1.5;
numOfPlots = round(nSpectrals * B / fs);
xTicks = [];
xTicksLabels = {};
for i=-numOfPlots:numOfPlots
    plot(x+i*fs, F);   
    xTicks = [xTicks i*fs];
    if i==0
        xTicksLabels{end+1} = '0';
    else
        if i==1 || i==-1
            xTicksLabels{end+1} = sprintf('fs');
        else
            xTicksLabels{end+1} = sprintf('%dfs',i);            
        end
    end
end
title('Spectrum of the sampled signal, f_s < 2B');

axis([-B*nSpectrals B*nSpectrals 0 max(F)]);
set(gca, 'XTick', xTicks); 
set(gca, 'XTickLabel', xTicksLabels);
set(gca, 'YTick', [0]); set(gca, 'YTickLabel', {''});


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% PART B: ALIASING EXAMPLE
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

fs1 = 8000;
fs2 = 4000;

freqs = [200 500 3000];
totalDur = 1;

t1 = 0:1/fs1:totalDur;
t2 = 0:1/fs2:totalDur;

x1 = zeros(size(t1));
x2 = zeros(size(t2));

for i=1:length(freqs)
    x1 = x1 + cos(2*pi*t1*freqs(i));
    x2 = x2 + cos(2*pi*t2*freqs(i));
end

x1 = x1 / length(freqs);
x2 = x2 / length(freqs);

[FFT1, Freq1] = getDFT(x1, fs1);
[FFT2, Freq2] = getDFT(x2, fs2);

figure;
subplot(2,1,1); 
plot(Freq1, FFT1); xlabel('freq (Hz)');
title(sprintf('f_s = %d', fs1));
set(gca, 'YTickLabel', {});
subplot(2,1,2); 
plot(Freq2, FFT2); xlabel('freq (Hz)');
title(sprintf('f_s = %d', fs2));
set(gca, 'YTickLabel', {});