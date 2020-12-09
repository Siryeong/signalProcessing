%% data open

caf3 = close4(3,:);
oaf3 = open4(3,:);
N = length(close4);
samplingRate = 256;
t = [0:N-1]/samplingRate;

%% fft 

[cspct, f] = myfft(caf3, samplingRate, N);
[ospct, f] = myfft(oaf3, samplingRate, N);
cspct = abs(cspct);
ospct = abs(ospct);

%% data smoothing

csm = movmean(cspct, 30);
osm = movmean(ospct, 30);

%% ploting
% fft
figure(1)
plot(f, csm); hold on;
plot(f, osm); hold off;
legend("C", "O");
xlim([1 50]);

%raw
% figure(2);
% subplot(211);
% plot(t, caf3);
% subplot(212);
% plot(t, oaf3);


%% function
function [spct, W] = myfft(x, samplingRate, N)

spct = fft(x);
spct = fftshift(spct);
fs = samplingRate/N;
W = fs*[0:N-1];
W = W - mean(W);

end
