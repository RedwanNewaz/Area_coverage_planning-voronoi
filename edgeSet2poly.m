
function [PolyX,PolyY]=edgeSet2poly(edgeSet)



Edges=sortEdge(edgeSet);
[FP,LP]=splitEdges(edgeSet,[],[],1);
PolyX=[FP(:,1)';LP(:,1)'];
PolyY=[FP(:,2)';LP(:,2)'];
end


function [p1,p2]=edge2point(e)
    p1=e(1,1:2);
    p2=e(1,3:4);
end

function [FP,LP]=splitEdges(edgeSet,FP,LP,count)
    [p1,p2]=edge2point(edgeSet(count,:));
    if(count<size(edgeSet,1))
        [FP,LP]=splitEdges(edgeSet,[FP;p1],[LP;p2],count+1);
    end
    FP=[FP;p1];
    LP=[LP;p2];

end

function Edges=sortEdge(edgeSet)

    e=edgeSet(1,:);
    [p1,p2]=edge2point(e);
    cost=distancePointEdge(p2, edgeSet);
    cost(1)=-inf;
    [r,I]=sort(cost);
    Edges=[];
    for ind=I
        Edges=[Edges;edgeSet(ind,:)];
    end

end