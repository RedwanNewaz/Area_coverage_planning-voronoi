function [ edges ] = splitBoxEdges( boxEdges,interSects )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
c=reshape(boxEdges,[size(boxEdges,1)*2,2]);
cc=unique(c,'rows');
edges=[];
    for corner=cc'
        [DIST,J] = minDistancePoints(corner', interSects);
        edge=[corner'  interSects(J,:)];
        edges=[edges;edge];        
    end
%     #Add edge for points on same edge
    indexSet=point2edge(interSects,boxEdges);
     duplindex=repeatedIndex(indexSet);
    if (length(duplindex)>1)
        newEdge=[interSects(duplindex(1),:) interSects(duplindex(2),:)];
        edges=[edges;newEdge];
    end
    %     #Add edge for points on missing box edge
    for ii=1:length(indexSet)
        for jj=indexSet
        if(ii~=indexSet)            
            edges=[edges;boxEdges(ii,:)];
        end
        end        
    end
%     #remove duplicate index
    for kk=duplindex
        indexSet(kk)=[];
    end
%     find remainng edges
    for kI=indexSet
        restEdges=boxEdges(kI,:);
    end
%     
cis=edge2point(interSects,restEdges);
rc=1;
for ll=cis'
    p1=interSects(ll,:);
    p2=restEdges(rc,3:4);
    p3=restEdges(rc,1:2);
    edge1=[ p1 p2];
    edge2=[ p1 p3];
    edges=[edges;edge1;edge2];
    rc=rc+1;
end
    
 edges=unique(edges,'rows');   
    
end


function indexSet=point2edge(interSects,boxEdges)
indexSet=[];
for point=interSects'
    index=1;
    for edge=boxEdges'
        if(isPointOnEdge(point',edge'))
            indexSet=[indexSet;index];
        end
         index=index+1;
    end   
end
end

function duplindex=repeatedIndex(indexSet)
    [n, bin] = histc(indexSet, unique(indexSet));
    multiple = find(n > 1);
    duplindex    = find(ismember(bin, multiple));
end


function indexSet=edge2point(interSects,boxEdges)
indexSet=[];
for edge=boxEdges'
    index=1;
    for point=interSects'
        if(isPointOnEdge(point',edge'))
            indexSet=[indexSet;index];
        end
         index=index+1;
    end   
end
end