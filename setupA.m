% Creates the A matrix from the five given inputs.
function A = setupA(C, X, Y, Sx, Sy)

% Make distances
E = c2edgelist(C, X, Y);

% Creates a quandrant of A
function Q = makeQuadrant(W)
[crows, ccols] = size(C);
[rows, cols] = size(E);
Q = zeros(crows, ccols);
for n = 1:rows
    row = E(n,:);
    j1 = row(1, 1);
    j2 = row(1, 2);
    d = (W(1, j2) - W(1, j1)) / row(1, 3);
    % Set the values in the quadrant
    Q(j1, n) = d;
    Q(j2, n) = -d;
end
end

% Get the quadrants
q1 = makeQuadrant(X);
q2 = makeQuadrant(Y);

% Make A
A = [q1, Sx; q2, Sy];

end
