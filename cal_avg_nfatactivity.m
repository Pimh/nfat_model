% calculate average NFAT activity based on anyalytical solution described
% in Salazar 2008

%S0 = [0.05,.1,.15,.20,.25];

delta = [21.875,29.167,35,105];

alpha_hat = 1/180;
beta = 1/480;
Ks = 0.2;
n = 3;

period_mat = [];
sensit_mat = [];

for i = 1:1
    
    S0 = .1;
    sigma = alpha_hat/beta * ((S0/Ks).^n./(1+(S0/Ks).^n));
    
    %period = [120,240,480,1440]*i;
    %omega = 1./(beta*period);
    %omega = 0:.01:3;
    omega = 1;
    
    %duty_ratio = delta./period;
    duty_ratio = 0:.01:1;
    %duty_ratio = (sqrt(1+sigma)-1)/sigma;
    X_max = sigma/(1+sigma);
    
    X_avg = X_max*(duty_ratio + omega.*sigma./(1+sigma).*(1-exp(-duty_ratio.*(1+sigma)./omega)).*...
        (1-exp((duty_ratio-1)./omega))./(1-exp(-(1+duty_ratio.*sigma)./omega)));

    sensitivity = X_avg/X_avg(end);
    
    %period_mat = [period_mat; period];
    %sensit_mat = [sensit_mat; sensitivity];
    
end

%plot(omega,X_avg,'-k')
plot(duty_ratio,X_avg,'-m')