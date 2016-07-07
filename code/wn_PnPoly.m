function [wn]= wn_PnPoly( P, V )

    wn=0;
    n=size(V,1);            % n*2 matrix
    Vy=V(:, 2);             % V(X,Y)
    for i=1:n-1
        if (Vy(i) <= P(2))  % Py          
            if (Vy(i+1)  > P(2))      %Py
                 if (isLeft( V, i, P) > 0) 
                     wn=wn+1;         
                 end
            end

        else                       
            if (Vy(i+1)  <= P(2))    
                 if (isLeft( V, i, P) < 0) 
                    wn=wn-1;  
                 end
            end
        end
    end


end

function [t]= isLeft(V, i, P)
    
    P0x=V(i,1);P1x=V(i+1,1);P2x=P(1);       %V(X,Y)                                                      
    P0y=V(i,2);P1y=V(i+1,2);P2y=P(2);
    
    t1=    (P1x - P0x) * (P2y - P0y);
    t2=    (P2x - P0x) * (P1y - P0y) ;
    t=t1-t2;
end