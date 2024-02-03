% example_dataLoadAvgPlot.m
% --------------------------------
% Blair Kaneshiro - Feb 2024
%
% This is an example script showing how the user can use various functions
% to load data, compute across-trial averages, and plot data in the time
% and frequency domains.

% Here are some common commands you may want to do when you are getting
% ready to perform an analysis: Clear variables from workspace, close all
% figures, and clear your console. 
clear all; close all; clc

% Let's also make sure a necessary git repo is in the path. If you need it,
% it's this one: https://github.com/blairkan/BKanMatEEGToolbox
assert(~isempty(which('ccc')), 'Make sure the BKanMatEEGToolbox repo is in your path.')

% NOTE: The data files should also be in your path already.

% Let's say we want to work with the data from song 25. 
songUse = 25;

% Load the data from that song
X = loadOneFile(25); % Will be a 3D [time x space x trial] matrix

%% Plot a single trial of data

% We could plot a single trial of data in the time and frequency domains.
% We can even select the trial randomly from the set of 20!
trialToPlot = randi(size(X,3));

% We can print a message saying which single trial we'll plot
disp(['Plotting data from trial ' num2str(trialToPlot)])

figure()
subplot(2, 1, 1)
plotTrial_TD(X(:, :, trialToPlot));
title('Time domain')

subplot(2, 1, 2)
plotTrial_FD(X(:, :, trialToPlot));
title('Frequency domain')

sgtitle(['Single-trial data, song ' num2str(songUse) ', trial ' num2str(trialToPlot)])

% You could try running this section several times to see how the
% single-trial data look for different participants. Do you see any
% spectral peaks in the frequency domain, especially in the 4-8 Hz range??

%% Plot trial-averaged data

% Compute the trial average of the data
XA = computeTrialAverage(X); % Will be a 2D [time x space] matrix

% Now we'll repeat the above plots in a new figure. 

figure()
subplot(2, 1, 1)
plotTrial_TD(XA);
title('Time domain')

subplot(2, 1, 2)
plotTrial_FD(XA);
title('Frequency domain')

sgtitle(['Trial-averaged data, song ' num2str(songUse)])

% Do the trial-averaged data look cleaner -- e.g., lower range of 
% amplitudes in the time domain? Perhaps a prominent spectral peak in the 
% frequency domain?
