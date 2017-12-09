function demoDCTcompression(cR)
% Demonstrates how to use the DCT audio compression and decompression 
% functions

% EXAMPLE: demoDCTcompression(0.1)

% load audio signal from a sample wav file
[x,fs] = wavread(['..' filesep '..' filesep 'data' ...
    filesep 'diarizationExample.wav'], [280000 300000]);
% generate compressed DCT coefficients and indices
[DCTcoeffs, INDcoeffs] = dctCompress(x, 0.10, fs, cR);
% decompress using iDCT:
x2 = dctDecompress(DCTcoeffs, INDcoeffs, 0.10, fs);    
% listen to the results:
fprintf('Listening to the original sound ...');sound(x, fs);
fprintf('\nListening to the decompressed sound (%.2f ratio)...\n', cR);
sound(x2, fs);
