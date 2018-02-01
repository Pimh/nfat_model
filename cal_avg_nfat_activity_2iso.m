function [X_avg1_freq,X_avg4_freq,X_avg1_S,X_avg4_S] = cal_avg_nfat_activity_2iso(alpha1,beta1,Ks1,alpha4,beta4,Ks4)
% calculate average NFAT activity based on anyalytical solution described
% in Salazar 2008

%% Sensitivity analysis over oscillation frequency
n = 3;
S0 = 0.25;
factor = 0:0.01:4;
period = 10.^factor;
freq = 1./period;

%% NFAT1 %%
sigma1 = alpha1/beta1 * ((S0/Ks1).^n./(1+(S0/Ks1).^n));

omega1 = 1./(beta1*period);

% optimal duty ratio that maximizes NFAT activity
% duty_ratio1 = (sqrt(1+sigma1)-1)/sigma1;
duty_ratio1 = (sqrt(1+sigma1)-1)/sigma1;

X_avg1_freq = duty_ratio1 + omega1.*sigma1./(1+sigma1).*(1-exp(-duty_ratio1.*(1+sigma1)./omega1)).*...
    (1-exp((duty_ratio1-1)./omega1))./(1-exp(-(1+duty_ratio1.*sigma1)./omega1));


%% NFAT4 %%
sigma4 = alpha4/beta4 * ((S0/Ks4).^n./(1+(S0/Ks4).^n));

omega4 = 1./(beta4*period);

% optimal duty ratio that maximizes NFAT activity
% duty_ratio4 = (sqrt(1+sigma4)-1)/sigma4;
duty_ratio4 = (sqrt(1+sigma4)-1)/sigma4;

X_avg4_freq = duty_ratio4 + omega4.*sigma4./(1+sigma4).*(1-exp(-duty_ratio4.*(1+sigma4)./omega4)).*...
    (1-exp((duty_ratio4-1)./omega4))./(1-exp(-(1+duty_ratio4.*sigma4)./omega4));


X_delta_freq = X_avg4_freq - X_avg1_freq;
%% Plot average activity %%
figure(1)
title('Sensitivity analysis over oscillation frequency')
plot(log10(freq),X_avg1_freq,'-b')
hold on
plot(log10(freq),X_avg4_freq,'-r')
legend('NFAT1','NFAT4')

figure(2)
title('Activity discrimination')
plot(log10(freq),X_delta_freq,'-k')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Sensitivity analysis over oscillation amplitude
S0 = 0.01:0.01:1;
period = 60;

%% NFAT1 %%
sigma1 = alpha1/beta1 * ((S0/Ks1).^n./(1+(S0/Ks1).^n));

omega1 = 1./(beta1*period);

% optimal duty ratio that maximizes NFAT activity
duty_ratio1 = (sqrt(1+sigma1)-1)/sigma1;

X_avg1_S = duty_ratio1 + omega1.*sigma1./(1+sigma1).*(1-exp(-duty_ratio1.*(1+sigma1)./omega1)).*...
    (1-exp((duty_ratio1-1)./omega1))./(1-exp(-(1+duty_ratio1.*sigma1)./omega1));


%% NFAT4 %%
sigma4 = alpha4/beta4 * ((S0/Ks4).^n./(1+(S0/Ks4).^n));

omega4 = 1./(beta4*period);

% optimal duty ratio that maximizes NFAT activity
duty_ratio4 = (sqrt(1+sigma4)-1)/sigma4;

X_avg4_S = duty_ratio4 + omega4.*sigma4./(1+sigma4).*(1-exp(-duty_ratio4.*(1+sigma4)./omega4)).*...
    (1-exp((duty_ratio4-1)./omega4))./(1-exp(-(1+duty_ratio4.*sigma4)./omega4));

X_delta_S = X_avg4_S - X_avg1_S;

figure(3)
plot(S0,X_avg1_S,'-b')
hold on
plot(S0,X_avg4_S,'-r')
legend('NFAT1','NFAT4')

figure(4)
title('Activity discrimination')
plot(S0,X_delta_S,'-k')

