% this script reads an input file with information about a possible truss
% design, gives the user an opportunity to optimize the design,
% calculates the forces on each member of the truss, and the hypothetical
% cost of building the truss

filename=input('Enter the filename: ', 's'); %user needs to specify input name because there are several potential designs
load(filename);% loads connection, support, x,y location and load vectors for the truss


%set up the matrices we need for calculations
E=c2edgelist(C,X,Y); %creates edgelist with columns listing first and second joint, length of member, number of rows is num members
A=setupA(C,X,Y,Sx,Sy);

%calculate T and compare to class fit to see if anything will buckle
T=inv(A)*L;%T is a column vector number of rows is number of members+support forces
willbuckle=buckling_probability(T,E); %returns 1 or 0
%need something to calculate uncertainty about buckling and specify which
%member buckles

%calculate costs
cost=calc_cost(C, E); %cost depends on the lengths of all the straws, also how many gusset plates (that info is in C)
costratio=calc_cr(cost, L); % calculates the max load/cost ratio

%output
resultsout(T,L, cost,costratio) % function to display the forces on each member, truss cost and load/cost ratio
