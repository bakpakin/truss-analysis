% Analyze a truss
filename=input('Enter the filename: ', 's');
load(filename);

% Find the maximum load and other values
[loadFactor, cost, costRatio] = analyze_truss(C, X, Y, Sx, Sy, L, 0.0001, 0.9999);

% Print results
printf('Maximum Load: %.2f N\n', sum(L) * loadFactor);
printf('Cost: $%.2f\n', cost);
printf('Theoretical max load/cost ratio in N/$: %.4f\n', costRatio);
