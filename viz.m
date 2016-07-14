classdef viz
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    properties(Constant)
        color=['y','m','c','r','g','b','k','w'];
    end
    
    methods(Static)
        function partition(inputs)
            hold on
            color=['y','m','c','r','g','b','k','w'];
           for i=1:length(inputs)
            drawPoint(inputs(i).center,'color',viz.color(i));
            plot(inputs(i).mX,inputs(i).mY,viz.color(i),'LineWidth',4);
           end
        end
        
        function drawEdgeSet(edgeSet)
           hold on  
          for h=edgeSet'
           drawEdge(h');  
          end        
        end
        
        function drawPoints(points)
           hold on
           for p=points'
              drawPoint(p'); 
           end
        end
        
        function drawPolygon(POLY,kk)
            hold on
           drawPolygon(POLY,'color',viz.color(kk)); 
        end
        
        function drawEllipses(ellipses)
           hold on
           for e=ellipses'
           drawEllipse(e');
           end
        end

    end
    
end

