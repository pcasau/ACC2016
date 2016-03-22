function dot_xi = f(xi)
    global params rpm radi
    grv = params.grv;
    r   = params.r;
    K   = params.K;
    k   = params.k;
    k1  = params.k1;
    k2  = params.k2;
    kk  = params.kc;
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
    jd = (rpm*2*pi/60)^3*radi*[sin((rpm*2*pi/60)*t);-cos((rpm*2*pi/60)*t);0];
    %position controller
    wq = K*[p-pd;v-vd];
    u  = r'*R'*(wq-grv+ad); %thrust
    %position dynamics
    dot_p = v;
    dot_v = R*r*u+grv;
    %attitude controller
    dot_wq    = K*[dot_p-vd;dot_v-ad];
    
    e1 = [1 0 0]';
    e2 = [0 1 0]';
    wd = S(r)*Rd'*(dot_wq+jd)/norm(wq-grv+ad);
    Re     = Rd'*R;
    x1     = Re*e1;
    x2     = Re*e2;
    we     = S(x1)*gradVR(x1,y1,e1,k)*(k1+kk*norm(2*[p-pd;  v-vd]'*params.P*[zeros(3);eye(3)])*norm(wq-grv+ad)/(2*sqrt([p-pd;v-vd]'*params.P*[p-pd;v-vd])))+x1*x1'*S(x2)*gradVR(x2,y2,e2,k);
    w      = Re'*(wd-we);
    dot_R  = -Gamma(R)*R*w;
    dot_Rd = -Gamma(Rd)*Rd*wd;
    dot_xi= [dot_p;dot_v;dot_R;zeros(6,1);vd;ad;jd;dot_Rd;1];
end






    
    

