% Return probability of the truss buckling given the tensions
function [perMember, total] = buckling_probability(T,E)

% custom sigmoid function
function g = sigmoid(x, a, c)
    if isscalar(a)
        a = repmat(a, size(x));
    end
    if isscalar(c)
        c = repmat(c, size(x));
    end
    g = 1 ./ (1 + exp(a .* (x - c)));
end

threshold = -465.326 * E(:,3) .^ -1.55;
% Drop the support forces
memberTensions = T(1:length(T) - 3, :);
% Use the sigmoid function to calculate probability of buckling
perMember = sigmoid(memberTensions, 3, threshold);
% The chance of the of the truss buckling is the inverse
% of the probability that all members do not buckle.
total = 1 - prod(1.-perMember);

end
