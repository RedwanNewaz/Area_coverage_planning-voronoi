function  center=wallFollowingSearch( partition,kk )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[POLY, center]=partition2poly(partition);
y=POLY(:,2);
x=POLY(:,1);
[THETA,RADIUS] = cart2pol(x,y);
for ii=1:0.15:4
POLY=[POLY;getPoly(RADIUS,THETA,ii,center)];
end
viz.drawPolygon(POLY,kk)




end


