% Analyzes a truss to find out at which load it will break.
% C, X, Y, Sx, and Sy are all of the passed in parameters,
% L is the base load - for easiest use, pass in a One Hot column vector (base
% load of one newton). precision determines how acurate the final load should
% be. Threshold is what probability of success (not breaking) to require.
function [loadFactor, cost, costRatio] = analyze_truss(C, X, Y, Sx, Sy, L, precision, threshold)

% Set things up for binary search
minFactor = 0;
maxFactor = 2;
loadFactor = 1;
maxFactorSet = 1;
E = c2edgelist(C,X,Y);
A = setupA(C,X,Y,Sx,Sy);
% Calculate matrix inverse only once
Ainv = inv(A);

% Binary search for load
while abs(maxFactor - minFactor) > precision
    loadFactor = (maxFactor + minFactor) / 2;
    Ltest = L * loadFactor;
    T = Ainv * Ltest;
    failProb = buckling_probability(T, E);
    if failProb > threshold
        % Decrease load
        maxFactor = loadFactor;
        maxFactorSet = 1;
    else
        % Increase load
        if maxFactorSet
            minFactor = loadFactor;
        else
            maxFactor = maxFactor * 2;
        end
    end
end

% Caclulate cost and cost to load ratio
cost=calc_cost(C, E);
costRatio=calc_cr(cost, L);

end
