% Creates the A matrix from the five given inputs.
function A = setupA(C, X, Y, Sx, Sy)
    % Make distances
    E = c2edgelist(C, X, Y);
    % Get the quadrants
    q1 = makeQuadrant(X, E, C);
    q2 = makeQuadrant(Y, E, C);
    % Make A
    A = [q1, Sx; q2, Sy];
end

