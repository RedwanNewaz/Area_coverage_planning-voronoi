classdef visulization
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods(Static)
        function partition(inputs)
            hold on
            color=['y','m','c','r','g','b','k','w'];
           for i=1:length(inputs)
            drawPoint(inputs(i).center);
            plot(inputs(i).mX,inputs(i).mY,color(i),'LineWidth',4);
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

    end
    
end

