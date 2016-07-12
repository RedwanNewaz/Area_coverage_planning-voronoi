function points = sortPoints( p,pointSet,taken,count,points )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

ind=emin(pointSet,p,taken);
p=pointSet(ind,:);
if(count<size(pointSet,1))
points = sortPoints( p,pointSet,[taken;ind],count+1,[points;p] );
else
    points = [points;p] ;
end

end

