clear all;clc;clf;
addpath dataSet voronoi functions
cps=[ 47.5563,   47.6863;
           13.3243,    6.6890;
           30.7353,   47.7400;
           24.8131,   30.3098];
       
bound=[1 50 1 50];
window=[-10 70 -10 70];
subplot(2,3,1)
[vx,vy,x,y]=area_partition(cps);
plot(x,y,'r+',vx,vy,'b-')
hold on
drawBox(bound)
axis(window)
subplot(2,3,2)
partition = vornoiPartition( bound,cps);
axis(window)