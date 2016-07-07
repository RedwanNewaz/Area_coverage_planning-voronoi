clear all;clc;clf;
addpath voronoi

for loop=1:8
subplot(2,4,loop)
f=sprintf('bestEllipse%d',loop);
load(f)
bounds = [1 70 -10 70];
x=[];y=[];a=[];b=[];
for E=bestEllipse'
   x=[x;E(1)];
   y=[y;E(2)];
   a=[a;E(3)];
   b=[b;E(4)];  
   drawEllipse(E');
   hold on
end

%% voronoi conversion
hold on

[vx,vy] = voronoi(x,y);
plot(x,y,'r+',vx,vy,'b-')

axis(bounds)
axis square

%% power diagram conversion
% subplot(2,1,2)
wts=0.25*pi.*a.*b;
points=[x y];
[PD, PDinf] = powerDiagramWrapper(points, wts );
axis(bounds)
end