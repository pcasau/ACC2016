function plus_xi = g(xi)
    global params 
    k     = params.k;
    gamma = params.gamma;
    epsl  = params.epsl;
    %states
    p  = xi(1:3);
    v  = xi(4:6);
    R  = reshape(xi(7:15),[3 3]);
    y1 = xi(16:18);
    y2 = xi(19:21);
    pd = xi(22:24);
    vd = xi(25:27);
    ad = xi(28:30);
    Rd = reshape(xi(31:39),[3 3]);
    t  = xi(40);
    %Jump logic
    
    
    plus_p = p;
    plus_v = v;
    
    Re = Rd'*R;
    y  = [y1 y2];
    plus_y = y;
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
            if r'*x >= -gamma
                plus_y(:,I) = -x;
            elseif -1 < r'*x || r'*x < -gamma
                plus_y(:,I) = -sigma(r'*x,gamma)*S(x)^2*r/norm(S(x)^2*r)+alpha(r'*x,gamma)*x;
            elseif r'*x == -1 
                colat = pi*rand;
                long  = 2*pi*rand-pi;
                v     = [sin(colat)*cos(long);sin(colat)*sin(long);cos(colat)];
                vnormal = -S(r)^2*v*sqrt(1-gamma^2)/norm(-S(r)^2*v);
                plus_y(:,I) = vnormal+r*gamma;
            end 
        end
    end
    plus_xi = [plus_p;plus_v;R(:);plus_y(:);pd;vd;ad;Rd(:);t];
    
end