function render_truss(C, X, Y, T, bucklingProbs)

hold all;
cla();

E = c2edgelist(C, X, Y);
daspect([1 1 1]);
axis off;



% Plot each support
for i=1:length(E)
    color = zeros(1, 3);
    if T(i, 1) < 0
        % Compression
        color = [bucklingProbs(i, 1) 0 0];
    else
        % Tension
        color = [0 0 1];
    end
    p = plot([X(1, E(i, 1)), X(1, E(i, 2))],
        [Y(1, E(i, 1)), Y(1, E(i, 2))],
        'LineWidth', 3,
        'Color', color);

end

end

