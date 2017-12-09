fileName = 'C:\Users\Julius\Desktop\SampleDatenbanken\synth-samples\FSP-FREE-SYNTHS (15).wav';



trimmed = miraudio(fileName, 'Trim');

framed = mirframe(trimmed, 'Length', 0.02, 's');%default half overlapping


result = mirfeatures(framed, 'Stat');
 
% %%%%%%%%%%%%%%%%%%%% list of available features %%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%% DYNAMICS%%%%%%%%%%%%%%
rmsMean = result.dynamics.rms.Mean;
rmsStd = result.dynamics.rms.Std;
rmsSlope = result.dynamics.rms.Slope;
rmsPerioEntropy = result.dynamics.rms.PeriodEntropy;

%  %%%%%%%%SPECTRAL%%%%%%%%%%%%%%%%%%%%%
% spectral Centroid
spectralCentroidMean = result.spectral.centroid.Mean;
spectralCentroisStd = result.spectral.centroid.Std;
spectralCentroidSlope = result.spectral.centroid.Slope;
spectralCentroidEntropy = result.spectral.centroid.PeriodEntropy;

% brightness
brightnessMean = result.spectral.brightness.Mean;
brightnessStd =result.spectral.brightness.Std;
brightnessSlope =result.spectral.brightness.Slope;
brightnessPeriodEntropy =result.spectral.brightness.PeriodEntropy;

% spread
spreadMean =result.spectral.spread.Mean;
spreadStd =result.spectral.spread.Std;
spreadSlope =result.spectral.spread.Slope;
spreadPeriodEntropy = result.spectral.spread.PeriodEntropy;

% skewness
skewnessMean = result.spectral.skewness.Mean;
skewnessStd =result.spectral.skewness.Std;
skewnessSlope =result.spectral.skewness.Slope;
skewnessPeriodEntropy =result.spectral.skewness.PeriodEntropy;

% kurtosis
kurtosisMean = result.spectral.kurtosis.Mean;
kurtosisStd = result.spectral.kurtosis.Std;
kurtosisSlope = result.spectral.kurtosis.Slope;
kurtosisSpectral = result.spectral.kurtosis.PeriodEntropy;

% rollOf95
rollOff95Mean = result.spectral.rolloff95.Mean;
rollOff95Std =result.spectral.rolloff95.Std;
rollOff95Slope =result.spectral.rolloff95.Slope;
rollOff95PeriodEntropy =result.spectral.rolloff95.PeriodEntropy;

% rollOff85
rollOff85Mean = result.spectral.rolloff85.Mean;
rollOff85Std =result.spectral.rolloff85.Std;
rollOff85Slope =result.spectral.rolloff85.Slope;
rollOff85PeriodEntropy =result.spectral.rolloff85.PeriodEntropy;

% specEntropy
specEntropyMean = result.spectral.spectentropy.Mean;
specEntropyStd =result.spectral.spectentropy.Std;
specEntropySlope =result.spectral.spectentropy.Slope;
specEntropyPeriodEntropy =result.spectral.spectentropy.PeriodEntropy;

% flatness
faltnessMean = result.spectral.flatness.Mean;
faltnessStd =result.spectral.flatness.Std;
faltnessSlope =result.spectral.flatness.Slope;
faltnessPeriodEntropy =result.spectral.flatness.PeriodEntropy;

% roughness
roughnessMean = result.spectral.roughness.Mean;
roughnessStd = result.spectral.roughness.Std;
roughnessSlope =result.spectral.roughness.Slope;
roughnessPeriodEntropy =result.spectral.roughness.PeriodEntropy;

% irregularity
irregularityMean = result.spectral.irregularity.Mean;
irregularityStd = result.spectral.irregularity.Std;
irregularitySlope =result.spectral.irregularity.Slope;
irregularityPeriodEntropy =result.spectral.irregularity.PeriodEntropy;

% mfcc
mfccMean = result.spectral.mfcc.Mean;
mfccStd =result.spectral.mfcc.Std;
mfccSlope =result.spectral.mfcc.Slope;
mfccPeriodentropy =result.spectral.mfcc.PeriodEntropy;

% deltaMFCC
mfccDeltaMean = result.spectral.dmfcc.Mean;
mfccDeltaStd =result.spectral.dmfcc.Std;
mfccDeltaSlope =result.spectral.dmfcc.Slope;
mfccDeltaPeriodEntropy =result.spectral.dmfcc.PeriodEntropy;

% deltaDeltaMFCC
mfccDeltaDeltaMean = result.spectral.ddmfcc.Mean;
mfccDeltaDeltaStd =result.spectral.ddmfcc.Std;
mfccDeltaDeltaSlope =result.spectral.ddmfcc.Slope;
mfccDeltaDeltaPeriodentropy =result.spectral.ddmfcc.PeriodEntropy;

%  %%%%%%%%TIMBRE%%%%%%%%%%%%%%%%%%%%%
% Zero Crossing Rate
zcrMean = result.timbre.zerocross.Mean;
zcrStd =result.timbre.zerocross.Std;
zcrSlope =result.timbre.zerocross.Slope;
zcrPeriodEntropy =result.timbre.zerocross.PeriodEntropy;

% low energy
lowEnergyMean = result.timbre.lowenergy.Mean;

% spectral flux
spetralFluxMean = result.timbre.spectralflux.Mean;
spetralFluxStd =result.timbre.spectralflux.Std;
spetralFluxSlope =result.timbre.spectralflux.Slope;
spetralFluxPeriodEntropy =result.timbre.spectralflux.PeriodEntropy;

% %%%%%%%% TONAL%%%%%%%%%%%%%%%%%%%%%%%%%%
chromagramMean = result.tonal.chromagram.centroid.Mean;
chromagramStd =result.tonal.chromagram.centroid.Std;
chromagramSlope =result.tonal.chromagram.centroid.Slope;
chromagramPeriodEntropy =result.tonal.chromagram.centroid.PeriodEntropy;

keyclarityMean = result.tonal.keyclarity.Mean;
keyclarityStd = result.tonal.keyclarity.Std;
keyclaritySlope = result.tonal.keyclarity.Slope;
keyclarityPeriodEntropy = result.tonal.keyclarity.PeriodEntropy;

modeMean = result.tonal.mode.Mean;
modeStd = result.tonal.mode.Std;
modeSlope = result.tonal.mode.Slope;
modePeriodEntropy = result.tonal.mode.PeriodEntropy;












