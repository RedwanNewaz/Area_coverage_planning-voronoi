function  partition = vornoiPartition( bound,inputs )
% #[px,py] --> intesecting points
% # cc     --> box edges
% # hh     --> voronoi updated edges

% sampling points
if(nargin<2)
    disp('uniform sampling ...')
    [vx,vy,x,y]=area_partition();
    centroids=[x' y'];
else 
    disp('partition updated...')
    [vx,vy,x,y]=area_partition(inputs);
    centroids=inputs;
end
% partition
[ px,py,cc,hh ] = voronoiBox( vx,vy,bound );

% #check intesects on box edge
intersectingPoints=[px py];
ed= splitBoxEdges( cc,intersectingPoints );

% accumulate all the edges
hh=[hh;ed];
 
%find voronoi regions
partition=struct('center',[],'mX',[],'mY',[]);
i=1;
for tp=centroids'
    memberEdges  = NearestEdges( tp',hh );
    [PolyX,PolyY]=edgeSet2poly(memberEdges);
% update partition
%     partition(i).center=tp';
    partition(i).mX=PolyX;
    partition(i).mY=PolyY;
    [POLY, center]=partition2poly(partition(i));
     partition(i).center=center;
    i=i+1;
end

end


