% Analyze a truss
filename=input('Enter the filename: ', 's');
load(filename);

% Find the maximum load and other values
[loadFactor, cost, costRatio] = analyze_truss(C, X, Y, Sx, Sy, L, 0.001, 0.5);

% Print results
fprintf('Maximum Load: %.2f N\n', sum(L) * loadFactor);
fprintf('Cost: $%.2f \n', cost);
fprintf('Theoretical max load/cost ratio in N/$: %.4f \n', costRatio);
