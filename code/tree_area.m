function [ ] = tree_area( t )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

len=length(t.Node);
for ii=1:len
    hold on
    A=t.Node{ii};
    plot(A(:,1),A(:,2))
end
end

