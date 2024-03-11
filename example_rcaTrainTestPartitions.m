% example_rcaTrainTestPartitions.m
% --------------------------------
% Blair Kaneshiro - Mar 2024
%
% This is an example script showing how the user can compute the RCA
% spatial filter on a training partition, and then apply the spatial filter
% to the test partition. This example uses 9 songs for training and 1 song
% for testing but can be extended to consider, e.g., leave-one-participant
% out or other train-test partitions. 
%
% Main function of interest (from 'rca' repo):
%   xRCA = rcaProject(xSensorSpace, spatialFilterW)

% Here are some common commands you may want to do when you are getting
% ready to perform an analysis: Clear variables from workspace, close all
% figures, and clear your console. 
clear all; close all; clc

% Let's also make sure a necessary git repo is in the path. If you need it,
% it's this one: https://github.com/blairkan/BKanMatEEGToolbox
assert(~isempty(which('ccc')), 'Make sure the ''BKanMatEEGToolbox'' repo is in your path.')

% Add the repo folder and sub-folders to the path
addpath(genpath(pwd))

% NOTE: The data files should also be in your path already.

% Load all of the song data into one cell array
X = loadMultipleFiles();

% X =
% 
%   10×1 cell array
% 
%     {34795×125×20 double}
%     {33891×125×20 double}
%     {34469×125×20 double}
%     {36797×125×20 double}
%     {36114×125×20 double}
%     {34478×125×20 double}
%     {36454×125×20 double}
%     {36513×125×20 double}
%     {36712×125×20 double}
%     {37221×125×20 double}

%% Partition training and testing data

% For this example, we'll use songs 1:9 for training and song 10 for
% testing.

trainIdx = 1:9;
testIdx = 10;

dataIn_train = X(trainIdx);

% dataIn_train =
% 
%   9×1 cell array
% 
%     {34795×125×20 double}
%     {33891×125×20 double}
%     {34469×125×20 double}
%     {36797×125×20 double}
%     {36114×125×20 double}
%     {34478×125×20 double}
%     {36454×125×20 double}
%     {36513×125×20 double}
%     {36712×125×20 double}

dataIn_test = X(testIdx);

% dataIn_test =
% 
%   1×1 cell array
% 
%     {37221×125×20 double}


%% Compute RCA

% In this section we'll spatially filter the data using Reliable Components
% Analysis (RCA). 
% - For now we'll only return the 1st (maximally reliable)
%   component, but you can return more by increasing the value of "nComp".
% - The function has an option to plot the data while it's running, but
%   we'll turn that off ("doPlot" variable) and plot it ourselves later.
% - Currently, the parallel pool ("parpool") should be disabled, but we
%   could turn it back on if needed.
% - As is, the function should take 2-4 minutes to run per song (and in
%   fact seems to run faster with the parpool disabled).

% First, make sure the "rca" repo is in the path:
% https://github.com/dmochow/rca
assert(~isempty(which('rcaProject')), 'Make sure the ''rca'' repo is in your path.')

% RCA parameters
nComp = 1; % How many components to return
nReg = 7; % Regularization parameter - probably don't need to change ever 

% Run RCA using a slightly modified version of the "rcaRun" function. The
% function we are calling is in the "HelperFiles" folder of this repo.
%
% Inputs are as follows:
% - X: The input data matrix. Can also be a cell array of matrices if you
%   want to compute RCA across multiple songs
% - nReg: Regularization parameter
% - nComp: How many components' worth of data to return
% - condRange: If inputting multiple conditions, which ones to run
% - subjRange: If inputting multiple subject matrices, which ones to run
% - show: Whether to plot the figure that comes with this function
% - locfile: If plotting a figure, need to specify the corresponding sensor
%   locations file
%
% Apologies for the confusing function name re. parpool. Will be addressed
% in a future code revision!
[dataOut_train,W,A,Rxx,Ryy,Rxy,dGen] = rcaRun125_parpoolAlready2021(...
    dataIn_train, nReg, nComp, [], [], 0, []);

%% Apply the spatial filter W to the testing data

dataOut_test = rcaProject(dataIn_test, W); 

%% Remove singleton dimensions in the output training and test data

for i = 1:numel(dataOut_train)
    dataOut_train{i} = squeeze(dataOut_train{i});
end

% dataOut_train =
% 
%   9×1 cell array
% 
%     {34795×20 double}
%     {33891×20 double}
%     {34469×20 double}
%     {36797×20 double}
%     {36114×20 double}
%     {34478×20 double}
%     {36454×20 double}
%     {36513×20 double}
%     {36712×20 double}

for i = 1:numel(dataOut_test)
    dataOut_test{i} = squeeze(dataOut_test{i});
end

% dataOut_test =
% 
%   1×1 cell array
% 
%     {37221×20 double}