clear all;clc;clf;
addpath dataSet voronoi functions
load(sprintf('bestEllipse%d',1))
%# simulation parameters
robot=[1 1];
rois=bestEllipse;
findROIs=[];
step=1;
bound=[1 50 1 50];
% # generate random voronoi partition
subplot(2,3,step)
 [vx,vy,x,y]=area_partition();
plot(x,y,'r+',vx,vy,'b-')
hold on

subplot(2,3,step+1)
% #[px,py] --> intesecting points
% # cc     --> box edges
% # hh     --> voronoi updated edges
[ px,py,cc,hh ] = voronoiBox( vx,vy,bound );

% #check intesects on box edge
intersectingPoints=[px py];


ed= splitBoxEdges( cc,intersectingPoints )
hh=[hh;ed];
for h=hh'
   drawEdge(h');
   hold on    
end
plot(px,py,'r+')
% drawBox(bound)
 axis([-10 70 -10 70])
 
%find voronoi regions
centroids=[x' y'];
[v,c] = voronoin(centroids);

unbounded = voronoiRegions( v,c,intersectingPoints );




