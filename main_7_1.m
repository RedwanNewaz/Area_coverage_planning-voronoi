clear all;clc;clf;
addpath dataSet voronoi functions
load(sprintf('bestEllipse%d',1))
%# simulation parameters
robot=[1 1];
rois=bestEllipse;
findROIs=[];
step=1;
bound=[1 50 1 50];


partition = vornoiPartition( bound);
visulization.partition(partition);






