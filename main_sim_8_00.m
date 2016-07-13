run('init')
%%
sim_par.part = vornoiPartition( bound);

while(step<4)
sim_par.goal=exploration(sim_par.part,sim_par.robot,sim_par.map );
[sim_par.traj,indROI]=trajectory(sim_par.goal,sim_par.robot,sim_par.map,sim_par.rois);
[sim_par.map,sim_par.robot]=updateMap(sim_par,indROI);
sim_view( sim_par,indROI );
newCentroids=updatePartition(sim_par.part,[findROIs;indROI],sim_par.rois);
sim_par.part = vornoiPartition( bound,newCentroids);
sim_par.rois(indROI,:)=[];
pause(1)
step=step+1;
end
%%

% for ii=1:length(partition)    
%     centroids=[centroids;partition(ii).center];
% end
% x=centroids(:,1);
% y=centroids(:,2);
% % find the nearest centroid
% centroid_mask=[];
% ind=emin(centroids ,robot,centroid_mask );
% centroid_mask=[centroid_mask;ind];
% 
% %%
% % subplot(2,3,4)
% for kk=1:length(partition)
%  center(kk,:)=wallFollowingSearch( partition(kk),kk);
% end
% % centroids=center;
% %%
% while (step<2)
% % update windows
% subplot(2,3,step+1)
% %connect the centroid 
% edge=createEdge(robot, [x(ind), y(ind)]);
% drawEdge(x(ind), y(ind), robot(1), robot(2));
% % find intesection with any ellipse
% candidateROIs  = found_roi( rois,edge );
% %draw candidate rois
% for ii=candidateROIs
%     hold on
%     drawEllipse(rois(ii,:)); 
% end
% %update area parition 
% findROIs=[findROIs;rois(candidateROIs,:)];
% centroids(ind,:)=rois(candidateROIs,1:2);
% %update centroids
% 
% 
% %update rois
% rois(candidateROIs,:)=[];
% %update robot position 
% robot=[13.3243    6.6890]
% step=step+1;
% 
% % plot(x,y,'r+',vx,vy,'b-')
% partition = vornoiPartition( bound,centroids);
% subplot(2,3,step+2);
% visulization.partition(partition);
% %move to next candidate
% ind=3;
% end