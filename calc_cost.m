function out=calc_cost(C,E)
[j,m]=size(C);
out=10*j+sum(E(:,3));
end
