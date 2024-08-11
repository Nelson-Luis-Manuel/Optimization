clc
clear 
close all


% rng(2,'twister')

FITNESSFCN = @Objective_fcn;

lb = [0.001 0.001 0.001];
ub = [20 20 20];

NPop = 40;
T = 50;
Nrun = 20;

for run = 1:Nrun
    
[X,FVAL,BestFVALIter] = SanitizedTLBO(FITNESSFCN,lb,ub,T,NPop);

 display(['The minimum point is ', num2str(X)])
 display(['The fitness function value at the mimimum point is ', num2str(FVAL)])
 
additional1(run,:) = [X,FVAL];
additional2(:,run) = BestFVALIter;
 
end
