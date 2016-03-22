global params rpm radi

load params params
load ic x0 rpm radi 
close all

%simulation horizon
TSPAN = [0 20];
JSPAN = [0 20];
%Solver options
rule = 1;
options = odeset('RelTol',1e-6);%,'MaxStep',1e-4);
% simulate
[t,j,xi] = HyEQsolver(@f,@g,@C,@D,x0,TSPAN,JSPAN,rule,options);
%% Results
p = xi(:,1:3)';
v = xi(:,4:6)';
R = reshape(xi(:,7:15)',[3,3,numel(t)]);
y1= xi(:,16:18)';
y2= xi(:,19:21)';
pd = xi(:,22:24)';
vd = xi(:,25:27)';
ad = xi(:,28:30)';
Rd = reshape(xi(:,31:39)',[3,3,numel(t)]);

%
Re = R;
dist = zeros(numel(t),1);
for I = 1:size(R,3)
    Re(:,:,I) = Rd(:,:,I)'*R(:,:,I);
    dist(I)   = trace(eye(3)-Re(:,:,I));
end
figure('units','centimeters','position',[0 0 20 20]);
h = create_axis([1 0.1 0.02 0.1],[3 0.1 0.05 0.05]);
axes(h(1))
plot(h(1),t,sqrt(sum((p-pd).^2,1)));
ylim = get(h(1),'ylim');
scl = 1.1;
set(h(1),'xticklabel','','ylim',ylim*scl-(diff(ylim*scl)-diff(ylim))/2)
grid on
ylbl = ylabel('$\norm{\pe(t)}$');
set(ylbl,'units','normalized');
ypos = get(ylbl,'position')+[-0.03 0 0];
set(ylbl,'position',ypos)
plot(h(2),t,sqrt(sum((v-vd).^2,1)));
axes(h(2))
ylim = get(h(2),'ylim');
grid on
set(gca,'xticklabel','','ylim',ylim*scl-(diff(ylim*scl)-diff(ylim))/2)
ylbl = ylabel('$\norm{\ve(t)}$');
set(ylbl,'units','normalized');
ypos2 = get(ylbl,'position');
set(ylbl,'position',[ypos(1) ypos2(2:3)])
axes(h(3))
plot(h(3),t,dist)
ylim = [0 3];
set(gca,'ylim',ylim*scl-(diff(ylim*scl)-diff(ylim))/2)
grid on
xlbl = xlabel('$t$');
set(xlbl,'units','normalized')
xpos = get(xlbl,'position');
set(xlbl,'position',xpos-[0 0.1 0 ])
ylbl = ylabel('trace($\eye{3}-\Re$)');
set(ylbl,'units','normalized');
ypos2 = get(ylbl,'position');
set(ylbl,'position',[ypos(1) ypos2(2:3)])

