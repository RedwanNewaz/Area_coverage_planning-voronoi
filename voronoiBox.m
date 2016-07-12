function [ px,py,ccE,ee ] = voronoiBox( vx,vy,bound )
%FUNCTIONS Summary 
% createSetEdges
% findBoxCorner
% findIntersctPoints
% shortenEdge
hh=createSetEdges(vx,vy);
ccE=findBoxCorner(bound);
[px,py,ee]=findIntersctPoints(hh,ccE);

end


function hh=createSetEdges(vx,vy)
    for c=1:length(vx)
       hh(c,:)=createEdge([vx(1,c), vy(1,c)],[vx(2,c), vy(2,c)]);
    end
end

function cc=findBoxCorner(bound)
    [mm nn]=meshgrid([bound(1) bound(2)],[bound(4) bound(3)]);  
    c1=cat(2,mm',nn');
    c2=cat(2,mm,nn);
    cc=[c1;c2];
end


function [px,py,hh]=findIntersctPoints(hh,cc)
% find intesection points
points=[];
for c=cc'
    intersect=intersectEdges(hh, c');
    [m,n]=find(~isnan(intersect));
     index=unique(m);
     points=[points;intersect(index,:)];
end
% get the matrix of intesected points
% p1    e1 e2 e3 e4 e5 e6 e7
% p2    e1 e2 e3 e4 e5 e6 e7
% p3    e1 e2 e3 e4 e5 e6 e7
% p4    e1 e2 e3 e4 e5 e6 e7
mat = isPointOnEdge(points, hh);

%    shorten edge(s)
inde=1;
for rows=mat'
   ndex=find(rows'==1); 
   hh(ndex,:)=shortenEdge(cc,hh(ndex,:),points(inde,:));
   inde=inde+1;
end
px=points(:,1);
py=points(:,2);


end


function edge=shortenEdge(box,edge,point)
P1=edge(1:2);
P2=edge(3:4);
cc=[];

for ee=box'
    e=reshape(ee',[2 2]);
    cc=[cc;e];
end

if( isPointInPolygon(P1, cc))
   edge=[P1 point];
else
    edge=[point P2];

end

end


