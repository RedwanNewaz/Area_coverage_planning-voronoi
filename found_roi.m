function [ candidateROIs ] = found_roi( rois,edge )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
roiNumber=1;
candidateROIs=[];
for roi=rois'
    points=edgeToPolyline(edge, 10);
    inside=0;
    for point=points'
        inside =inside+ isPointInEllipse(point', roi');
        if(inside>0)
            candidateROIs=[candidateROIs;roiNumber];
            break;
        end
    end
roiNumber=roiNumber+1;
end

end

