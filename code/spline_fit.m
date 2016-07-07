function [ M_0 ] = spline_fit( contour_path,t,count )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
k = 4;
if(nargin==1)
   t = 1:length(contour_path)-1+k;
   count=0;
end

% control points (unknown)
for kk=1:length(contour_path)-1
    xx=contour_path(kk,1);
    yy=contour_path(kk,2);
    
    xx1=contour_path(kk+1,1);
    yy1=contour_path(kk+1,2);
    D_0(kk,:)=[(xx+xx1)/2 (yy+yy1)/2];
end
D_0=D_0';


[M_0,x] = bspline_deboor(k,t,D_0);
if(count<2)
    M_0=spline_fit( M_0',1:length(M_0)+k-1,count+1 );
end
   
    
    
    


end

