%%
% Let us create the following graph
%       (1)--(2)--(3)-------(4)
%        |   / \   |		 |
%        |  /   \  |		 |
%        | /     \ |		 |
%       (5)-------(6)		 |
%		 |		 			 |
%		 |					 |
%		 |					 |
%		(7)-----------------(8)
%   
% g=[0 1 0 0 1 0 0 0;
%    1 0 1 0 1 1 0 0;
%    0 1 0 1 0 1 0 0;
%    0 0 1 0 0 0 0 1;
%    1 1 0 0 0 1 1 0;
%	 0 1 1 0 1 0 0 0;
%	 0 0 0 0 1 0 0 1;
%	 0 0 0 1 0 0 1 0]
% s=5; % Source
% d=1; % Destination
%
% P = hamiltonianPath(g,s,d);
%
% P will be an array mentioning the path/cycle, if path/cycle found; or a
% string: 'No Path Found', if path/cycle not found
%
% #Note: This code can be used for finding Hamiltonian cycle also. For
% that, make sure Source and Destination are same.

%%
%{
    Main Function
%}
function hamPath = hamiltonian(g, s, d)
 count=1;
for i=1:nv(g)
    nei=neighbors(g,i);
%      fprintf('\n node %d deg (%d) :=',i, deg(g,i))
    for j=1:size(nei,2)
        nodeList.A(count,:)=i;
        nodeList.B(count,:)=nei(j);
        nodeList.W(count,:)=1;
%         fprintf('ne (%d) \t',nei(j));
        count=count+1;
    end   
end

DG = sparse(nodeList.A,nodeList.B,nodeList.W);

%%
gh=full(DG);
hamPath = hamiltonian2(gh,s,d);


end

function hamPath = hamiltonian2(Graph, Source, Destination)

% Input Checking
if ~isreal(Graph)
    error('Graph must be in real form');
elseif ~isnumeric(Graph)
    error('Matrix must be numeric');
elseif ~ismatrix(Graph)
    error('Check Matrix Dimensions');
else
    [r, c] = size (Graph);
    if r~=c
        error('Matrix must be square matrix');
    end
end

if ~(isreal(Source)||isreal(Destination)||(Source>0 && Source<=r) || (Destination>0 && Destination<=r))
    error('improper Source/Destination');
end

clear c;

% Function call
hamPath = findHam(Graph, Source, Destination, r);

end

%%
%{
    This functions sets some initial parameters, and calls the actual
    function.
%}
function hamPath = findHam(Graph, Source, Destination, totalNodes)

hamPath = zeros(size(Graph(1,:)));

hamPath(1) = Source;
    PI=1;    t = cputime; maxNode=0; maxHampath=hamPath;
[Status, hamPath] = hamRec(Graph, hamPath, Source, Destination, totalNodes, 1,PI,t,maxNode,maxHampath);

if Status == 0
    if Source ~= Destination
        hamPath = 'No Path Found';
    else
        hamPath = 'No Cycle Found';
    end
    return;
end

end

%%
%{
    This function recursively call itself, hence finding the solution
%}
function [Status, hamPath] = hamRec(Graph, hamPath, Source, Destination, totalNodes, nodesFound,PI,t,maxNode, maxHampath)

% Ending Condition check
if (maxNode<length(nonzeros(hamPath)))
    maxNode=length(nonzeros(hamPath));
    maxHampath=hamPath; 
end

if (cputime-t>totalNodes/100)
    PI=PI-0.01    ;
%     fprintf('time elapsed %d \n',cputime-t)
    t=cputime;
end

if ( (nodesFound == totalNodes-1 && Source~=Destination) || (nodesFound == totalNodes && Source==Destination) ||nodesFound/totalNodes>PI)
%     fprintf('nodeFound=%d maxNode =%d\n',nodesFound,maxNode);
%      hamPath=maxHampath;
    if ( Graph(hamPath(nodesFound), Destination) ~= 0 ||nodesFound/totalNodes>PI)
       
%         hamPath(nodesFound+1) = Destination;
%         maxHampath
        Status = 1;
        return;
    else
        Status = 0;
        return;
    end
end

for i=1:totalNodes
    if i==Destination
        continue;
    end
    
    if isSafe(Graph, hamPath, nodesFound, i)
        hamPath(nodesFound+1) = i;
        
        
        
        [Status, hamPath] = hamRec(Graph, hamPath, Source, Destination, totalNodes, nodesFound+1,PI,t,maxNode,maxHampath);
        if Status
            return;
        end
        
        hamPath(nodesFound+1) = 0;
    end
end

Status = 0;

end

%%
%{
    This function is used to check whether the current node can be added
    or not for making the path/cycle.
%}
function Flag = isSafe(Graph, hamPath, nodesFound, i)

if Graph(hamPath(nodesFound),i) == 0
    Flag = 0;
    return;
end

for ii=1:nodesFound
    if hamPath(ii) == i
        Flag = 0;
        return;
    end
end

Flag = 1;

end