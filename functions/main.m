clear all;clc;close all;

%fprintf('libraries\n')
addpath('@tree');
addpath('fit_ellipse')
addpath('code');


fprintf('Field parameters\n')
area_corner=[50 50];
robot=[1 1];
Field =field();
entropy_map=rand(size(Field));
initial_entropy=entropy(entropy_map)
step=0;
rectarea=[1 1; 50 1; 50 50; 1 50];
t=tree(rectarea);
area_points=[];
clc;
elliptical_sources=[];
while(step<19)
fprintf('lawn_mower path for area (%d,%d) robot(%d %d) \n',area_corner(1),area_corner(2),...
robot(1),robot(2) )
[path,source]=lawn_mower(area_corner,robot,Field);

path_view=[];
for i=1:size(path,1)
   if(entropy_map(path(i,2),path(i,1)))
       path_view=[path_view;path(i,:)];
    
   end
end


fprintf('Find distribution: path length %d\n',size(path,1))
last_point=round(path(size(path,1),:));
ellipse_detected=1;
if(source)
    fprintf('discover contour line\n')
    contour_path=contourLine(Field,last_point);
    if(size(contour_path,1)>10)
        fprintf('find centroid\n')
        ellipse=fit_ellipse(contour_path(:,1),contour_path(:,2));
        centroid=[round(ellipse.X0_in) round(ellipse.Y0_in)];
        fprintf('find rectangle\n') 
        [rect,del_partion]=partition( t,centroid );
        fprintf('update tree\n')
        [t n]=updateTree(t,rect,centroid,del_partion);
        elliptical_sources=[ellipse;elliptical_sources];
        
    else 
        ellipse_detected=0;
        fprintf('not updating map\n') 
    end

end

fprintf('update field map\n')
[ Field, entropy_map,map ] = update_map( Field,area_points,ellipse,entropy_map,path,contour_path,ellipse_detected );
fprintf('next best area\n')
[area_corner,robot,area_points]=nextBestArea(entropy_map,t);
centroid=robot;

uPDE=entropy(entropy_map)
step=step+1;
% disp(t.tostring)
%  simulation( path_view,contour_path,ellipse,map,field() );
 
 source=0;
 contour_path=[];
% 
%   figure(2)
%    contourf(Field)
%    figure(1)
end




