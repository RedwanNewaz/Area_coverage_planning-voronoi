function [ map,robot ] = updateMap( parm,ind )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
map=parm.map;
traj=parm.traj;
for p=traj'
   map(p(2),p(1))=1; 
end
robot=traj(size(traj,1),:);
if(ind)
   ellip=parm.rois(ind,:);
   n=length(map);
   for x=1:n
       for y=1:n
            if(isPointInEllipse([x,y],ellip))
               map(y,x)=1; 
            end
       end
   end
end
end

