% fileName = 'C:\Users\Julius\Desktop\SampleDatenbanken\bassDrumGroups\marker-30.wav';
fileName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\TSD-RGS-005.wav';

mirAudio = miraudio(fileName);
samplingRate = cell2mat(get(mirAudio ,'Sampling'));
numSamplesCell = get(mirAudio ,'Length');
numSamples = cell2mat(numSamplesCell{1,1});
% numSamples = 47000;
durationInSec = numSamples/samplingRate;

o = mironsets(fileName,'Attack','Single', 'Filter' );
[px,py] = mirgetdata(o);
attackTime = mirgetdata(mirattacktime(o, 'Log'));




if ~isempty(attackTime)

figure();
mirsegment(fileName, px)





attackPhase = miraudio(fileName, 'Extract',0, px, 's');
releasePhase = miraudio(fileName, 'Extract', px,durationInSec , 's');

% figure();
% mirspectrum(attackPhase, 'Frame')
% figure();
% mirspectrum(releasePhase, 'Frame')
end