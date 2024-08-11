%
% Copyright (c) 2016, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.

% clc;
% clear;
% close all;
tic;
%% Problem Definiton

problem.CostFunction = @Objective_fcn;  % Cost Function
problem.nVar = 3;      % Number of Unknown (Decision) Variables
problem.VarMin = 0.001;   % Lower Bound of Decision Variables
problem.VarMax =  20;   % Upper Bound of Decision Variables

%% Parameters of PSO

% Constriction Coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

params.MaxIt = 50;          % Maximum Number of Iterations
params.nPop = 40;           % Population Size (Swarm Size)
params.w = chi;             % Intertia Coefficient
params.wdamp = 1;           % Damping Ratio of Inertia Coefficient
params.c1 = chi*phi1;       % Personal Acceleration Coefficient
params.c2 = chi*phi2;       % Social Acceleration Coefficient
params.ShowIterInfo = true; % Flag for Showing Iteration Informatin


cc1 = chi*phi1;
cc2 = chi*phi2;
ww = chi;
%% Calling PSO
Nrun = 20;

for run = 1:Nrun
%out = PSO(problem, params);
out = PSO(problem, params);

BestSol(run,:) = [out.BestSol.Position,0];
BestSol(run,4) = out.BestSol.Cost;
BestCosts(:,run) = out.BestCosts;

end

toc;
%% Results

%figure;
% plot(BestCosts, 'LineWidth', 2);
% semilogy(BestCosts, 'LineWidth', 2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;