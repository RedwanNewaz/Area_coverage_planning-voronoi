clear all;clc;clf;
addpath dataSet voronoi functions
load(sprintf('bestEllipse%d',1))
%# simulation parameters
robot=[1 1];
rois=bestEllipse;
findROIs=[];
step=1;
bound=[1 50 1 50];
window=[-10 70 -10 70];
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


ed= splitBoxEdges( cc,intersectingPoints );
hh=[hh;ed];
for h=hh'
   drawEdge(h');
   hold on    
end
plot(px,py,'r+')
% drawBox(bound)
 axis(window)
 
%find voronoi regions
centroids=[x' y'];
[v,c] = voronoin(centroids);

unbounded = voronoiRegions( v,c,intersectingPoints );

% test point
subplot(2,3,step+2)
hold on    
partition=struct('center',[],'mX',[],'mY',[]);
i=1;
for tp=centroids'
drawPoint(tp');
memberEdges  = NearestEdges( tp',hh );
% for Q=memberEdges'
%    drawEdge(Q');
% end
i=i+1;

% update partition
partition(i).center=tp';
[PolyX,PolyY]=edgeSet2poly(memberEdges);
partition(i).mX=PolyX;
partition(i).mY=PolyY;
plot(PolyX,PolyY,'--r');
end
axis(window)




