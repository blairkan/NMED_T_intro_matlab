function XCell = loadMultipleFiles(filesToUse)
% XCell = loadMultipleFiles(filesTouse)
% -------------------------------
% Blair Kaneshiro - Feb 2024
%
% This function loads multiple ready-to-use files of the NMED-T dataset. It
% does the following for each file: 
% - Loads the file
% - DC corrects each trial
% - Permutes the data dimensions from [space x time x trial] to [time x
%   space x trial]
% - Appends the resulting 3D matrix as an element of a {10 x 1} cell array.
%
% Concepts covered: Function returning one output, nargin, assert, length,
% cell array, 'for' loop.
%
% Input: 
% - filesToUse (optional): Specification of which trials to load and 
%   aggregate. Inputs entered must be in the range of 21 to 30 inclusive. 
%   Examples: 22, 21:24, [22 25 27]. If the input is missing or empty, 
%   the function will load all 10 files. The directory containing the files 
%   is assumed to already be in the user's path.
%
% Output
% - XCell: {nFiles x 1} cell array containing the sensor-space specified 
%   to be loaded.
%
% Example function call:
%   XX = loadMultipleFiles([21 22]);
%       XX = 2 x 1 cell array
%       {34795×125×20 double}
%       {33891×125×20 double}
%
% See also: loadOneFile

% Set which files to work with
if nargin == 0 || isempty(filesToUse)
    filesToUse = 21:30;
end

% Make sure all file numbers correspond to available files
assert(all(ismember(filesToUse, 21:30)), ...
    'All specified files must be in the range of 21 to 30 inclusive.')

nFiles = length(filesToUse);

% Initialize the cell array 
XCell = cell(nFiles, 1);

for i = 1:nFiles
    XCell{i} = loadOneFile(filesToUse(i));
end