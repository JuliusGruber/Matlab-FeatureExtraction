lowFreq = 0;
highFreq = 10000;


f=linspace(lowFreq,highFreq,10000);
mel = log(1+f/700)*1127.01048;

figure();
plot(f, mel);





% freq Tick Marks

% xticks([-3*pi -2*pi -pi 0 pi 2*pi 3*pi])

% mel Tick Marks
% filtersMel = ([200 400 1500 1700 2500 2700]);
% filtersMel = [100 200];
% num_filt = 20;
% melIdx = linspace(0,mel(end),num_filt+2);

% yticks(filtersMel);





