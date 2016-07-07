function [ output_args,del_partion ] = partition( t,centroid )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% [1,1],[50,50]
del_partion=0;
len=length(t.Node);
if(len<2)
    A=t.Node{len};
    initial=A(1,:);
    final=A(3,:);
    
else 
    %find the centroid in the area
    for ii=len:-1:2
        A=t.Node{ii};

        point_exist=wn_PnPoly( centroid, A );
        if(point_exist==1)
            del_partion=ii;
            initial=A(1,:);
            final=A(3,:);
            fprintf('partition %d \n',ii)
            break;
        end
        
    end
end

VRedge= [final(2),initial(2),final(1),final(2)];
VLedge= [initial(1),final(1),initial(1),initial(2)];

HRedge= [initial(1),final(1),final(1),final(2)];
HLedge= [initial(1),initial(2),final(2),initial(2)];


edges=[VRedge;HRedge;VLedge;HLedge];
dist =distancePointEdge(centroid, edges)

output_args=[
    centroid+[dist(1) 0];
    centroid+[0 dist(2)];
    centroid-[dist(3) 0];
    centroid-[0 dist(4)];
    
];

if(find(output_args(:,1)<1)  )
   fprintf('\n Error') 
end

if(find(output_args(:,2)<1)  )
   fprintf('\n Error') 
   output_args(4,:)=[11 14];
end



end

