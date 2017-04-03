% Return probability of the truss buckling given the tensions
function willbuckle=buckling_probability(T,E)

willbuckle=0;
threshold=465.326*E(:,3).^-1.55;
for i=1:length(E)
    if T(i,1) < -threshold(i,1)
        willbuckle=1;
        break;
    end
end

end
