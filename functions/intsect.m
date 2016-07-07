function [ output_args ] = intsect( a,ellipses )
%ELLIPSE INTERSECTION CHECK
%   Compared ellipse is transform to points 
%   those points are checked for each ellipse in the set  

points=ellipseToPolygon(a);
output_args=0;
for E=ellipses'
    for p=points'
        output_args=output_args+isPointInEllipse(p',E');
    end
end

end

