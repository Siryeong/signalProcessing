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

% raw
% figure(2);
% subplot(211);
% plot(t, caf3);
% subplot(212);
% plot(t, oaf3);


%% function
function [spct, W] = myfft(x, rate, N)

% usage : [spct, W] = myfft(x, rate, N)
%
% x = input data
% rate = sampling frequency
% N = length of data
% 
% spct = spectrum of x
% W = frequency axis of spct

spct = fft(x);
spct = fftshift(spct);
fs = rate/N;
W = fs*[0:N-1];
W = W - mean(W);

end
