function [costratio] = calc_cr(cost, L) %this function calculates the maximum load to cost ratio

costratio = sum(L)/cost; %as given in manual, load-to-cost ratio is ratio of max load to cost of truss 

end

