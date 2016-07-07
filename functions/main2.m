close all; clc;clear all;
addpath('voronoi')
load('ellipses')

E=[];
wts=[];

for i=1:length(elliptical_sources)
%     center_point 
    ele=[elliptical_sources(i).X0_in elliptical_sources(i).Y0_in];
    E=[ele;E];
   
%     weight is the area size
    area=pi*elliptical_sources(i).a*elliptical_sources(i).b;
    wts=[area;wts];
end

[PD, PDinf] = powerDiagramWrapper(E, wts);

for i=1:length(elliptical_sources)
   draw_ellipse(elliptical_sources(i)) 
end

axis square