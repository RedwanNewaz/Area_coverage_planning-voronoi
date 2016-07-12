function [ vx,vy,x,y ] = area_partition( update)
%uniform sampling: If centroids are not available, 
%Iteratively sampling: each update contains true poistion of source
if nargin <1
    [x y]=randomCentroid();
else 
    [px py]=randomCentroid();
    points=[px' py'];
    [x y]=partialCentroid(update(:,1:2),points,[],0);
end
[vx,vy] = voronoi(x,y);


end

function [x y]=randomCentroid()
n=4;
bounds = [1 50 1 50];
wts = zeros(n,1);
x = gallery('uniformdata',[1 n],0)*(bounds(2)-bounds(1)) + bounds(1);
y = gallery('uniformdata',[1 n],1)*(bounds(4)-bounds(3)) + bounds(3);

end

function [x y]=partialCentroid(update,candidates,taken,count)
   for point=update'
        if(count<size(update,1))
               ind=emin( candidates,point',taken );
               candidates(ind,:)=point';
               partialCentroid(update,candidates,[taken;ind],count+1);
        end
   end
   x=candidates(:,1);
   y=candidates(:,2);
end
