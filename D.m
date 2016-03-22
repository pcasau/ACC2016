function out = D(xi)
    global params 
    k     = params.k;
    gamma = params.gamma;
    epsl  = params.epsl;
    %states
    R  = reshape(xi(7:15),[3 3]);
    y1 = xi(16:18);
    y2 = xi(19:21);
    Rd = reshape(xi(31:39),[3 3]);
    
    
    Re = Rd'*R;
    y  = [y1 y2];
    out = 0;
    for I = 1:2
        e = eye(3);
        x = Re*e(:,I);
        r = e(:,I);
        if r'*x >= -gamma
            Vmin = (1-r'*x)/(1-r'*x+2*k);
        else
            Vmin = (1-r'*x)/(1-r'*x+k*(1-alpha(r'*x,gamma)));
        end

        if VR(x,y(:,I),r,k)-Vmin >= epsl
            out = 1 | out;
        else
            out = 0 | out;
        end
    end
end