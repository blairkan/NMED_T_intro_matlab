function ax = plotTrial_FD(X, maxHz)
% ax = plotTrial_FD(X, maxHz)
% ----------------------------------------------------------
% Blair Kaneshiro - Feb 2024
%
% This function takes in a 2D data matrix (e.g., single trial or
% trial-averaged data for one song) and creates a frequency-domain overlay
% plog.
%
% Concepts covered: Function returning multiple outputs, data loading, FFT,
% visualizing data.
%
% Input
% - X (required): A 2D [time x space] matrix of data to be visualized.
% - maxHz (option): The maximum frequency to include in the plot. If empty
%   or not entered, the function will default to 12 Hz.
%
% Output
% - ax: The plot axis handle
%
% See also: plotTrial_TD

% Make sure the BKanMatEEGRepo is in the path
assert(~isempty(which('computeFFTFrequencyAxis')), ...
    'Make sure the BKanMatEEGToolbox repo is in your path.')

% Make sure the user entered exactly one input
assert(nargin >= 1, 'This function requires at least one input (a 2D data matrix).')

% Make sure the input data is 2D
assert(ndims(X) == 2, 'The input data matrix should be 2D [time x space].')

% If maxHz empty or not entered, make it 12
if nargin < 2 || isempty(maxHz), maxHz = 12; end

% Create the time axis of the data
fs = 125; % Hard coding the sampling rate of the data as 125 Hz

% Compute the frequency axis
fAx = computeFFTFrequencyAxis(size(X, 1), fs);

% Get indices in the frequency range we want
fIdx = find(fAx <= maxHz); 

% Compute the magnitude spectrum of the data. Matlab will automatically
% compute the FFT of each column (electrode) independently.
XF = abs(fft(X));

% We plot the data from each electrode, one electrode on top of the other.
% If you ask Matlab to plot a matrix, it will plot each column of data
% independently. 

% Plot the data, only for the specified low frequency bins.
plot(fAx(fIdx), XF(fIdx,:));
fSize = 14; % Font size for everything in the figure
set(gca, 'fontsize', fSize); % Set font size for this subplot

xlabel('Frequency (Hz)'); ylabel('FFT Magnitude (A.U.)')
xlim('tight') % Remove excess x-axis space in the plot.

ax = gca;

