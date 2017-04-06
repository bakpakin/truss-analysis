function render_truss(C, X, Y, normalizedTensions)

hold all;
cla();

E = c2edgelist(C, X, Y);
daspect([1 1 1]);
axis off;

% Plot each support
for i=1:length(E)
    color = zeros(1, 3);
    if normalizedTensions(i, 1) < 0
        % Compression
        color = [max(0, min(1, -normalizedTensions(i, 1))) 0 0];
    elseif normalizedTensions(i, 1) == 0
        % Neutral
        color = [1 1 0];
    else
        % Tension
        color = [0 0 1];
    end
    x1 = X(1, E(i, 1));
    x2 = X(1, E(i, 2));
    y1 = Y(1, E(i, 1));
    y2 = Y(1, E(i, 2));
    xc = (x1 + x2) / 2;
    yc = (y1 + y2) / 2;
    
    p = plot([x1, x2], [y1, y2], 'LineWidth', 3, 'Color', color);
    text(xc-1, yc+1, strcat('m', num2str(i)));
end

% Plot each joint
% Plot each support
for i=1:length(X)
    xc = X(1, i);
    yc = Y(1, i);
    text(xc-1, yc+1, strcat('j', num2str(i)));
end

end

