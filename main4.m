clc;clear all;clf;
addpath('voronoi')
load('ellipses')
load('groundTruth')

n=4;
bounds = [1 50 1 50];
wts = zeros(n,1);
x = gallery('uniformdata',[1 n],0)*(bounds(2)-bounds(1)) + bounds(1);
y = gallery('uniformdata',[1 n],1)*(bounds(4)-bounds(3)) + bounds(3);
points=[x' y'];
taken=[];
for ii=1:6
    subplot(2,3,ii) 
    %computing weight on 4
    if(ii>=4)            
        for kk=1:length(E)
            wts(kk,:)=pi*elliptical_sources(kk).a*elliptical_sources(kk).b; 
        end
    end
    %otherwise use uniform weight        
    if(ii<=4)
        %Find unique point 
        ind=emin( E,points(ii,:),taken );
        taken=[taken;ind];
        points(ii,:)=E(ind,:);
        %draw ellipse and diagram
        draw_ellipse(elliptical_sources(ind)) 
        [PD, PDinf] = powerDiagramWrapper(points,  zeros(n,1));           
    elseif (ii==5)  
        for kk=1:length(E)
            draw_ellipse(elliptical_sources(kk));
        end
    [PD, PDinf] = powerDiagramWrapper(points, wts);
    [PD, PDinf] = powerDiagramWrapper(points,  zeros(n,1));
    else
        [PD, PDinf] = powerDiagramWrapper(points, wts);
    end
    axis(bounds)
    title(ii)
end

