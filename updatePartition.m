function centroids=updatePartition(part,indxSet,rois)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
centroids=cell2mat({part(:).center}');
if(indxSet)    
acntr=rois(indxSet,1:2);
centroids=sortCandidate(acntr,centroids);
end
end

function centroids=sortCandidate(acntr,curr)
    taken=[];
    centroids=curr;
    for point=acntr'
        ind=emin(curr,point',taken);
        taken=[taken;ind];
        centroids(ind,:)=point';
    end

end

