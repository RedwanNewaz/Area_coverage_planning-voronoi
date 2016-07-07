clf;clear all;clc;
ne=5;
bounds = [1 50 1 50];
x = rand(ne,1)*(bounds(2)-bounds(1)) + bounds(1);
y = rand(ne,1)*(bounds(4)-bounds(3)) + bounds(3);

axisbound=[1 10 1 10];
a = rand(ne,1)*(axisbound(2)-axisbound(1)) + axisbound(1);
b = rand(ne,1)*(axisbound(4)-axisbound(3)) + axisbound(3);

%draw random ellipse
for i=1:length(x)
    hold on
drawEllipse([x(i) y(i) a(i) b(i) 180]);
end

%% voronoi conversion
[vx,vy] = voronoi(x,y);
plot(x,y,'r+',vx,vy,'b-')
axis(bounds)
hold on
%% power diagram
 wts=pi*x.*a.*b;
 points=[x y];
 [PD, PDinf] = powerDiagramWrapper(points,  normpdf(wts));  
 