close all; clear all;
addpath('voronoi')
load('ellipses')
load('groundTruth')

n=4;
bounds = [1 50 1 50];
x = gallery('uniformdata',[1 n],0)*(bounds(2)-bounds(1)) + bounds(1);
y = gallery('uniformdata',[1 n],1)*(bounds(4)-bounds(3)) + bounds(3);

gtx =[x' y'];
wts = zeros(n,1);

taken=[];
occur=0;
%%   

for ii=1:4    
%     find nearest new point 
    ind=emin( E,gtx(ii,:),taken );
    taken=[taken;ind];
    gtx(ii,:)=E(ind,:);
    hold on
    subplot(2,2,ii)
    
    %     weight is the area size
%     area=pi*elliptical_sources(ii).a*elliptical_sources(ii).b;
%     wts(ii,:)=area;
    
% draw voronoi diagram 
    [PD, PDinf] = powerDiagramWrapper(gtx, wts);
    axis(bounds)
%     draw ellipse




end
  
for ii=1:4
    hold on
    subplot(2,2,ii)
     for jj=1:ii 
        draw_ellipse(elliptical_sources(jj)) 
     end
         box on
 
    title(ii)
end
