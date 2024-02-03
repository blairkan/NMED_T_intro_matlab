function X0 = loadOneFile(songNumber)
% X = loadOneFile(songNumber)
% -----------------------------------
% Blair Kaneshiro - Feb 2024
%
% This function loads the data from the specified song, DC corrects each
% trial, and also permutes the dimensions from [space x time x trial] to
% [time x space x trial].
%
% Concepts covered: Function returning a variable, assert, nargin, string
% concatenation, file loading, try/catch, eval, 'for' loop.
%
% Input (required)
% - songNumber: The number of the song to load (e.g., 21)
%
% Output
% - The loaded song data. It will be a single 3D matrix whose dimensions
%   are [time x electrode x trial]
%
% Note that other variables in the input data file (e.g., fs, participant
% identifiers) are not returned by this function.

% Make sure the user entered exactly one input
assert(nargin == 1, 'This function requires one input (the song number).')

% Make sure the BKanMatEEGRepo is in the path
assert(~isempty(which('dcCorrect')), 'Make sure the BKanMatEEGToolbox repo is in your path.')

% Create the filename to be loaded
fnIn = ['song' num2str(songNumber) '_Imputed.mat'];

% Load the file
try
    load(fnIn);
catch
    error(['Could not load file ' fnIn '. Make sure the file is in your path.']);
end

% Assign the loaded data variable to the output variable
% The 'eval' function treats the string as if it was code typed by the
% user.
X0 = eval(['data' num2str(songNumber)]);

% DC Correct each trial of data
XDC = nan(size(X0)); % Initialize the matrix
for i = 1:size(X0, 3)
    XDC(:, :, i) = dcCorrect(X0(:, :, i));
end

% Permute the data dimensions
X = permute(XDC, [2 1 3]);