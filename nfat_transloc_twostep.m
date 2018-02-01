function soln = nfat_transloc_twostep()
% modify 08/11/16
% Based on Salazar 2008 paper, use the two step model

global alpha_y
global beta_y
global alpha_x
global beta_x
global Ytot

alpha_y = 1/60; % [uM^-3 s^-1]
beta_y = 1/60;  % [s^-1]
alpha_x = 1/60; %[s^-1]
beta_x = 1/180; %[s^-1]
Ytot = 0.6; %[uM]

% Sweep parameter

% initialization
tspan = 0:0.1:6*60*60;
y0 = [0.01,0.01]; 

[t,soln] = ode23(@diff_cal,tspan,y0);
figure(1)
plot(t,soln)
axis([0 5000 0 1])
hold on

for i = 1:length(tspan)
    ca_wave(i) = cal_calcium(tspan(i));
end
plot(t,ca_wave)


function soln = diff_cal(t,y)

global alpha_y
global beta_y
global alpha_x
global beta_x
global Ytot

Y = y(1);
X = y(2);
n = 3;
Ks = 0.2;
Kx = 0.5;

% Calcium conc. at time t
S = cal_calcium(t);

% Calcineurin activation/deactivation
%dY = alpha_y*S^n*(1-Y) - beta_y*Y;
alpha_S = alpha_y*((S/Ks)^n/((S/Ks)^n + 1));
dY = alpha_S*(1-Y) - beta_y*Y;

% NFAT activation/deactivation
% dX = alpha_x*Ytot*Y*(1-X) - beta_x*X;
alpha_x_max = alpha_x * (Ytot/Kx)^n/((Ytot/Kx)^n+1);
dX = alpha_x_max*Y*(1-X) - beta_x*X;

soln = [dY; dX];
