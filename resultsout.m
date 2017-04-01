function resultsout(T,L, cost,costratio)
fprintf('\nEK301, Section C1, Group: Ravi Patel, Leah Pillsbury,Calvin Rose, Shivani Singh \n\n')
for i=1:size(L) %loop to get trussload as a scalar rather than imbedded in the load vector
    if L(i,1)~=0
        trussload=L(i,1);
    end
end
fprintf('Load: %.2f N \n',trussload)

%print out all member forces and if in tension or compression
fprintf('Member forces in Newtons: \n') 
for i=1:(size(T)-3)
    if T(i,1)<0
        sense='C';
    end
    if T(i,1)>0
        sense='T';   
    end
    if T(i,1)==0
        sense='N';
    end
    fprintf('m%d: %.3f (%s) \n',i, abs(T(i,1)), sense)
end

%print out reaction forces
fprintf('Reaction forces in Newtons: \n')
counter=1;
for i=i+1:size(T)
    if counter==1
        fprintf('Sx1: %.2f \n', T(i,1))
    else
        fprintf('Sy%d: %.2f \n', counter-1,T(i,1))
    end
    counter=counter+1;
end

%display cost of truss
fprintf('Cost of truss: $%.2f \n',cost)
fprintf('Theoretical max load/cost ratio in N/$: %.4f \n', costratio)
end