function [ contour_path2 ] = contourLine( Field,last_point )
count=0;
dr=0.0009;
R=2;
step=0.001;
Q=0;
miuInt=Field(last_point(2),last_point(1));

    %FORWARD TRACKING
	while(Q<=2*pi)	
        
        %update position
		X1=last_point(1)+R*cos(Q);
		Y1=last_point(2)+R*sin(Q);

        %get a measurement and compare
        X1=round(X1);Y1=round(Y1);
        diff=Field(Y1,X1)-miuInt;
        ratio=Field(Y1,X1)/miuInt;
        
        %predict step size
        delta = diff*dr;
		R=R+delta;
		step=step-diff*atan((step*step)/(R*R));
		Q=Q+step;
        
        %record path
        if (ratio>1.2)
            continue;
        end 
        count=count+1;
        contour_path(count,:)=[X1 Y1];
    end

    %BACKWAR TRACKING
    %fprintf('BACKWARD TRACKING %f count %d \n',Q,count)
    R=2;
   prediff=0;
	while(Q>0)	
        
        %update position
		X1=last_point(1)+R*cos(Q);
		Y1=last_point(2)+R*sin(Q);

        %get a measurement and compare
        X1=round(X1);
        Y1=round(Y1);
        
       
        
        diff=Field(Y1,X1)-miuInt;
        ratio=Field(Y1,X1)/miuInt;
        
        %predict step size
        delta = diff*dr;
		R=R+delta;
		step=step-diff*atan((step*step)/(R*R));
		Q=Q-step;
        
        %record path
        if (ratio>1.2)
            continue;
        end 
        count=count+1;
        contour_path(count,:)=[X1 Y1];
    end
    
     % find unique points
        cp=sub2ind(size(Field),contour_path(:,1),contour_path(:,2));
        cp=unique(cp);
        for ii=1:length(cp)
            [x1,y1]=ind2sub(size(Field),cp(ii));
            contour_path2(ii,:)=[x1 y1];
        end
         %sorting them in right order
         contour_path2=sor2dist(contour_path2,last_point);
        %contour_path2=sor2dist(contour_path2,last_point);
        

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
