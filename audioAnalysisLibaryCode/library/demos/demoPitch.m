function demoPitch(window, Fs)

% This function can be used to demonstrate the autocorrelation-based
% pitch estimation.
%
% Example:
% fs = 16000; T = 0:1/fs:0.050; 
% x = 0.95*cos(2*pi*500*T) + 0.5*cos(2*pi*1000*T) + ...
%     0.8*cos(2*pi*2500*T) + 0.2*cos(2*pi*3500*T); 
% demoPitch(x, fs)


M=round(0.016*Fs);

% compute autocorrelation:
R=xcorr(window);
g=R(length(window));

R=R(length(window)+1:end);
i=2;
subplot(2,1,1); plot(R(1:M)); xlabel('m (Lag)'); ylabel('R(m)'); axis([0 M min(R) max(R)]);
% estimate m0 (as the first zero crossing of R)
m0=length(R)+1;
while i<=length(R)
    if R(i)<0 & R(i-1)>=0
        m0=i;
        break;
    end
    i=i+1;
end

% compute normalized autocorrelation:
Gamma = zeros(M, 1);
CSum = cumsum(window.^2);
Gamma(m0:M) = R(m0:M) ./ (sqrt((g*CSum(end-m0:-1:end-M)))+eps);
Z = feature_zcr(Gamma);

subplot(2,1,2); plot(Gamma); xlabel('m (Lag)'); ylabel('\Gamma (m)'); ; axis([0 M min(Gamma) max(Gamma)]);

if Z > 0.15
    HR = 0;
    f0 = 0;
else
    % compute T0 and harmonic ratio:
    if isempty(Gamma)
        HR=1;
        blag=0;
        Gamma=zeros(M,1);
    else
        [HR, blag] = max(Gamma);
    end
    % get fundamental frequency:
    f0 = Fs / blag;
    if f0>5000 f0 = 0; end
    if HR<0.1 f0 = 0; end;    
end

L = line([blag blag],[-HR HR]);
set(L,'Color',[1 0 0]);