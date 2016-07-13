clear all;clc;clf;
addpath dataSet voronoi functions
load(sprintf('bestEllipse%d',1))
%# simulation parameters


findROIs=[];
centroids=[];

step=1;
bound=[1 50 1 50];
sim_par=struct('part',[],'robot',[],'goal',[],'traj',[],'map',[],'rois',[]);
sim_par.map=zeros(50,50);
sim_par.robot=[1 1];
sim_par.rois=bestEllipse;
% # generate voronoi partition with uniform samples

