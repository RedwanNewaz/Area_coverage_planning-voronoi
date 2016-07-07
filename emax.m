function [ ind ] = emax( E,x,taken )
%E --> candidate set
%x -->compared point
%taken --> previous data
 
    D=dist(E,x);
    for ii=1:length(taken)
    D(taken(ii))=D(taken(ii))-inf;
    end
    index=find(D==0,1);
    D(index)=inf;
    [val,ind]=max(D);
end
function distance=dist(E,x)
    distance=sum((E-repmat(x,size(E,1),1)).^2,2);
end

