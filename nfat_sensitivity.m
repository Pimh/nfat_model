function [X_avg1,X_avg4,X_delta] = nfat_sensitivity(alpha1,beta1,Ks1,alpha4,beta4,Ks4)
% calculate average NFAT activity based on anyalytical solution described
% in Salazar 2008

%% Sensitivity analysis over oscillation frequency
n = 3;
S0 = 0.15;
factor = 0:0.01:4;
period = 10.^factor;
X_avg1 = [];
X_avg4 = [];

for i = 1:length(period)
    
    %% NFAT1 %%
    sigma1 = alpha1/beta1 * ((S0/Ks1).^n./(1+(S0/Ks1).^n));

    omega1 = 1./(beta1*period(i));
   
    % optimal duty ratio that maximizes NFAT activity
    duty_ratio1 = 0.01:0.01:1;

    X_avg1_dratio = duty_ratio1 + omega1.*sigma1./(1+sigma1).*(1-exp(-duty_ratio1.*(1+sigma1)./omega1)).*...
        (1-exp((duty_ratio1-1)./omega1))./(1-exp(-(1+duty_ratio1.*sigma1)./omega1));
    
    X_avg1 = [X_avg1; X_avg1_dratio];

    %% NFAT4 %%
    sigma4 = alpha4/beta4 * ((S0/Ks4).^n./(1+(S0/Ks4).^n));

    omega4 = 1./(beta4*period(i));

    % optimal duty ratio that maximizes NFAT activity
    duty_ratio4 = 0.01:0.01:1;

    X_avg4_dratio = duty_ratio4 + omega4.*sigma4./(1+sigma4).*(1-exp(-duty_ratio4.*(1+sigma4)./omega4)).*...
        (1-exp((duty_ratio4-1)./omega4))./(1-exp(-(1+duty_ratio4.*sigma4)./omega4));
    
    X_avg4 = [X_avg4; X_avg4_dratio];
end

X_delta = X_avg4 - X_avg1;


%% Plot average activity %%
figure(1)
hold on
title('NFAT1 sensitivity analysis')
axis([0 1 0 9])
imagesc(duty_ratio1,log(period),X_avg1); 
colormap jet;
xlabel('Duty ratio')
ylabel('log period')

figure(2)
hold on
title('NFAT4 sensitivity analysis')
axis([0 1 0 9])
imagesc(duty_ratio4,log(period),X_avg4); 
colormap jet;
xlabel('Duty ratio')
ylabel('log period')

figure(3)
hold on
title('Activity discrimination')
axis([0 1 0 9])
imagesc(duty_ratio1,log(period),X_delta); 
colormap jet;
xlabel('Duty ratio')
ylabel('log period')
