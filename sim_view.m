function  sim_view( parm_args,indROI )
%PLOT1 show partition, robot, goal, traj
% robot--> triangle
% goal -->circle
% Traj --> blue line
%  patrtion -->colored lines
% PLOT2 show explored map   
win=[-10 60 -10 60];
h=subplot(1,2,1);
axis(win)
cla(h)
hold on
viz.partition(parm_args.part);
plot(parm_args.robot(1),parm_args.robot(2),'^','LineWidth',2)
plot(parm_args.goal(1),parm_args.goal(2),'^','LineWidth',2)
comet(parm_args.traj(:,1),parm_args.traj(:,2))


h2=subplot(1,2,2);
cla(h2)
axis(win)
hold on
surf(-parm_args.map);
colormap('gray')
view(0,90)
if(indROI)
drawEllipse(parm_args.rois(indROI,:),'LineWidth',2);
end


end

