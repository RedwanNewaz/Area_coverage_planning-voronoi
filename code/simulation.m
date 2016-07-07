function [  ] = simulation( path_view,contour_path,ellipse,map,field )
%VISUALIZATION
%  1) Field  
% 2) path
% 3)contour line
% 4) partition: ellipse
% 
% 

%% 
%initialization
hFigure=figure(1);
figureFullScreen(hFigure);
set(gcf,'color','w');
hold on
view(0,90)
axis square
box on


%1)Field
contour(field)
%2) path
if(size(path_view,1)>1)
   comet(path_view(:,1),path_view(:,2))
end
 
% plot(path(:,1),path(:,2))
%3)contour line
if(contour_path)
comet(contour_path(:,1),contour_path(:,2))
%     plot(contour_path(:,1),contour_path(:,2))
end

if(map)
 scatter(map(:,1),map(:,2),'filled','d')

% 4) partition:(ellipse)
    centroid=[round(ellipse.X0_in) round(ellipse.Y0_in)];
    refLine = createLine([0 round(ellipse.Y0_in)], centroid);
    perp = orthogonalLine(refLine, centroid);
    drawLine(refLine, 'lineWidth', 2);
    drawPoint(centroid);
    drawLine(perp, 'color', 'b','lineWidth', 2);
    
end


end

