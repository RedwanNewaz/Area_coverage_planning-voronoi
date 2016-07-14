function goal  = exploration( part,robot,map )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
 
B=cell2mat({part(:).center}');
D=dist(B,robot);

for ii=1:length(part)
    [POLY, center]=partition2poly(part(ii));
    %     find the ratio= unvisited/totalcells with in this area
    ratio=exploredRatio(POLY,map);
    A(ii,:) =ratio* abs(polygonArea(POLY));

end
% cost=A./norm(A)+D./norm(D)
cost=A./norm(A);
[m,ind]=max(cost);
goal=part(ind).center;



end

function distance=dist(SET,Point)
    distance=sqrt(sum((SET-repmat(Point,size(SET,1),1)).^2,2));
end

function ratio=exploredRatio(POLY,map)
n=length(map);
uv=0;
total=0;
for i=1:n
    for j=1:n
        if(isPointInPolygon([i,j],POLY))
           if(map(j,i)==0)
              uv=uv+1; 
           end
           total=total+1;
        end
    end
end

ratio=uv/total;

end
