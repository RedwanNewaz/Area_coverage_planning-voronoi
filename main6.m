clf;clc;clear all;
addpath('nestedSortStruct')
sz = [50 30];
n=6;
%% # parameters of ellipses
num =n*round(n/2);
h = zeros(1,num);
clr = lines(num);             %# color of each ellipse
x = rand(num,1) .* sz(2)+10;     %# center x-coords
y = rand(num,1) .* sz(1);     %# center y-coords
a = rand(num,1) .* 10;       %# major axis length
b = rand(num,1) .* 15;       %# minor axis length
angle = rand(num,1) .* 360;   %# angle of rotation
hold on
ellipseSet=struct('parameter',[],'area',[]);
for i=1:num
    %# lets plot the ellipse (overlayed)
    e=[x(i),y(i), a(i),b(i), angle(i)];
    area=pi*a(i)*b(i);
    ellipseSet(i).parameter=e;
    ellipseSet(i).area=area;
end

%% sortEll
[sortEll ind]=sortStruct(ellipseSet, 'area',-1);

%% cost computation
costSet=struct('cost',[],'candidates',[]);

cost=inf;
bestEllipse=[];
for jj=1:length(sortEll)
    %reference ellipse 
    ref=sortEll(jj).parameter;
    %find n number of ellipses 
    ellipses=ref;
    localCost=0;
   for  kk=1:length(sortEll)
        comp=sortEll(kk).parameter;
        area2=sortEll(kk).area;
        %check intersecting
        if(~intsect(comp,ellipses))
            ellipses=[ellipses;comp];
            localCost=localCost+100/area2;
            % check the number of ellipses
            if(size(ellipses,1)>=n)
                break;
            end
        end
   end

   %find minimum cost subject to n number of ellipses only
   if(localCost<cost && size(ellipses,1)>=n)
       cost=localCost;
       bestEllipse=ellipses;
   end 
  
end
%%
for nn=bestEllipse'
    drawEllipse(nn');
end