%Reaction Diffusion Main
clear; close all; clc;
%% Executive Control
%Problem Type
    str.EquationType='Gray-Scott(Pearson)';% Gray-Scott or FitzHugh-Nagumo
    str.paramSet='Squiggles';%Define different parameter sets for different observations
%PlotSettings
    str.movie.makeMovie='yes';
%% Set up Problem
    %Load Parameters
        str=defineStr(str);
    %Define Latice and Intial Conditions
        str.init=getInits(str);
%% Solve Problem
    str.sol=str.solver(str);
%% Plot Problem
    PlotSolution(str)
