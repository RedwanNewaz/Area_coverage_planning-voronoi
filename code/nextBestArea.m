function [area_corner,robot,area_points]=nextBestArea(entropy_map,t)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% disp(t.tostring)

entropyTree = tree(t, 'clear');
areaTree = tree(t, 'clear');
entropy_val=[];
locations_iterator = t.depthfirstiterator;

 for ii=locations_iterator
    A=t.get(ii);
    corner=[max(A(:,1)) max(A(:,2))];
    start=[min(A(:,1)) min(A(:,2))];
    inside=corner-start;
    area_size=abs(inside(1)*inside(2));
    areaTree=areaTree.set(ii,area_size);
    
    if( inside(1)<2 ||inside(2)<2)
        en=0;
        entropyTree=entropyTree.set(ii, en);
    else
        
%         en=entropy(entropy_map(y1:y2,x1:x2));
        en=findpointsInside(A,entropy_map);
    
    end
    
    entropy_val=[entropy_val;en];
    
end
%update entropy tree
iterator = entropyTree.depthfirstiterator;
index = 1;
for i = iterator
    entropyTree = entropyTree.set(i, entropy_val(index));
    index = index + 1;
end






%branch entropy method
branch_tree=entropyTree;
parent=branch_tree.Parent;
parent=unique(parent)';
index=0;
for eachparent=parent
    
child= entropyTree.getchildren(eachparent);
 index=index+1;
  for eachchild=child
     p=branch_tree.getparent(eachchild);
     c=entropyTree.Node{eachchild};
     value=(index)*p*c+p*c;
%           fprintf(' value %f\t',value)
      branch_tree=branch_tree.set(eachchild,value);
  end
end

% find best node
branch_entropy=cell2mat(entropyTree.Node);
[maxi,ind]=max(branch_entropy);
AB=t.Node{ind};
area_corner=[max(AB(:,1)) max(AB(:,2))];
robot=[min(AB(:,1)) min(AB(:,2))];

% disp([areaTree.tostring branch_tree.tostring entropyTree.tostring ])
disp( entropyTree.tostring )
fprintf('\n maxi %f %d\n',maxi,ind)

area_points=geometric_points(AB);
end

function en=findpointsInside(A,entropy_map)
points=geometric_points(A);

if(size(points,1)>1)
    en=entropy(entropy_map(points(:,2),points(:,1)));
else
    fprintf('No points found ERRR')
    en=0;
end
end

function points=geometric_points(A)
points=[];
for xx=1:50
    for yy=1:50
        point=[xx yy];
        point_exist=wn_PnPoly( point, A );
        if(point_exist)
            points=[points;point];
        end
        
    end
end
end
