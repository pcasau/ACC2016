load params params
initial_yaw   = pi;
initial_pitch = 0;
initial_roll  = 0;
R0 = angle2dcm(initial_yaw, initial_pitch, initial_roll);
y10 = [0.5880  0.1811  0.7883]';
y20 = [0.0913 -0.0675  0.9935]';

%reference data p(t) = radi . [cos(2pi rpm t/60) sin(2pi rpm t/60) 0]'
rpm = 3;
radi= 1;
t0  = 0;
pd0  = radi*[1 0 0]';
vd0  = (2*pi*rpm/60)*radi*[0 1 0]';
ad0  = (2*pi*rpm/60)^2*radi*[-1 0 0]';

p0 = pd0+1;%x0(1:3);
v0 = vd0;%x0(4:6);
rho= (params.K*[p0-pd0;v0-vd0]-params.grv+ad0)/...
    norm(params.K*[p0-pd0;v0-vd0]-params.grv+ad0);
[Rd0,~,gm0]= closerR(params.Rstar,[],rho,[],params.r);

x0 = [p0;v0;R0(:);y10;y20;pd0;vd0;ad0;Rd0(:);t0];

save ic  x0 rpm radi
