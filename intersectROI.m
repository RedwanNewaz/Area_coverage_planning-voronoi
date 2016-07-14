function [Found,trajIndex,roiIndex]=intersectROI(traj,rois,trajIndex,roiIndex)

    Found = isPointInEllipse(traj(trajIndex,:), rois(roiIndex,:));
%     check all ROIS
    if(roiIndex<size(rois,1) && ~Found)
        [Found,trajIndex,roiIndex]=intersectROI(traj,rois,trajIndex,roiIndex+1);
    end
%     check all points in the trajectory
    if(trajIndex<size(traj,1) && ~Found)
        [Found,trajIndex,roiIndex]=intersectROI(traj,rois,trajIndex+1,1);
    end

end
