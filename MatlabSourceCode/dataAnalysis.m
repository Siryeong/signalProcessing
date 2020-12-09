%% data open
caf3 = close5(3,:);
oaf3 = open5(3,:);
N = length(close5);
samplingRate = 256;
t = [0:N-1]/samplingRate;

%% fft

[cspct f] = myfft(caf3, samplingRate, N);
[ospct f] = myfft(oaf3, samplingRate, N);

%% data smoothing
%csm = smoothdata(cspct, 'gaussian', 20);
%osm = smoothdata(ospct, 'gaussian', 20);

csm = movmean(cspct, 1);
osm = movmean(ospct, 1);

%% ploting
% fft
figure(1)
subplot(211);
plot(f, abs(csm));
xlim([1 50]); ylim([0 5*10^7]);
subplot(212);
plot(f, abs(osm));
xlim([1 50]); ylim([0 5*10^7]);

%raw
figure(2);
subplot(211);
plot(t, caf3);
subplot(212);
plot(t, oaf3);


%% function
function [spct, f] = myfft(x, samplingRate, N)

spct = fft(x);
spct = fftshift(spct);
fs = samplingRate/N;
f = fs*[0:N-1];
f = f - mean(f);

end
