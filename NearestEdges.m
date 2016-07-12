function  memberEdges  = NearestEdges( point,edgeSet )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rmen=[];
memberEdges=[];
pointErr=sum(size(point)-[1 2]);
if(pointErr)
   error('point error')
    return ;
end

edgeSet=duplicateEdgeRemove(1,edgeSet);

for e=edgeSet'
   cp= edgeCenter(e');
   ref=[point,cp];
   res=MemberEdge(ref,edgeSet);
   rmen=[rmen;res];
   if(res<1)
       memberEdges=[memberEdges;e'];
   end
end



if(isempty(memberEdges)||pointErr)
  visulization.drawEdgeSet(edgeSet);
  error('NearestEdge:memberEdges is empty... ') ;   
end

end

function point=edgeCenter(e)
    [p1, p2]=edge2point(e);
    point=(p1+p2)./2;
end

function count=MemberEdge(ref,edgeSet)
% # at least 1 (itself)
% # more than 1 is not a member
count=-1;
for e=edgeSet'
    point=intersectEdges(ref,e');
   if (~isnan(point))
       count=count+1;
   end
   if count>0
       break;
   end
end

end

function edgeSet=duplicateEdgeRemove(count, edgeSet)

edge=edgeSet(count,:);
n=size(edgeSet,1);
[p1,p2]=edge2point(edge);
newEdge=[p2,p1];
B = repmat(newEdge,n,1);
C=B-edgeSet;
indexZero=zeroElement(C);
    if(indexZero)
        edgeSet(indexZero,:)=[];
    end
%     termination condition
    if(count<n)
        edgeSet=duplicateEdgeRemove(count+1, edgeSet);
    end

end


function index=zeroElement(C)
sumC=sum(abs(C),2);
result=find(sumC==0);
if(result)
   index=result;
else
    index=0;
end
    
end


function [p1,p2]=edge2point(e)
    p1=e(1,1:2);
    p2=e(1,3:4);
end


