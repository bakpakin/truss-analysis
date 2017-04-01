% Converts C to edge list and length
function E = c2edgelist(C, X, Y)
  [crows, ccols] = size(C);
  E = zeros(ccols, 3);
  for col = 1:ccols
    % Get the locations of the two joints
    joints = [];
    for row = 1:crows
      if C(row, col) ~= 0
        joints = [joints, row];
      end
    end
    % Write joints to edgelist
    j1 = joints(1, 1);
    j2 = joints(1, 2);
    E(col, 1) = j1;
    E(col, 2) = j2;
    % Calc distances
    dx = (X(1, j2) - X(1, j1));
    dy = (Y(1, j2) - Y(1, j1));
    distance = sqrt(dx * dx + dy * dy);
    E(col, 3) = distance;
  end
end
    
