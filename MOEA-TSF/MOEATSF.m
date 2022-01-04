classdef MOEATSF < ALGORITHM
% <multi/many> <real/binary/permutation>
% Pareto front shape estimation based evolutionary algorithm

%------------------------------- Reference --------------------------------
% L. Li, G. G. Yen, A. Sahoo, L. Chang, and T. Gu, On the estimation of
% pareto front and dimensional similarity in many-objective evolutionary
% algorithm, Information Sciences, 2021, 563: 375-400.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2021 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% This function is written by Li Li

	methods
        function main(Algorithm,Problem)
            %% Generate random population
            Population = Problem.Initialization();
            MatingPool = randi(Problem.N,1,Problem.N);
            %% Optimization
            while Algorithm.NotTerminated(Population)
                MatingPool = randi((2*Problem.M+1),1,(2*Problem.M+1));
                Offspring  = OperatorGA(Population(MatingPool));
                Population = EnvironmentalSelection([Population,Offspring]);
                
            end
        end
    end
end