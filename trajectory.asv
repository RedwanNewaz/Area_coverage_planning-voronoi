function [traj,l]=trajectory(goal,robot,map,rois)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
edge=[robot,goal];
dist=edgeLength(edge);
traj=edgeToPolyline(edge, round(dist));
traj=unique(round(traj),'rows');
% rois
ind=1;
for t=traj'
b = isPointInEllipse(t', rois');
l=find(b==1);
if(l)
    'undefined err in trajectory.m'
    l=l-1;
    break;
end
ind=ind+1;
end
traj=traj(1:ind,:);

end

