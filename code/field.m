function f=field()
    v=[1:50];
    shift=60;
    total1=measurement(v,20,shift);
    shift=8;
    total1_4=measurement(v,20,shift,1);


    shift=35;
    total2=measurement(v,20,shift,1);

    shift=25;
    total3=measurement(v,20,shift,2);
    shift=30;
    total3_1=measurement(v,20,shift,2);

    shift=30;
    total4=measurement(v,20,shift,4);
    f=total1+total1_4+total2+total3+total3_1+total4;
end

function intensity=measurement(v,scale,shift,type)
    if (nargin==3)            
            shift=5;
            type=0;
    end
    [X,Y]=meshgrid(v);


    X=-X;
    Y=-Y;
    switch type
        case 0
        H=[2.07 1.87;-0.97 2.02; 2.02 1.99]+shift;
        case 1
        H=[0.77+7 3.74+shift; 0.99+7 3.82+shift; 0.82+7 4.07+shift];
        case 2
        H=[3.12 2.79; 1.04 2.82;-0.17 3.84]+shift;   
        case 4
        H=[3.12+shift 2.79+5; 1.04+shift 2.82+5;-0.17+shift 3.84+5];  
            
    end
    H_shift=[1 -0.1; 1 -0.1;1 -0.1];
    H=H+2*H_shift;
    
    k=1000;
    I1 = k*exp(-(X+H(1,1)).^2/scale-(Y+H(1,2)).^2/scale);   % (0,0)
    I2 = k*exp(-(X+H(2,1)).^2/scale-(Y+H(2,2)).^2/scale);   % (1,1)
    I3 = k*exp(-(X+H(3,1)).^2/scale-(Y+H(3,2)).^2/scale);  % (-2,2)

    intensity=I1+I2+I3;
end

