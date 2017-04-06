filename=input('Enter the filename: ', 's');
load(filename);
L = L / sum(L);
E=c2edgelist(C,X,Y);
A=setupA(C,X,Y,Sx,Sy);
T=inv(A)*L;
threshold = 465.326 * (E(:,3) .^ -1.559);
T_ = T(1:length(T)-3,:);
memberMaxes = threshold ./ T_;
maxL = -min(memberMaxes);
cost=calc_cost(C, E);
render_truss(C, X, Y, memberMaxes / maxL);
resultsout(T * maxL, L * maxL, cost, maxL/cost)
