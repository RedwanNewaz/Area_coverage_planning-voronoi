function [ Field, entropy_map,map ] = update_map( Field,area_points,ellipse,entropy_map,path,contour_path,ellipse_detected )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
map=[];
if(ellipse_detected)
for y=1:50
    for x=1:50
    ELLIPSE=[ellipse.X0_in ellipse.Y0_in ellipse.a ellipse.b -ellipse.phi*57.29];
    if(isPointInEllipse([x y], ELLIPSE) )
       
        map=[map;[x, y]];
    end
    end
end
else
    map=area_points;
end


for jj=1:size(map,1)
%     entropy_map(path(jj,2),path(jj,1))=0;
    
    x=map(jj,1);
    y=map(jj,2);
    Field(y,x)=0;
    entropy_map(y,x)=0;
    
end



for jj=1:size(path,1)
%     entropy_map(path(jj,2),path(jj,1))=0;
    
    x=path(jj,1);
    y=path(jj,2);
    Field(y,x)=0;
    entropy_map(y,x)=0;
    
end

for kk=1:size(contour_path,1)
    x=contour_path(kk,1);
    y=contour_path(kk,2);
    Field(y,x)=0;
    entropy_map(y,x)=0;
end

end

