% example_variousMatlab.m
% -------------------------
% Blair Kaneshiro - Feb 2024
%
% This script contains various Matlab examples that might be useful for
% getting oriented
%
% How to use: This code is in a script and intended to be run through while
% reading the code and comments. The code is organized in different
% sections which are dividided by '%%'. You can click into a section of
% your choice and run it by clicking the "Run Section" button in the Editor
% tab, above; or via keyboard as command+enter on Mac or control+enter on
% Windows. 

%% Workspace basics

%%% The "clear" command clears all variables in your workspace
clear

% You can also clear selected variables by typing them after "clear"
a = 1; b = 2; c = 3; % Create a few variables
clear a b 

% If you have a lot of variables and want to clear most of them, you can
% also use "clearvars".
a = 1; b = 2; c = 3; d = 4; e = 5; f = 6; g = 7; h = 8; 
clearvars -except h

% As shown above, you can enter multiple commands on the same line as long
% as they are separated by semicolons. 

%%% More generally, putting a semicolon at the end of a line of code 
%%% prevents the assigned/updated value from printing in the Command 
%%% Window when the code is executed. When working with large matrices 
%%% (like the EEG data), be sure to always put a semicolon at the end to 
%%% avoid long print times!

% Matrix of random integers will take a while to print!
a = randi(100, [125 34779])

%%% The "close" command will close open figure windows

% Close all open windows
close all % Close all open windows

% Close selected windows
figure(1); figure(2); figure(3)
close(2)
% Figure 1 and Figure 3 will remain open

%%% The "clc" command clears the command window
clc

%%% Use "addpath" to add files and directories to your Matlab path (Matlab
%%% will only be able to work with files that are in the path or whose full
%%% path+filename are specified). If you are adding a folder of files that
%%% has sub-folders, also use "genpath" to recursively add all of the
%%% sub-folders of the specified path.

% This is a fake example but you can customize with your own path
addpath(genpath('/Users/Username/Codebase/DirectoryToBeAdded'))

%% Variable size

clear all; close all; clc

%%% You can use "whos" to view all the current variables in the workspace
a = 1; b = randi(100, [1000,1]); c = 'blah!'; d = [2 3 4; 4 5 6];
whos

%%% The "size" command returns the size of each dimension of a variable
dSize = size(d); % [2 3] since it has 2 rows and 3 columns
dNColumns = size(d, 2); % Return just the number of columns (size of dim 2)
dNDims = ndims(d); % How many dimensions does the variable "d" have?
dLength = length(d); % Size of the longest/largest dimension

%% Creating vectors

clear; close all; clc

%%% There are multiple ways to create vectors in Matlab

% Write out specific values
a = [1 2 3 7 8 9];

% Use the colon operator to specify a range of values
b = 1:5; % [1 2 3 4 5]

% Give it a third argument; the middle argument will specify "in steps of"
% that the vector advances
c = 2:4:13; % [2 6 10]

% If you want a vector that decreases in value, you must write in the
% negative decrement as the 2nd of 3 input arguments
d1 = 10:1;  % won't work! will return empty vector
d2 = 10:-1:1; % [10 9 8 7 6 5 4 3 2 1]

% The "linspace" command linspace(l, m, n) creates a vector of n points
% between l and m.
e = linspace(30, 40, 15); % 30 and 40 are included as values
help linspace % Look up function help

%%% Switch between row and column vectors

% You can use ' to transpose a row vector to a column vector and vice
% versa. ' also transposes matrices, e.g., a 2 x 4 matrix will turn into a
% 4 x 2 matrix.
f1 = 100:110; % Row vector
f2 = f1'; % Column vector

% Sometimes you need a variable to be a row or column vector regardless of
% whether it was already one. In this case you can use the colon operator
% to force a vector into column format.
g1 = [200:205]; % Row vector
g2 = g1(:); % Forces column vector regardless of original orientation
g3 = g1(:)'; % Forces row vector (transpose of column vector)

%%% Vector of strings: You can concatenate various string elements into a
%%% vector as well. In this case, the set of strings needs to be enclosed
%%% by square brackets.
str1 = 'This is a'; str2 = 'set of'; str3 = 'strings'; 
allStr = [str1 ' ' str2 ' ' str3 '!']; 

% You can let the string print to the console by leaving off the ;
allStr

% You can also more officially print it to the command window using the
% 'disp' function:
disp('Printing some things...')
disp([newline 'Starting a new paragraph first with the ''newline'' command.'])
disp(allStr)

%% Indexing elements of vectors and matrices

clear all; close all; clc

%%% Matlab indexing starts at 1. Index elements using parentheses.
a = 501:520; % Vector
a1 = a(5); % 5th element of a
a2 = a(1:3); % First 3 elements of a
a3 = a(end); % Last element of a
a4 = a(end-1:end); % Last 2 elements of a
a5 = a([1 5 6]); % Specific elements enclosed in square brackets

%%% For matrices or multidimentional arrays, index one dimension at a time
b = [1:5; 6:10; 11:15; 16:20]; % Create small matrix. ; separates rows.
% b =
% 
%      1     2     3     4     5
%      6     7     8     9    10
%     11    12    13    14    15
%     16    17    18    19    20

b1 = b(2, 5); % Row 2, column 5

% The colon operator makes another appearance as a way to index all
% elements of a given dimension. 
b2 = b(3, :); % Row 3, all columns
b3 = b(:, 4); % All rows, column 4