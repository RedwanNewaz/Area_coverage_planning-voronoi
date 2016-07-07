function [ contour_path ] = contourLine( Field,last_point )

R=0.5;

[contour_path,index_set,status2]=get_points([],Field,0.001,0,R,last_point,0.0009,[],1);
[contour_path2,index_set2,status]=get_points([],Field,0.001,2*pi,R,last_point,0.0009,index_set,0);

if(status)
    for jj=size(contour_path2,1):-1:1
        contour_path=[contour_path;contour_path2(jj,:)];
    end
else
    fprintf('skipping second contour\n')
end

end


function [contour_path,index_set,status]=get_points(contour_path,Field,step,Q,R,last_point,dr,index_set,forward)
    
    status=1;
    miuInt=982;
    %get a measurement and compare
    X1=round(last_point(1)+R*cos(Q));Y1=round(last_point(2)+R*sin(Q));
    if(X1<1||Y1<1)
        status=0;
        return;
    end
    
    diff=Field(Y1,X1)-miuInt;

    %predict step size
    delta = diff*dr;
    R=R+delta;
    if(delta==0||diff==0)
        update=0.0009;
    else
        update=delta/diff;
    end
       
    %update trajectory
    index=sub2ind(size(Field),X1,Y1);
    if(length(find(index_set==index)))%FORWARD TRACKING
       traj=contour_path;  
    else %BACKWARD TRACKING
         traj= [contour_path;[X1 Y1]];
    end
     step=step-diff*atan((step*step)/(R*R));
     if (forward)
         if(Q<=2*pi)	
             [contour_path,index_set,status]=get_points(traj,Field,step,Q+step,R,last_point,update,[index_set;index],forward);
         end
     else
        if(Q>0)	
         [contour_path,index_set,status]=get_points(traj,Field,step,Q-step,R,last_point,update,[index_set;index],forward);
        end
         
     end
end

function [ out ] = sor2dist( data,r_COM )
X=data(:,1);
Y=data(:,2);

if(nargin==1)
    %// Compute centre of mass
r_COM = sum([X, Y]) / numel(X);
end
%// Sort all vertices by angle
[~, I] = sort(atan2(Y - r_COM(2), X - r_COM(1)));

out=[X([I; I(1)]) Y([I; I(1)])];

%// Plot the new contour
%hold on, plot(X([I; I(1)]),Y([I; I(1)]), '.-k', 'linewidth', 2);

end
