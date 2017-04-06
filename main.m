% Analyze truss
precision = 0.00001;
filename=input('Enter the filename: ', 's');
load(filename);

% Set things up
E = c2edgelist(C,X,Y);
A = setupA(C,X,Y,Sx,Sy);
T = inv(A) * (L / sum(L));
T_ = T(1:length(T) - 3,:);

% Regressions from class data
threshold = -465.326 * E(:,3) .^ -1.559;
uncertainty = 302.4 ./ E(:,3) .^ 2.56;

% Get maximum load
bucklingPoints = threshold ./ T_;
% Replace negatives with Infinity
bucklingPoints(bucklingPoints<0) = 0/0;
maxLoad = min(bucklingPoints);
T = T * maxLoad;

% Caclulate cost and cost to load ratio
cost=calc_cost(C, E);
costRatio=calc_cr(cost, maxLoad);

% Padding
fprintf('\n');

% Print results
fprintf('Maximum Load: %.2f N\n', maxLoad);
fprintf('Cost: $%.2f \n', cost);
fprintf('Theoretical max load/cost ratio in N/$: %.4f \n', costRatio);

% Padding
fprintf('\n');

% Print out all member forces and if in tension or compression
fprintf('Member forces in Newtons: \n');
for i=1:(length(T)-3)
    didbreakstring = '';
    if bucklingPoints(i, 1) == maxLoad
        didbreakstring = '(crticial member)';
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
    fprintf('m%d:\t%3.3f\t(%s)\tlength: %2.3f\tthreshold: %2.3f\tuncertainty: +-%2.3f %s\n',i, abs(T(i,1)), sense, E(i, 3), -threshold(i, 1), uncertainty(i, 1), didbreakstring);
end

% Padding
fprintf('\n');

% Render truss
render_truss(C, X, Y, T / (maxLoad * 2));
