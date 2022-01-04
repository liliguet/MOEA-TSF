function [index] = KneeSearch(PopObj)
% Calculate the fitness of each solution
% K: index of knee solution; index of E: points around knee M)
% size: K =1, E = M, extreme = M (2M+1)

%------------------------------- Copyright --------------------------------
% Copyright (c) 2021 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% This function is written by Li Li

    [N,M]  = size(PopObj); %N  No. of solutions, M No. of Objectives
    
    %% Find extreme points
    
    Zmin = min(PopObj,[],1); % Identify the ideal point
    % Identify the extreme points
    W = zeros(M) + 1e-6;
    W(logical(eye(M))) = 1;
    ASF = zeros(N,M);
    for i = 1 : M
        ASF(:,i) = max((PopObj-repmat(Zmin,N,1))./repmat(W(i,:),N,1),[],2);
    end
    [~,extreme] = min(ASF,[],1); %'extreme' is the extreme solutions
   
    
   %% Normalization
     % Calculate the intercepts
    Hyperplane = PopObj(extreme,:)\ones(M,1); % linear equation X=A\B???A*X=B???hyperplane is the solution of linear equation PopObj(extreme,:)x Hyperplane = ones(M,1)
    a = (1./Hyperplane)';
    if any(isnan(a))
        a = max(PopObj,[],1);
    end
    % Normalization
    PopObj = (PopObj-repmat(Zmin,N,1))./repmat(a-Zmin,N,1);
    
    
    %% Find knee solution K
    for k = 1:N
        iTSF = zeros(1,N);
        for l = 1:N
            if(k==l)
                continue;
            else
                iTSF(l) = sum(max((PopObj(k,:)-PopObj(l,:)),0));
            end
        end
        TSF(k)=sum(iTSF(:));
    end
    [~,Rank_TSF] = min(TSF); % Rank_TSF index of knee
    
    K = PopObj(Rank_TSF,:);
    
    
    
    
 
    
    
   
    %% Find M solutions around the knee point
    %Zmin = min(PopObj,[],1); % Identify the ideal point
    for i = 1 : M
        ASF_k(:,i) = max((PopObj-repmat(Zmin,N,1))./repmat(K,N,1),[],2);% w_nad = Onad向量 我要替换OK向量
    end
    [~,Rank_E]   = sort(ASF_k); % asf(OK)升序排列，要取前M个 Rank_E index of E
    E = PopObj(Rank_E(1:M),:); %取前M个ASF值最小的个体
    
    %index = [Rank_E(1:(2*M+1)), extreme]; %2M+1 个knee m个极值
    index = [Rank_E(1:(M^2)), extreme]; %m^2个knee m个极值
    %index = [Rank_TSF, Rank_E(1:M), extreme];
  %E_extreme = PopObj(extreme,:);

end