% Return probability of the truss buckling given the tensions
function [perMember, total] = buckling_probability(T, E, threshold, uncertainty)

% Drop the support forces
memberTensions = T(1:length(T) - 3, :);

% custom member probability function
% Not currently using E or uncertanity
function g = memprob(x)
    g = zeros(length(x), 1);
    for i=1:length(x)
       if memberTensions(i, 1) < threshold(i, 1)
           g(i, 1) = 1;
       else
           g(i, 1) = 0;
       end
    end
end

% Use the memprob function to calculate probability of buckling
perMember = memprob(memberTensions);
% The chance of the of the truss buckling is the inverse
% of the probability that all members do not buckle.
total = 1 - prod(1.-perMember);

end
