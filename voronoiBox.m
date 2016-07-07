function [ px,py,ccE,ee ] = voronoiBox( vx,vy,bound )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
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
    px=[];py=[];
    updatedEdge=[];
    index=1;
    indexSet=[];
    for h=hh'
        
       for c=cc'
           point = intersectEdges(h', c');
           if (~isnan(point))
               %update that edge 
               px=[px;point(1)];
               py=[py;point(2)];
               %find cycle in order to find voronoi region
                updatedEdge=[updatedEdge;shortenEdge(cc,h',point)];
                indexSet=[indexSet;index];
           end
       end
%         updatedEdge=[updatedEdge;h'];
       index=index+1;
          
    end
    count=1;
    for jj=indexSet'
       hh(jj,:)= updatedEdge(count,:);
       count=count+1;
    end
end

function edge=shortenEdge(box,edge,point)
P1=edge(1:2);
P2=edge(3:4);
poly=[];
for edge=box'
    e=reshape(edge',[2 2]);
    poly=[poly;e];
end
if( isPointInPolygon(P1, poly))
   edge=[P1 point];
else
    edge=[point P2];    
end


end