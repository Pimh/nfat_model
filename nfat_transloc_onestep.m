function soln = nfat_transloc_onestep(tspan)
% modify 08/11/16
% Based on Salazar 2008 paper, use the two step model

global alpha_x
global beta_x
global Ytot

alpha_x = 1/60;             %[s^-1]
beta_x = alpha_x/5;         %[s^-1]
Ytot = 0.6;                 %[uM]


% initialization
y0 = [0.01]; 

[t,soln] = ode23(@diff_cal,tspan,y0);
figure(1)
plot(t,soln)
axis([0 tspan(end) 0 1])
hold on

for i = 1:length(tspan)
    ca_wave(i) = cal_calcium(tspan(i));
end
plot(t,ca_wave)


function soln = diff_cal(t,y)

global alpha_x
global beta_x
global Ytot

X = y(1);
n = 3;
Ks = 0.2;

% Calcium conc. at time t
S = cal_calcium(t);

% NFAT activation/deactivation
% dX = alpha_x*Ytot*Y*(1-X) - beta_x*X;
alpha_hat = alpha_x * Ytot;
alpha_S = alpha_hat*((S/Ks)^n/((S/Ks)^n + 1));

dX = alpha_S - alpha_S*X - beta_x*X;

soln = [dX];
