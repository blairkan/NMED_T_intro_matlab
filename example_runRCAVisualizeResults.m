% example_runRCAVisualizeResults.m
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
assert(~isempty(which('ccc')), 'Make sure the ''BKanMatEEGToolbox'' repo is in your path.')

% Add the repo folder and sub-folders to the path
addpath(genpath(pwd))

% NOTE: The data files should also be in your path already.

% Let's say we want to work with the data from song 25. 
songUse = 26;

% Load the data from that song
X = loadOneFile(25); % Will be a 3D [time x space x trial] matrix

% Note: Can also load multiple files as follows:
% X = loadMultipleFiles();

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
[dataOut,W,A,Rxx,Ryy,Rxy,dGen] = rcaRun125_parpoolAlready2021(...
    X, nReg, nComp, [], [], 0, []);

%% Address singleton dimension of output data if applicable

% The size of the output data are time x component x trial, e.g.,
% dataOut      [36114 x 1 x 20] for Song 25. 
% If we compute only 1 component, there is a "singleton" dimension in the
% middle that will be annoying later on. We can get rid of it using the
% "squeeze" function.
if size(dataOut,2) == 1 
    dataOut = squeeze(dataOut); 
    disp(['Removed singleton dimension from RCA output data.'])
end

% In this case of returning only 1 component, dataOut is now a 2D matrix
% after squeezing!  
% dataOut      [36114 x 20] <-- time x trial matrix

%% Visualize output data

% We can visualize the spatial filter 
% 2nd function input is whether to plot the colorbar alongside
figure()
visualizeRCTopo125(A(:,1), 1)

% We could average the data across trials and plot the average
% The "2" here indicates that we want to average across the 2nd (trial)
% dimension.
dataOut_trialAverage = mean(dataOut, 2);

%%% We could plot the data in a few different ways
figure()

% Trial-averaged RC1 data: Time domain
subplot(3, 1, 1)
plotTrial_TD(dataOut_trialAverage)

% Trial-averaged RC1 data: Frequency domain
subplot(3, 1, 2)
plotTrial_FD(dataOut_trialAverage)

% Overlay single-trial RC1 data: Frequency domain
% In this case we're appropriating the plotTrial_FD function, but now the
% matrix columns are trials rather than electrodes. 
subplot(3, 1, 3)
plotTrial_FD(dataOut)

% Exercise for the user: Compare the 2nd and 3rd subplots. 
% - The 2nd subplot is both spatially filtered and trial averaged. Do you 
%   see any clear spectral peaks at a multliple or divisor of 2x related 
%   to your song's tempo? 
% - Given what you see in the 2nd plot, do you see any evidence of the same
%   peak frequency/frequencies in the single-trial data? 
% - How does the noise floor of the 2nd plot compare to the noise floor of
%   the 3rd plot?