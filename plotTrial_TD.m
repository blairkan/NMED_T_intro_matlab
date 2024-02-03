function ax = plotTrial_TD(X)
% ax = plotTrial_TD(X)
% ----------------------------------------------------------
% Blair Kaneshiro - Feb 2024
%
% This function takes in a 2D data matrix (e.g., single trial or
% trial-averaged data for one song) and creates a time-domain overlay plot.
%
% Concepts covered: Function returning multiple outputs, data loading, 
% visualizing data.
%
% Input
% - X (required): A 2D [time x space] matrix of data to be visualized.
%
% Output
% - ax: The plot axis handle
%
% See also: plotTrial_FD

% Make sure the user entered exactly one input
assert(nargin == 1, 'This function requires one input (one 2D data matrix).')

% Make sure the input data is 2D
assert(ndims(X) == 2, 'The input data matrix should be 2D [time x space].')

% Create the time axis of the data
fs = 125; % Hard coding the sampling rate of the data as 125 Hz
tAx = ((0:(size(X,1)-1))/fs); % Time axis, in seconds

% We plot the data from each electrode, one electrode on top of the other.
% If you ask Matlab to plot a matrix, it will plot each column of data
% independently. 
plot(tAx, X);
fSize = 14; % Font size for everything in the figure
set(gca, 'fontsize', fSize); % Set font size for this subplot

xlabel('Time (sec)'); ylabel('Amplitude (\muV)')
xlim('tight') % Remove excess x-axis space in the plot.

ax = gca;


