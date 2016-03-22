%Simulation parameters
params.grv = [-1 0 0]';
params.r = [1 0 0]';
params.Rstar = eye(3);
%Position Controller
A = [zeros(3),eye(3);zeros(3),zeros(3)];
B = [zeros(3);eye(3)];
C = eye(6);
D = zeros(6,3);
sys = ss(A,B,C,D);
R = eye(3);
Q = blkdiag(eye(3),0.01*eye(3));
N = zeros(6,3);
[K,P] = lqr(sys,Q,R,N);
params.K = -K;
params.P = P;
%Attitude Controller
params.kc = 1;
params.k1 = 1;
params.k2 = 1;
params.gamma = -0.5;
params.k     = 1;
params.epsl  = 0.5*(1+params.gamma)/(2/params.k+1+params.gamma);
save params params