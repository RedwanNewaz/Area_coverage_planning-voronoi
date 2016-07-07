clear all;close all;clc;
%E=load ground truth
load('groundTruth')
load('ellipses')
%weight is zero 
wts=zeros(4,1);
[PD, PDinf] = powerDiagramWrapper(E, wts);

for i=1:length(elliptical_sources)
   draw_ellipse(elliptical_sources(i)) 
end