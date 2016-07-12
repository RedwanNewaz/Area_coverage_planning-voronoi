function  center=wallFollowingSearch( partition )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
hold on
[POLY, center]=partition2poly(partition);
% drawPolygon(POLY);
% drawPoint(center);

y=POLY(:,2);
x=POLY(:,1);
[THETA,RADIUS] = cart2pol(x,y);
for ii=1:0.15:4
POLY=getPoly(RADIUS,THETA,ii,center);
% drawPolygon(POLY);
end




end


function hh=createSetEdges(vx,vy)
    for c=1:length(vx)
       hh(c,:)=createEdge([vx(1,c), vy(1,c)],[vx(2,c), vy(2,c)]);
    end
end

function POLY=getPoly(R,T,decR,c1)
R=R./decR;
x=R.*cos(T);
y=R.*sin(T);
POLY=[x y];
c2=centroid(POLY);
c=c1-c2;
POLY=[x+c(1) y+c(2)];
end

function [POLY, center]=partition2poly(partition)

    % convert partition to edges
    hh=createSetEdges(partition.mX,partition.mY);
    points=[];
    for e=hh'
        [p1,p2]=edge2point(e');
        points=[points;p1;p2];
    end
    out=unique(points,'rows');
    count=1;
    PTS = sortPoints( out(1,:),out,1,count,[]);

%     update
    center=centroid(PTS);
    POLY=PTS;
end