function [ t n] = updateTree( t,rect,centroid,del_partion )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 n=[];
rect=[rect;rect(1,:)];
parent=1;
if(del_partion)
    parent=del_partion;
end


top_right=[max(rect(:,1)),max(rect(:,2))];
top_left=[min(rect(:,1)),max(rect(:,2))];
bottom_left=[min(rect(:,1)),min(rect(:,2))];
bottom_right=[max(rect(:,1)),min(rect(:,2))];
corner=[top_right;top_left;bottom_left;bottom_right];


for i=1:4

A=[
    centroid;
    rect(i,:);
    corner(i,:);
    rect(i+1,:);
];
A=round(A);

[t n(i,:)]=t.addnode(parent,A);

end

end

