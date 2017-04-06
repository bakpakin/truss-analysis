% Analyze truss
precision = 0.00001;
threshold = 0.5;
filename=input('Enter the filename: ', 's');
load(filename);

% Set things up for binary search
minFactor = 0;
maxFactor = 2;
maxLoad = 1;
maxFactorSet = 0;
E = c2edgelist(C,X,Y);
A = setupA(C,X,Y,Sx,Sy);
% Calculate matrix inverse only once
Ainv = inv(A);
T = [];
memberProbs = [];
L = L / sum(L);

% Binary search for load
while abs(maxFactor - minFactor) > precision
    maxLoad = (maxFactor + minFactor) / 2;
    Ltest = L * maxLoad;
    T = Ainv * Ltest;
    [memberProbs, failProb] = buckling_probability(T, E);
    if failProb > threshold
        % Decrease load
        maxFactor = maxLoad;
        maxFactorSet = 1;
    else
        % Increase load
        if maxFactorSet
            minFactor = maxLoad;
        else
            maxFactor = maxFactor * 2;
        end
    end
end

% Caclulate cost and cost to load ratio
cost=calc_cost(C, E);
costRatio=calc_cr(cost, L);

% Padding
fprintf('\n');

% Print results
fprintf('Maximum Load: %.2f N\n', maxLoad);
fprintf('Cost: $%.2f \n', cost);
fprintf('Theoretical max load/cost ratio in N/$: %.4f \n', costRatio);

% Padding
fprintf('\n');

% Get broken member
breakcap=max(memberProbs);

% Print out all member forces and if in tension or compression
fprintf('Member forces in Newtons: \n');
for i=1:(length(T)-3)
    didbreakstring = '';
    if memberProbs(i, 1) == breakcap
        didbreakstring = '(broken member)';
    end
    if T(i,1)<0
        sense='C';
    end
    if T(i,1)>0
        sense='T';   
    end
    if T(i,1)==0
        sense='N';
    end
    fprintf('m%d:\t%3.3f\t(%s)\tlength: %2.3f\tbreakage prob.: %1.3f %s\n',i, abs(T(i,1)), sense, E(i, 3), memberProbs(i, 1), didbreakstring);
end

% Padding
fprintf('\n');

% Render truss
render_truss(C, X, Y, T / (maxLoad * 2));
