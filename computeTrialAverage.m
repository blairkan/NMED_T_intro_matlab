function XAvg = computeTrialAverage(X)
% XAvg = computeTrialAverage(X)
% -------------------------------------
% Blair Kaneshiro - Feb 2024
%
% This function takes in the 3D matrix of loaded data from a song and
% returns the trial-averaged version of the data.
%
% Concepts covered: Function returning single output, averaging specified
% dimension of multidimensional array
%
% Input
% - X (required): The already-loaded data of the song to be averaged.
%
% Output
% - XAvg: The trial-averaged version of the data
%
% This function can operate on [space x time x trial] or [time x space x
% trial]. As long as the trial dimension is dimension 3, it does not matter
% what order the other dimensions are in. 

% Make sure the user entered exactly one input
assert(nargin == 1, 'This function requires one input (the loaded data from one song).')

% The input data matrix should have 3 dimensions
assert(ndims(X) == 3, 'The input data matrix should have 3 dimensions.')

% Average the data across trials. Trials are the 3rd dimension, so we
% average across dimension 3.
XAvg = mean(X, 3);