function [ cornerPoint ] = minCorner( set,p1,p2 )
%set --> candidate set
%p1 -->compared point1
%p2 -->compared point2
     D=dist(set,p1)+dist(set,p2);
    [val,ind]=min(D);
    cornerPoint=set(ind,:);
end
function distance=dist(E,x)
    distance=sum((E-repmat(x,size(E,1),1)).^2,2);
end
