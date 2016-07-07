clear all;clc;clf;
addpath dataSet voronoi functions
load(sprintf('bestEllipse%d',1))
%# simulation parameters
robot=[1 1];
rois=bestEllipse;
findROIs=[];
step=1;
% # generate random voronoi partition
subplot(2,3,step)
 [vx,vy,x,y]=area_partition();
plot(x,y,'r+',vx,vy,'b-')
hold on

subplot(2,3,step+1)
for c=1:length(vx)
   hh(c,:)=createEdge([vx(1,c), vy(1,c)],[vx(2,c), vy(2,c)]);
end

for h=hh'
   drawEdge(h');
   hold on    
end
bound=[1 50 1 50];
axis(bound)

[mm nn]=meshgrid([1 50],[50 1]);
c1=cat(2,mm',nn');
c2=cat(2,mm,nn);
cc=[c1;c2];

px=[];py=[];
for h=hh'
   for c=cc'
       point = intersectEdges(h', c');
       if (~isnan(point))
           %update that edge 
           px=[px;point(1)];
           py=[py;point(2)];
           %find cycle in order to find voronoi region
       end
   end
end
plot(px,py,'r+')
drawBox(bound)




%%

centroids=[x' y'];
% find the nearest centroid
centroid_mask=[];
ind=emin(centroids ,robot,centroid_mask );
centroid_mask=[centroid_mask;ind];

while (step<3)
% update windows
subplot(2,3,step+1)
%connect the centroid 
edge=createEdge(robot, [x(ind), y(ind)])
drawEdge(x(ind), y(ind), robot(1), robot(2));
% find intesection with any ellipse
candidateROIs  = found_roi( rois,edge );
%draw candidate rois
for ii=candidateROIs
    hold on
    drawEllipse(rois(ii,:)); 
end
%update area parition 
findROIs=[findROIs;rois(candidateROIs,:)];
rois(candidateROIs,:)
[vx,vy,x,y]=area_partition(findROIs);
%update centroids
centroids=[x y]
%update rois
rois(candidateROIs,:)=[];
%update robot position 
robot=[13.3243    6.6890]
step=step+1;

plot(x,y,'r+',vx,vy,'b-')
%move to next candidate
ind=3;
end