function offspring = CrossOverSBX(Parent,Pc,etac,lb,ub)

[Np,D] = size(Parent);                                                              % Determining the number of population.
indx = randperm(Np);                                                                % Permutating numbers from 1 to Np.
Parent = Parent(indx,:);                                                            % Randomly shuffling parent solution.
offspring = NaN(Np,D);                                                              % Matrix to store offspring solution.
 
for i = 1:2:Np                                                                      % Selecting parents in pair for crossOver.
    
   r=rand;                                                                          % Generating random number to decide if the crossover is going to occur.
   
   if r < Pc                                                                        % Checking for crossover probability.
       
       for j = 1:D
           
            r = rand;                                                               % Generating random number to determine u.
           
           if r <= 0.5
               
               beta = (2*r)^(1/(etac+1));                                           % Calculating beta value.
           else
               beta = (1/(2*(1-r)))^(1/(etac+1));                                   % Calculating beta value.
           end
           
           offspring(i,j) = 0.5*(((1+beta)*Parent(i,j))+(1-beta)*Parent(i+1,j));    % Generating offspring.
           offspring(i+1,j) = 0.5*(((1-beta)*Parent(i,j))+(1+beta)*Parent(i+1,j));  % Generating offspring.
       end
       
        offspring(i,:) = max(offspring(i,:),lb);                                    % Bounding the generated offspring to the lower bound.
        offspring(i+1,:) = max(offspring(i+1,:),lb);                                % Bounding the generated offspring to the lower bound.
        
        offspring(i,:)= min(offspring(i,:),ub);                                     % Bounding the generated offspring to the upper bound.
        offspring(i+1,:)= min(offspring(i+1,:),ub);                                 % Bounding the generated offspring to the upper bound.
   
   else
       
     offspring(i,:) = Parent(i,:);                                                  % Copying the first parent solution as offspring.
     offspring(i+1,:) = Parent(i+1,:);                                              % Copying the second parent solution as offspring.
       
   end

end