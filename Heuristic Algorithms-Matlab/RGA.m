%%
% clc;                                                           % To clear the command window.
% clear;                                                         % To clear the workspace.
% close All;                                                     % To close any opened figure.

% rng(2,'twister');                                              % Fixing the random number generator and seed.

%% Problem Settings

lb = [ 0.001     0.001   0.001];                                                    % Lower bound. 
ub = [  20         20      20];                                                    % Upper bound.
prob = @Objective_fcn;                                                      % Fitness function.

%% Algorithm parameters

Np = 40;                                                        % Population size.
T  = 50;                                                         % Number of iterations.
etac = 100;                                                      % Distribution index for crossover.
etam = 100;                                                      % Distribution index for mutation.
Pc = 0.8;                                                         % CrossOver probability.
Pm = 0.2;                                                         % Mutation probability.

%% Genetic Algorithm

Nrun = 20;
for run = 1: Nrun
f = NaN(Np,1);                                                 % Vector to store the fitness function value of the population.
OffspringObj = NaN(Np,1);                                      % Vector to store the fitness function value of the offspring.
D = length(lb);                                                % Determining the number of decision variables in the problem.
P = repmat(lb,Np,1)+repmat((ub-lb),Np,1).*rand(Np,D);          % Generation of the initial population.

for p = 1:Np                   
    f(p) = prob(P(p,:));                                       % Evaluating the fitness function of the initial population.
end

%% Iteration Loop

for t = 1:T
    
    %% Tournament Selection
    MatingPool = TournamentSelection(f,Np);                    % Performing tournament to select generation fittest.
    Parent = P(MatingPool,:);                                  % Selecting parent solution.
    
    %% CrossOver Operation
    offspring = CrossOverSBX(Parent,Pc,etac,lb,ub);
    
    %% Mutation Operation
    offspring = MutationPoly(offspring,Pm,etam,lb,ub);
    
    for j = 1:Np
        OffspringObj(j) = prob(offspring(j,:));                 % Evaluating the fitness of the offspring.
    end
    
    CombinedPopulation = [P;offspring];                        
    [f,ind] = sort([f;OffspringObj]);                           % mu+lambda selection strategy.
 
    f = f(1:Np);
    P = CombinedPopulation(ind(1:Np),:);
    
    
    % In loop results:
    [bestfitness,ind] = min(f);
    bestsol = P(ind,:);
    
  display(['Iteration: ', num2str(t)]);
  display(['RGA-Solution : ', num2str(bestsol)]);
  display(['RGA-Cost: '     , num2str(bestfitness)]);
  
  ConvergenceGA.iteration(t) = t;
  ConvergenceGA.ITAE(t) = bestfitness;

     
    
end

additional1(run,:) = [bestsol,bestfitness];
additional2(:,run) = (ConvergenceGA.ITAE)';

end


