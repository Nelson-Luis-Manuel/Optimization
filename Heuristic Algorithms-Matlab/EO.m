
%% Initialization Parameters:
Particles_no = 40;
Max_iter = 50;
fobj = @Objective_fcn;
Run_no = 20;
dim = 3;
lb = [0.001,0.001,0.001];
ub = [20, 20, 20];

%% Main Loop

for irun=1:Run_no
    
    Ceq1=zeros(1,dim);   Ceq1_fit=inf;
    Ceq2=zeros(1,dim);   Ceq2_fit=inf;
    Ceq3=zeros(1,dim);   Ceq3_fit=inf;
    Ceq4=zeros(1,dim);   Ceq4_fit=inf;
    
    C = EO_initialization(Particles_no,dim,ub,lb);
    
    Iter=0; V=1;
    
    a1=2;    %default a1=2
    a2=1;    %default a2=1
    GP=0.5;  %default GP=0.5
    
    while Iter<Max_iter
        
        for i=1:size(C,1)
            
            Flag4ub=C(i,:)>ub;
            Flag4lb=C(i,:)<lb;
            C(i,:)=(C(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
            
            fitness(i)=fobj(C(i,:));
            
            if fitness(i)<Ceq1_fit
                Ceq1_fit=fitness(i);  Ceq1=C(i,:);
            elseif fitness(i)>Ceq1_fit && fitness(i)<Ceq2_fit
                Ceq2_fit=fitness(i);  Ceq2=C(i,:);
            elseif fitness(i)>Ceq1_fit && fitness(i)>Ceq2_fit && fitness(i)<Ceq3_fit
                Ceq3_fit=fitness(i);  Ceq3=C(i,:);
            elseif fitness(i)>Ceq1_fit && fitness(i)>Ceq2_fit && fitness(i)>Ceq3_fit && fitness(i)<Ceq4_fit
                Ceq4_fit=fitness(i);  Ceq4=C(i,:);
                
            end
        end
        
        %---------------- Memory saving-------------------
        if Iter==0
            fit_old=fitness;  C_old=C;
        end
        
        for i=1:Particles_no
            if fit_old(i)<fitness(i)
                fitness(i)=fit_old(i); C(i,:)=C_old(i,:);
            end
        end
        
        C_old=C;  fit_old=fitness;
        %-------------------------------------------------
        
        Ceq_ave=(Ceq1+Ceq2+Ceq3+Ceq4)/4;                              % averaged candidate
        C_pool=[Ceq1; Ceq2; Ceq3; Ceq4; Ceq_ave];                     % Equilibrium pool
        
        
        t=(1-Iter/Max_iter)^(a2*Iter/Max_iter);                      % Eq (9)
        
        
        for i=1:Particles_no
            lambda=rand(1,dim);                                % lambda in Eq(11)
            r=rand(1,dim);                                     % r in Eq(11)
%             Ceq = Ceq1;
            Ceq=C_pool(randi(size(C_pool,1)),:);               % random selection of one candidate from the pool
            F=a1*sign(r-0.5).*(exp(-lambda.*t)-1);             % Eq(11)
            r1=rand(); r2=rand();                              % r1 and r2 in Eq(15)
            GCP=0.5*r1*ones(1,dim)*(r2>=GP);                   % Eq(15)
            G0=GCP.*(Ceq-lambda.*C(i,:));                      % Eq(14)
            G=G0.*F;                                           % Eq(13)
            C(i,:)=Ceq+(C(i,:)-Ceq).*F+(G./lambda*V).*(1-F);   % Eq(16)
        end
        
        display(['Iteration: ', num2str(Iter+1)]);
        display(['EO-Solution : ', num2str(Ceq1,8)]);
        display(['EO-Cost: '     , num2str(Ceq1_fit,8)]);
        
%         ConvergenceEO.iteration(Iter+1) = Iter+1;
        ConvergenceEO.ITAE(Iter+1) = Ceq1_fit;
        Iter = Iter+1;
      
    end
   
    
    Run_solutions(irun,:)= [Ceq1,Ceq1_fit];
    Run_iteration(:,irun)= (ConvergenceEO.ITAE)';
    
    
end
