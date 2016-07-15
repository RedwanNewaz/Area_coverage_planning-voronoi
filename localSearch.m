function [ path,roiIndex] = localSearch( partition,map,robot,rois )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
path=[];
[POLY, center]=partition2poly(partition);
n=length(map);
unexploredCells=[];
for i=1:n
    for j=1:n
        p=[i,j];
        if(isPointInPolygon(p,POLY))
            if(map(j,i)==0)
                unexploredCells=[unexploredCells;p];
            end
        end
    end
end
unexploredCells=[robot;unexploredCells];
[path, ind] = solveTSP( unexploredCells);
[Found,pathIndex,roiIndex]=intersectROI(path,rois,1,1);
path=path(1:pathIndex,:);
if(~Found)
    disp('ROI not Found!!');
    roiIndex=[];
end

end

