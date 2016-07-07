function [ bounded ] = voronoiRegions( v,c,boundAreaMask )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    count=1;
%     find unbounded points
    for i = 1:length(c) 
        if any(c{i}==1)   
            bounded(count).edge=[v(c{i},1),v(c{i},2)];
            count=count+1;
        end
    end
%     edges1=regions(boundAreaMask,bounded,1);
%     ue1=unique(edges1,'rows')
    
%     edges2=regions(boundAreaMask,bounded,0);
%     ue2=unique(edges2,'rows')
    
%     for ii=1:length(bounded)
%        fprintf('area %d \n',ii)
%         bounded(ii).edge
%     end
    
%     disp(inPoint1);
%     disp('segments')
%     disp(inPoint2);
    
     % find adjacent corner point
%     cornerPoint  = minCorner( cc,inPoint1,inPoint2 );


end


function [edges]=regions(intersectingPoints,unbounded,flag)
inPoint1=[];inPoint2=[];
for aa=1:length(unbounded)
    aaEdge=unbounded(aa).edge;
    ind=find(aaEdge==inf,1);
    if(ind<size(aaEdge,1))
       FstPoint=aaEdge(ind-1,:);
       SndPoint=aaEdge(ind+1,:);
    else
       FstPoint=aaEdge(ind-1,:);
       SndPoint=aaEdge(1,:);
    end
    %    find nearest intersect point
    taken=[];
    if(flag)
        ind=emin(intersectingPoints,FstPoint,taken);
    else
        ind=emax(intersectingPoints,FstPoint,taken);
    end
%     populate taken
    inPoint1=[inPoint1;intersectingPoints(ind,:)];
    taken=[taken;ind];
    %    find nearest intersect point
    if(flag)
        ind2=emin(intersectingPoints,SndPoint,taken);
    else
        ind2=emax(intersectingPoints,SndPoint,taken);
    end
    inPoint2=[inPoint2;intersectingPoints(ind2,:)];
    
        edges=[inPoint1,inPoint2];
   
end
end
