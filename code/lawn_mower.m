%lawn_mower motion
function [P,source]=lawn_mower(area,initial,Field)
if(initial(1)<area(1))
    [P,source]=forward_lapping(round(area),round(initial),Field,round(initial));
else
    [P,source]=backward_lapping(area,initial,Field,[]);
end

P=round(P);

end  

function [P,source]=forward_lapping(area,initial,Field,P)
up=1;
source=0;
THR=1000;
x=initial(1); 
while(x<=area(1)-1 && ~source)
        if(up) %forward direction 
            
            for y=initial(2):1:area(2)
                 %terminate path
                if(Field(y,x)>THR)
                    source=1;
                    break;
                end
                P=[P;[x y]];

            end
            up=0;
            x=x+1;
        else %backward direction 
            for y=area(2):-1:initial(2)
               if(Field(y,x)>THR)
                source=1;
                break;
               end
                 P=[P;[x y]];
            end
            up=1;
             x=x+1;
        end
       
    end
end

function [P,source]=backward_lapping(area,initial,Field,P)
up=1;
source=0;
THR=1000;
x=initial(1); 
while(x>=area(1) && ~source)
        if(up) %forward direction 
            
            for y=initial(2):1:area(2)
                 %terminate path
                if(Field(y,x)>THR)
                    source=1;
                    break;
                end
                P=[P;[x y]];

            end
            up=0;
            x=x-1;
        else %backward direction 
            for y=area(2):-1:initial(2)
               if(Field(y,x)>THR)
                source=1;
                break;
               end
                 P=[P;[x y]];
            end
            up=1;
             x=x-1;
        end
       
    end
end
