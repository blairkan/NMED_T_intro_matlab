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
assert(~isempty(which('ccc')), 'Make sure the BKanMatEEGToolbox repo is in your path.')

% NOTE: The data files should also be in your path already.

% Let's say we want to work with the data from song 25. 
songUse = 25;

% Load the data from that song
X = loadOneFile(25); % Will be a 3D [time x space x trial] matrix


