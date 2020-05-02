%Reaction Diffusion Main
clear; close all; clc;
%% Executive Control
%Problem Type
    str.EquationType='Gray-Scott(Pearson)';%'FitzHugh-Nagumo (Murray)';% Gray-Scott or FitzHugh-Nagumo
    str.paramSet='Culture';%Define different parameter sets for different observations
    %str.initSet='Center';
%Numerical Solvers
    str.LaplacianSolver=@(uOld,str)dLaplacian_CenterDiff(uOld,str);
    str.ODESolver=@(uOld,vOld,uDiffusion,vDiffusion,str)ForwardEuler(uOld,vOld,uDiffusion,vDiffusion,str);
%PlotSettings
    str.movie.makeMovie='yes';
%% Set up Problem
    %Load Parameters
        str=defineStr(str);
    %Define Latice and Intial Conditions
        str.init=getInits(str);
%% Solve Problem
    str.sol=solve2S2DReactionDiffusion(str);
%% Plot Problem
    PlotSolution(str)
