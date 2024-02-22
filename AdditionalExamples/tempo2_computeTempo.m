% tempo2_computeTempo.m
% --------------------------
% Blair - Jan 26, 2017
%
% Adapted from  cogMIR2014_beatMeas.m - Blair, July 2014
% Adapted from engagement1_1_controlStimuli.m, April 8, 2014

clear all; close all; clc

%%%%%%%%%%%%%%%%%%%%%% Edit %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename - no .wav
fn = 'CantYouSee';

% Set full path of input and output directories
inDir = '';
outDir = '';

% Add a path to LabROSA tempo2 and beat2 functions
addpath(genpath(''));

% Remove path to EEGLAB if you have it
rmpath(genpath(''));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(inDir)
[x, fs] = audioread([fn '.wav']);

% Tempo is in BPM
t = tempo2(x, fs); % t is [slow fast prob(slow)]
t_bpm = t(1);
t_hz = t_bpm / 60;
t_spb = 1 / t_hz;

% Beats are in SECONDS
b = beat2(x, fs, t(1)); % This sets target tempo as the slower tempo


%%
clc
disp('Tempo (slower) ' )
disp('-----------------')
disp(['bpm: ' num2str(t_bpm)])
disp(['Hz: ' num2str(t_hz)])
disp(['Seconds per beat: ' num2str(t_spb)])
disp(['Probability of slower tempo: ' num2str(t(3))])

%% Measure and perceptual beat

meas = b(1:4:length(b));

dm = mkblips(meas,fs,length(x));
db = mkblips(b, fs, length(x));

%% Play audio with measure or beat blips overlaid
seq_blip = db;  %%% dm or db
soundsc(x + seq_blip, fs)

% type "clear sound" to stop playing the sound

%% Compute inter-beat intervals

% This is the vector of inter-beat intervals (seconds per beat)
b_ioi_spb = b(2:end) - b(1:(end-1)); 

% Here's the MAGNITUDE by which each beat IOI deviates from
% the beat IOI corresponding to the global tempo
b_ioi_dev_spb = abs(b_ioi_spb - t_spb);

% Here's the PERCENT by which each beat IOI deviates from the 
% global tempo IOI
b_ioi_percentDev_spb = b_ioi_dev_spb ./ t_spb * 100;

% Here's the percent of beat IOIs that deviate from the global tempo IOI by
% (strictly) more than 10%
percentBeatIOIsTenPercent = sum(b_ioi_percentDev_spb > 10) / numel(b_ioi_percentDev_spb) * 100;

disp(['Percentage of beat-to-beat IOIs that deviate from global tempo IOI'])
disp(['by more than 10% of the global tempo IOI: ' num2str(percentBeatIOIsTenPercent)])

%% Write out output

cd(outDir)
save([fn '.mat'], 't*', 'b*', 'fn', 'percent*')